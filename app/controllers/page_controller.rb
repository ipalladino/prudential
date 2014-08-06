class PageController < ApplicationController
  layout "pages"
  def index
    @name = "home"
  end

  def investments
    @name = "investments"
  end

  def portfolio
    @name = "portfolio"
  end

  def contact
    @name = "contact"
  end
end
