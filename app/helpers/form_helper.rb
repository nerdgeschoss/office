module FormHelper
  def awesome_form_for(record, options = {}, &block)
    options[:builder] = AwesomeForm
    options[:remote] = true unless options.has_key?(:remote)
    options.deep_merge! html: { class: [options[:html].try(:[], :class).presence, "form"].compact.join(" ") }
    form_for(record, options, &block).to_s << after_nested_form_callbacks
  end

  def awesome_form_with(model: nil, scope: nil, url: nil, format: nil, **options, &block)
    options[:builder] = AwesomeForm
    form_with(model: model, scope: scope, url: url, format: format, **options, &block).to_s << after_nested_form_callbacks
  end
end
