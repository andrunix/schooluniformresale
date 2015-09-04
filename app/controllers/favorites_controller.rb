class FavoritesController < ApplicationController

  def create
    @favorite = current_user.favorites.build(item_id: params[:item_id])

    if (@favorite.save)
      flash[:notice] = "Item saved to favorites"
      redirect_to item_path(params[:item_id])
    else
      flash[:notice] = "Unable to save to favorites"
      redirect_to root_url
    end

  end

  def destroy
    @favorite = Favorite.find(params[:id])
    item_id = @favorite.item_id
    @favorite.destroy
    flash[:notice] = "Item removed from favorites"
    redirect_to item_path(item_id)
  end

end
