class MainPagesController < ApplicationController
  before_action :redirect, only: [:home]
  
  def home
  end

  def about
  end

  def contact
  end
end
