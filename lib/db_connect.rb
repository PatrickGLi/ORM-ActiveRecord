require 'sqlite3'

PRINT_QUERIES = ENV['PRINT_QUERIES'] == 'true'
ROOT_FOLDER = File.join(File.dirname(__FILE__), '..')
ARTISTS_SQL_FILE = File.join(ROOT_FOLDER, 'artists.sql')
ARTISTS_DB_FILE = File.join(ROOT_FOLDER, 'artists.db')

class DBConnection
  def self.open(db_filename)
    @db = SQLite3::Database.new(db_filename)
    @db.results_as_hash = true
    @db.type_translation = true

    @db
  end

  def self.reset
    commands = [
      "rm '#{ARTISTS_DB_FILE}'",
      "cat '#{ARTISTS_SQL_FILE}' | sqlite3 '#{ARTISTS_DB_FILE}'"
    ]

    commands.each { |command| `#{command}` }
    DBConnection.open(ARTISTS_DB_FILE)
  end

  def self.instance
    reset if @db.nil?

    @db
  end

  def self.execute(*args)
    print_query(*args)
    instance.execute(*args)
  end

  def self.execute2(*args)
    print_query(*args)
    instance.execute2(*args)
  end

  def self.last_insert_row_id
    instance.last_insert_row_id
  end

  private

  def self.print_query(query, *interpolation_args)
    return unless PRINT_QUERIES

    puts '--------------------'
    puts query
    unless interpolation_args.empty?
      puts "interpolate: #{interpolation_args.inspect}"
    end
    puts '--------------------'
  end

end
