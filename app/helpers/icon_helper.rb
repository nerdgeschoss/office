module IconHelper
  def avatar(user, size: 80)
    _ = size
    tag.div(
      image_tag(user.avatar_url),
      class: "avatar"
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
