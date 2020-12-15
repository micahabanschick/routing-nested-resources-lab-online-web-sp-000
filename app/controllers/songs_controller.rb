class SongsController < ApplicationController
  def index
    # binding.pry
    artist = Artist.find_by(id: params[:artist_id])
    if artist && params[:artist_id]# && params[:artist_id] == params[:artist_id].to_i
      @songs = artist.songs
    elsif !artist && params[:artist_id]
      flash[:alert] = "Artist not found."
      redirect_to artists_path
    else
      @songs = Song.all
    end

  end

  def show
    # binding.pry
    artist = Artist.find_by(id: params[:artist_id])
    @song = Song.find_by(id: params[:id])
    if artist && params[:artist_id] && @song
      @song = Artist.find_by(id: params[:artist_id]).songs.find_by(id: params[:id])
    elsif artist && params[:artist_id] && !@song
      flash[:alert] = "Song not found."
      redirect_to artist_songs_path(params[:artist_id])
    end
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end
