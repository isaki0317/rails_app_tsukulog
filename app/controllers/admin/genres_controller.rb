class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!

  def index
    @genre_new = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
    end
    @genres = Genre.all
  end

  private
  def genre_params
    params.require(:genre).permit(:name, :is_active)
  end

end
