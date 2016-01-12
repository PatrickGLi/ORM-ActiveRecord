require_relative 'db_connect'
require_relative 'sql_object'

module Searchable
  def where(params)
    where_line = params.each.map do |k,v|
      "#{k} = ?"
    end.join(" AND ")
    # ...
    hashes = DBConnection.execute(<<-SQL, *params.values)
      SELECT
        *
      FROM
      #{self.table_name}
      WHERE
        #{where_line}
    SQL

    hashes.map { |hash| self.new(hash) }
  end
end

class SQLObject
  extend Searchable
end
