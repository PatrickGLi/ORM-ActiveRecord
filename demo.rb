require './lib/db_connect'
require './lib/sql_object'
require './lib/searchable'
require './lib/associatable'

class Musician < SQLObject
  self.finalize!

  has_many(:favoriteartists,
    foreign_key: :musician_id,
    class_name: "FavoriteArtist"
  )

  belongs_to(:musicgroup,
    foreign_key: :group_id,
    class_name: "MusicGroup"
  )
end

class MusicGroup < SQLObject
  self.finalize!

  has_many(:musicians,
    foreign_key: :group_id,
    class_name: "Musician"
  )
end

class FavoriteArtist < SQLObject
  self.finalize!

  belongs_to(:musician,
    foreign_key: :musician_id,
    class_name: "Musician"
  )

  has_one_through(:musicgroup, :musician, :musicgroup)
end


p "All musicians: #{Musician.all}"

p "First musician's first name: #{Musician.find(1).fname}"

p "Musician named Justin: #{Musician.where(fname: 'Justin')}"

p "Galantis's artists: #{MusicGroup.find(1).musicians}"

p "Stephen Thompson's music group: #{Musician.where(fname: 'Stephen').first.musicgroup}"

p "Galantis likes Chris Brown: #{FavoriteArtist.find(1).musicgroup}"
