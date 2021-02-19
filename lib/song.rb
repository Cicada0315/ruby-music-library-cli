class Song 
  attr_accessor :name, :artist, :genre
  @@all =[]
  def initialize(name, artist=nil, genre=nil)
    @name=name
    self.artist=(artist) if artist != nil
    self.genre=(genre) if genre != nil
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end 

  def save
    @@all<<self
  end

  def self.create(name)
    song=Song.new(name)
    song.save
    song
  end

  def artist=(artist)
    @artist=artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre=genre
    genre.songs << self unless genre.songs.include?(self)
  end

  def self.find_by_name(name)
    @@all.find {|song| song.name==name}
  end

  def self.find_or_create_by_name(name)
    song=self.find_by_name(name)
    if song ==nil
      song=self.create(name)
    end
    song
  end

  def self.new_from_filename(filename)
    info=filename.split(" - ")
    #info[2].gsub(".mp3", "")
    genre_name = info[2].split(".mp3").join

    artist = Artist.find_or_create_by_name(info[0])
    genre = Genre.find_or_create_by_name(genre_name)
    self.new(info[1], artist, genre)
  end

  def self.create_from_filename(filename)
    self.new_from_filename(filename).save
  end
end