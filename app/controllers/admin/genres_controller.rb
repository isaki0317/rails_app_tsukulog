class Admin::GenresController < ApplicationController

  def index
    @genre_new = Genre.new
    @genres = Genre.all
  end

  def create
    @genre = Genre.new(genre_params)
    @genre.save
    @genres = Genre.all
  end

  private
  def genre_params
    params.require(:genre).permit(:name, :is_active)
  end

end
