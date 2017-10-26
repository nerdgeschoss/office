class MenuItemBuilder
  attr_reader :scope
  def initialize(scope)
    @scope = scope
  end

  def build
    [dashboard, kiosk, teams, users]
  end

  private

  def path(name, _params = {})
    Rails.application.routes.url_helpers.send "#{name}_path"
  end

  def dashboard
    # i18n-tasks-use t('menu.items.dashboard')
    MenuItem.new slug: "dashboard", icon: :home, url: path(:root), items: []
  end

  def kiosk
    # i18n-tasks-use t('menu.items.kiosk')
    MenuItem.new slug: "kiosk", icon: :ticket, url: path(:root), items: []
  end

  def teams
    # i18n-tasks-use t('menu.items.teams')
    MenuItem.new(slug: "teams", url: path(:teams))
  end

  def users
    # i18n-tasks-use t('menu.items.users')
    MenuItem.new(slug: "users", url: path(:users))
  end
end

class MenuItem
  attr_reader :slug
  attr_reader :url
  attr_reader :items
  attr_reader :enabled
  attr_reader :icon

  def self.restricted(scope)
    MenuItemBuilder.new(scope).build.map do |category|
      next nil unless Pundit.policy(scope, category).show?
      category.items&.map! { |e| Pundit.policy(scope, e).show? ? e : nil }&.compact!
      category
    end.compact
  end

  def initialize(params = {})
    @slug = params[:slug]
    @url = params[:url]
    @icon = params[:icon]
    @enabled = params[:enabled] != false
    @items = params[:items]
  end

  def category?
    items
  end
end
