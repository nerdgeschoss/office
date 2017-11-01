module ComponentHelper
  def modal(id:, show: false)
    @current_modal_id = id
    content = capture do # this is captured upfront to not mess up the i18n lookup path
      yield(id)
    end
    @page_modals ||= {}
    @page_modals[id] = capture do
      render layout: "components/modal", locals: { id: id, checked: show } { content }
    end
    @current_modal_id = nil
  end

  def popover(id: nil, show: false, position: :left, size: :small)
    id ||= SecureRandom.hex(6)
    render layout: "components/popover", locals: { id: id, checked: show, position: position, size: size } do
      yield(id)
    end
  end

  def header(title, date: nil, components: [], aside: nil)
    render "components/header", title: title, date: date, components: components, aside: aside
  end

  def card(title = nil, actions: [], footer: nil, variant: nil, id: nil)
    if title&.is_a?(Symbol)
      id ||= "#{title}_card"
      title = t ".#{title}"
    end
    variant ||= :sheet if @current_modal_id
    content = capture { yield } if block_given?
    render "components/card", title: title, actions: actions.compact, content: content, footer: footer, variant: variant, id: id
  end

  def searchbox(name, anchor: nil, method: :get)
    content_tag(:div,
      form_tag(url_for(anchor: anchor), method: method) do
        search_field_tag(name, params[name])
      end,
      id: "searchBox")
  end

  def wizard_slide(name, active: false)
    content = capture { yield } if block_given?
    safe_join [
      tag(:input, name: :wizard, type: :radio, id: name, class: "wizard__check", checked: active),
      content_tag(:div, content, class: "wizard__slide")
    ]
  end

  def status_donut(event, size: :inline)
    react_component "StatusDonut", size: size, segments: event.status_chart_numbers
  end

  def breadcrumbs(breadcrumbs = {})
    @breadcrumbs = breadcrumbs.select { |_, v| v.present? }
  end

  def tab(name, path:)
    classes = ["tabs__tab"]
    classes << "active" if current_page?(path)
    # a.tabs__tab class=("active" if current_page?(path)) href=path = name
    tag.a(name, class: classes.join(" "), href: path)
  end
end
