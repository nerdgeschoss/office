module IconHelper
  def avatar(resource, size: nil)
    _ = size
    url = nil
    url = resource.image.presence&.url if resource.is_a?(Product)
    url = resource.avatar_url if resource.is_a?(User)
    return unless url
    tag.div(
      image_tag(url),
      class: "avatar avatar--#{size}"
    )
  end

  def icon(name, options = {})
    classes = Array.wrap(options[:class])
    classes += ["icon", "icon--#{name}"]
    classes << "icon--small" if options.delete(:size) == :small
    image_tag "icons/#{name}.svg", options.merge(class: classes.join(" "))
  end

  def edit_if(name, condition = true, icon: :edit)
    if condition
      content_tag "label", self.icon(icon), for: name
    else
      content_tag "label", self.icon(:lock)
    end
  end

  def add_if(name, condition = true, icon: :add)
    content_tag "label", self.icon(icon), for: name if condition
  end
end
