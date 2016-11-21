class ItemsController < ApplicationController

  def show
    @item = content_items.find{|item| item[:id] == params[:id].to_i}
    render layout: "client"
  end

end