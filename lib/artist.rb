class Artist
  extend Concerns::Findable
  attr_accessor :name
  @@all=[]
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
 
  def self.create(name)
    #Artist.new(name).save #since this is class method this will create nested array
    artist=Artist.new(name)
    artist.save
    artist
  end

  def songs
    @songs
  end

  def add_song(song)
    song.artist = self if song.artist == nil
    @songs << song unless @songs.include?(song)
    song
  end

  def genres
    songs.collect {|song| song.genre}.uniq
  end
end