# frozen_string_literal: true

module IconHelper
  def avatar(resource, size: nil)
    _ = size
    url = nil
    url = resource.image.presence&.url if resource.is_a?(Product)
    url = resource.avatar_url if resource.is_a?(User)
    status = resource.in_office? ? :online : :offline if resource.is_a?(User) && resource.devices.any?
    return unless url

    tag.div(
      image_tag(url),
      class: "avatar avatar--#{size} avatar--#{status}"
    )
  end

  def icon(name, options = {})
    classes = Array.wrap(options[:class])
    classes += ["icon", "icon--#{name}"]
    classes << "icon--small" if options.delete(:size) == :small
    image_tag "icons/#{name}.svg", options.merge(class: classes.join(" "))
  end

  def link_to_add(url, icon: :add, size: :regular)
    url = "javascript:asyncModal('#{url}')"
    content_tag "a", self.icon(icon, size: size), href: url
  end

  def link_to_add_if(url, condition, icon: :add, size: :regular)
    link_to_add(url, icon: icon, size: size) if condition
  end

  def link_to_edit(url, icon: :edit, size: :regular)
    url = edit_polymorphic_path(url) unless url.is_a?(String)
    url = "javascript:asyncModal('#{url}')"
    content_tag "a", self.icon(icon, size: size), href: url
  end

  def link_to_edit_if(url, condition = policy(url).edit?, icon: :edit, size: :regular)
    link_to_edit(url, icon: icon, size: size) if condition
  end
end
