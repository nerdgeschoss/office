# frozen_string_literal: true

module MetaHelper
  def title(title)
    content_for :title do
      [title, "Office"].flatten.join(" | ")
    end
  end
end
