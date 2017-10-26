module MenuHelper
  def menu_item(item:, level: 0)
    if item.category?
      content = []
      content << icon(item.icon, class: "menu__item__icon") if item.icon
      content << t("menu.items.#{item.slug}")
      content << tag.div(class: "menu__item__disclosure") if item.items.any?
      links = [tag.a(safe_join(content), class: "menu__item menu__item--category", href: item.url)]
      safe_join links + item.items.map { |e| menu_item(item: e, level: level + 1) }
    else
      classes = ["menu__item"]
      classes << "menu__item--padded" if level > 0
      classes << "active" if current_page? item.url
      tag.a t("menu.items.#{item.slug}"), class: classes, href: item.url
    end
  end
end
