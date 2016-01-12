require_relative 'db_connect'
require 'active_support/inflector'

class SQLObject
  def initialize(params = {})
    params.each do |k, v|
      symbolized_key = k.to_sym
      raise "unknown attribute '#{symbolized_key}'" unless self.class.columns.include?(symbolized_key)
      self.send("#{symbolized_key}=", v)
    end
  end

  def self.table_name= (name)
    @table_name = name
  end

  def self.table_name
    @table_name ||= "#{self}".tableize
  end

  def self.columns
    @columns ||= DBConnection.execute2(<<-SQL).first
      SELECT
        *
      FROM
        #{table_name}
    SQL
    .map(&:to_sym)
  end

  def self.all
    hashes = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL

    parse_all(hashes)
  end

  def self.find (id)
    results = DBConnection.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        #{table_name}.id = ?
    SQL

    return nil if results.nil?
    parse_all(results).first
  end

  def insert
   columns = self.class.columns.drop(1)
   col_names = columns.map(&:to_s).join(", ")
   question_marks = (["?"] * columns.count).join(", ")

   DBConnection.execute(<<-SQL, *attribute_values.drop(1))
     INSERT INTO
       #{self.class.table_name} (#{col_names})
     VALUES
       (#{question_marks})
   SQL

   self.id = DBConnection.last_insert_row_id
 end

 def update
   set_line = self.class.columns
     .map { |attr| "#{attr} = ?" }.join(", ")

   DBConnection.execute(<<-SQL, *attribute_values, id)
     UPDATE
       #{self.class.table_name}
     SET
       #{set_line}
     WHERE
       #{self.class.table_name}.id = ?
   SQL
 end

 def save
   id.nil? ? insert : update
 end

  def self.parse_all (results)
    results.map { |result| self.new(result) }
  end

  def self.finalize!
    columns.each do |column_name|
      define_method "#{column_name}=" do |val|
        attributes[column_name] = val
      end
      define_method column_name do
        attributes[column_name]
      end
    end
  end

  def attribute_values
    self.class.columns.map { |column| self.send(column) }
  end

  def attributes
    @attributes ||= {}
  end
end
