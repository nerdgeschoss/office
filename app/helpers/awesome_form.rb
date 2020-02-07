class AwesomeForm < ActionView::Helpers::FormBuilder
  include ::NestedForm::BuilderMixin

  alias original_text_field text_field

  def form
    object if object.is_a? ApplicationForm
  end

  delegate :model, to: :form, allow_nil: true

  def text_field(method, options = {})
    apply_validations method, options
    wrap method, super(method, options), "input--text", options
  end

  def password_field(method, options = {})
    wrap method, super(method, options), "input--text", options
  end

  def number_field(method, options = {})
    apply_validations method, options
    wrap method, super(method, options), "input--text", options
  end

  def email_field(method, options = {})
    apply_validations method, options
    wrap method, super(method, options), "input--email", options
  end

  def text_area(method, options = {})
    apply_validations method, options
    wrap method, super(method, options), "input--textarea", options
  end

  def date_field(method, options = {})
    apply_validations method, options
    wrap method, original_text_field(method, options), "input--date", options
  end

  def time_field(method, options = {})
    apply_validations method, options
    wrap method, original_text_field(method, options), "input--time", options
  end

  def datetime_field(method, options = {})
    apply_validations method, options
    wrap method, original_text_field(method, options), "input--datetime", options
  end

  def select(method, values, options = {}, html_options = {})
    apply_validations method, html_options
    fuzzy = options.delete(:search)
    tagging = options.delete(:tagging)
    html_options[:disabled] = "disabled" if options.delete(:enabled) == false
    html_options[:data] ||= {}
    html_options[:data][:fuzzy] = true if fuzzy
    html_options[:data][:tagging] = true if tagging
    html_options[:multiple] = true if tagging
    wrap method, super(method, values, options, html_options), "input--select", options
  end

  def check_box(method, options = {})
    apply_validations method, options
    wrap method, super(method, options), "input--checkbox", options
  end

  def collection_select(method, collection, value_method, text_method, options = {}, html_options = {})
    apply_validations method, html_options
    fuzzy = options.delete(:search)
    tagging = options.delete(:tagging)
    html_options[:class] = [html_options[:class], "js-autosubmit"].compact.join(" ") if options.delete(:autosubmit)
    html_options[:class] = [html_options[:class], "js-select2"].compact.join(" ") if fuzzy
    html_options[:disabled] = "disabled" if options.delete(:enabled) == false
    html_options[:data] ||= {}
    html_options[:data][:fuzzy] = true if fuzzy
    html_options[:data][:tagging] = true if tagging
    wrap method, super(method, collection, value_method, text_method, options, html_options), "input--select", options
  end

  def collection_radio_buttons(method, collection, value_method, text_method, options = {}, html_options = {})
    apply_validations method, html_options
    html_options[:class] = [html_options[:class], "js-autosubmit"].compact.join(" ") if options.delete(:autosubmit)
    html_options[:disabled] = "disabled" if options.delete(:enabled) == false
    content = super(method, collection, value_method, text_method, options, html_options) do |f|
      content_tag(:div, safe_join([f.radio_button, f.label]), class: "input input--radio")
    end
    wrap method, tag.div(content, class: "input__inputs"), "input--radio-collection", options
  end

  def collection_check_boxes(method, collection, value_method, text_method, options = {}, html_options = {})
    apply_validations method, html_options
    html_options[:class] = [html_options[:class], "js-autosubmit"].compact.join(" ") if options.delete(:autosubmit)
    html_options[:disabled] = "disabled" if options.delete(:enabled) == false
    content = super(method, collection, value_method, text_method, options, html_options) do |f|
      content_tag(:div, safe_join([f.check_box, f.label]), class: "input input--checkbox")
    end
    wrap method, content, "input--checkbox-collection", options
  end

  def submit(value = nil, options = {})
    add_classes options, ["button"]
    super value, options
  end

  def submit_line(submit_title = :save, cancel_id: nil, cancel_title: :cancel)
    cancel_id ||= helper.instance_variable_get(:@current_modal_id)
    content_tag(:div,
      safe_join(
        [
          content_tag(:a, t(cancel_title), href: "javascript:closeModal()", class: "button button--link"),
          submit(t(submit_title), class: "button--link button--primary")
        ]
      ),
      class: "line line--right card__fake-footer line--center")
  end

  def file_field(method, options = {})
    apply_validations method, options
    id = SecureRandom.urlsafe_base64(16)[0..15]
    klass = ["input--file"]
    case options.delete(:type)
    when :image
      klass << "input--image"
      options[:accept] = "image/*"
    when :pdf
      options[:accept] = "application/pdf"
    end
    preview = tag(:img, id: id, class: "input__preview", src: object.try(method).try(:url))
    wrap method, super(method, options.merge(data: { preview: "##{id}" })), klass.join(" "), options.merge(content: [preview])
  end

  def link_to_add(label, association)
    super label, association, class: "panel panel--add"
  end

  def link_to_remove(label = "✕")
    super label
  end

  private

  def apply_validations(method, options)
    options.reverse_merge! required: true if object.class.try(:required_attributes)&.include?(method)
  end

  def add_classes(options, classes)
    options[:class] = ([options[:class]] + classes).compact.join(" ")
  end

  def wrap(method, content, classes, options = {})
    classes = Array.wrap(classes).compact
    if object&.errors&.[](method)&.any?
      classes << "input--error"
      errors = safe_join object.errors[method].map { |e| content_tag :div, e, class: "input__error" }
    end
    classes << "input--no-label" if options[:label] == false
    classes << "input--inline" if options[:inline] == true
    extra_lines = Array.wrap(options.delete(:content)).compact
    icon = options[:icon] ? icon(options[:icon], class: "input__icon") : nil
    inline_submit = submit("➡", class: "input__inline-submit") if options.delete(:inline_submit)
    if options[:tooltip].present?
      tooltip = content_tag(:div,
        content_tag(:div, safe_join(options[:tooltip].to_s.split("\n"), tag(:br)), class: "input__tooltip__content"),
        class: "input__tooltip")
    end
    description = content_tag :div, description_for(method, options), class: "input__description"
    lines = [icon, content, label(options[:label] || method), inline_submit, tooltip, errors, description] + extra_lines
    content_tag(:div,
      safe_join(lines.compact),
      class: ["input"] + classes)
  end

  def description_for(method, options)
    options.delete(:description) || begin
      I18n.t([:activemodel, :attributes, form.class.name.underscore, [method, :description].join("_")].join("."), raise: true)
    rescue
      nil
    end
  end

  def helper
    @template
  end

  delegate :content_tag, :t, :safe_join, :icon, :tag, to: :helper
end
