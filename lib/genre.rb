class Genre
  extend Concerns::Findable
  attr_accessor :name, :artist, :song
  @@all =[]
  def initialize(name)
    @name=name
    @songs=[]
    #save
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

  def self.create(genre)
    genre=Genre.new(genre)
    genre.save
    genre
  end

  def songs
    @songs
  end

  def artists
    songs.collect {|song| song.artist}.uniq
  end
end