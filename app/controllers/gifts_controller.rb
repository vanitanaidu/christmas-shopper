class GiftsController < ApplicationController

  get "/gifts" do
    @gifts = Gift.all
    if logged_in?
      erb :"gifts/gifts"
    else
    redirect to "/login"
    end
  end

  get "/gifts/new" do
    if logged_in?
    erb :"gifts/create_gift"
    else
    redirect to "/login"
    end
  end

  post "/gifts" do
    if !params[:name].empty?
      @gift = Gift.create(name: params[:name], where_to_buy: params[:where_to_buy], recipient: params[:recipient], notes: params[:notes])
      @gift.user_id = session[:user_id]
      @gift.save
      redirect to "/gifts/#{@gift.id}"
    else
      redirect to "/gifts/new"
    end
  end

  get "/gifts/:id" do

    if logged_in?
      # binding.pry
      @gift = Gift.find_by_id(params[:id])
      erb :"gifts/show_gift"
    else
      redirect to "/login"
    end
  end

  get "/gifts/:id/edit" do
    if logged_in?
      @gift = Gift.find_by_id(params[:id])
      erb :"gifts/edit_gift"
    else
      redirect to "/login"
    end
  end

  post "/gifts/:id" do
    if logged_in?
     @gift = Gift.find_by_id(params[:id])
     @gift.name = params[:name]
     @gift.where_to_buy = params[:where_to_buy]
     @gift.recipient = params[:recipient]
     @gift.notes = params[:notes]
     @gift.user_id = session[:user_id]
     @gift.save
     redirect "/gifts/#{@gift.id}"
   else
     redirect to "/login"
   end
  end


  post "/gifts/:id/delete" do
    if logged_in?
      @gift = Gift.delete(params[:id])
      redirect to '/gifts'
    else
      redirect to '/login'
    end
  end

end
