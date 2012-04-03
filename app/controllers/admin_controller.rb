require File.expand_path('../../../lib/menu', __FILE__)
class AdminController < ApplicationController
  def index
    mm = MainMenu.instance
    @out_mm = mm
  end
end
