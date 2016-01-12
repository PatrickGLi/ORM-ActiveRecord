require './lib/db_connect'
require './lib/sql_object'
require './lib/searchable'

class Musician < SQLObject
  self.finalize!
end

class MusicGroup < SQLObject
  self.finalize!
end

class FavoriteArtist < SQLObject
  self.finalize!
end


p "All musicians: #{Musician.all}"

p "First musician's first name: #{Musician.find(1).fname}"

p "Musician named Justin: #{Musician.where(fname: 'Justin')}"
