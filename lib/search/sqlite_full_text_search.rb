module Search
  module SqliteFullTextSearch
    extend ActiveSupport::Concern

    # Deletes the full-text search index for the current record.
    private def destroy_search_index
      # Get the primary key, table name, and foreign key from the class.
      primary_key = self.class.primary_key
      table_name = self.class.table_name
      foreign_key = self.class.to_s.foreign_key
      id_value = attributes[primary_key]

      # Construct the SQL query to delete the index.
      sql_delete = <<~SQL.strip
        DELETE FROM fts_#{table_name} WHERE #{foreign_key} = #{id_value};
      SQL
      # Execute the SQL query.
      self.class.connection.execute(sql_delete)
    end

    # Updates the full-text search index for the current record.
    private def update_search_index
      # Get the primary key, table name, and foreign key from the class.
      primary_key = self.class.primary_key
      table_name = self.class.table_name
      foreign_key = self.class.to_s.foreign_key

      search_attributes = @@search_scope_attributes.each_with_object({}) { |attr, acc|
        acc[attr] = quote_string(send(attr) || "")
      }
      id_value = attributes[primary_key]

      # Construct the SQL query to delete the existing index.
      sql_delete = <<~SQL.strip
        DELETE FROM fts_#{table_name} WHERE #{foreign_key} = #{id_value};
      SQL
      # Execute the SQL query.
      self.class.connection.execute(sql_delete)

      # Construct the SQL query to insert the new index.
      sql_insert = <<~SQL.strip
        INSERT INTO fts_#{table_name}(#{search_attributes.keys.join(", ")}, #{foreign_key})
        VALUES (#{search_attributes.values.map { |value| "'#{value}'" }.join(", ")}, #{attributes[primary_key]});
      SQL
      # Execute the SQL query.
      self.class.connection.execute(sql_insert)
    end

    # Quotes a string for use in an SQL query.
    private def quote_string(s)
      s.gsub("\\", '\&\&').gsub("'", "''")
    end

    # Code in the included block is executed in the context of the class that includes this module.
    # This allows us to use ActiveRecord callbacks and scopes.
    included do
      # Update the search index after saving the record.
      after_save_commit :update_search_index
      # Destroy the search index after deleting the record.
      after_destroy_commit :destroy_search_index

      # Define a scope for performing a full-text search.
      scope_foreign_key = to_s.foreign_key
      scope :search, ->(query) {
        return none if query.blank?

        # Construct the SQL query for the search.
        sql = <<~SQL.strip
          SELECT #{scope_foreign_key} AS id FROM fts_#{table_name}
          WHERE fts_#{table_name} MATCH '#{query}' ORDER BY rank;
        SQL

        # Execute the SQL query and get the IDs of the matching records.
        ids = connection.execute(sql).map(&:values).flatten
        # Return the matching records.
        where(id: ids)
      }
    end

    # Class methods are executed in the context of the class that includes this module.
    class_methods do
      # Defines the attributes to be included in the full-text search.
      def search_scope(*attrs)
        @@search_scope_attributes = attrs
      end

      # Rebuilds the full-text search index for the specified records, or all records if no IDs are provided.
      def rebuild_search_index(*ids)
        target_ids = Array(ids)
        target_ids = self.ids if target_ids.empty?

        scope_foreign_key = to_s.foreign_key

        # Construct the SQL query to delete the existing index.
        delete_where = Array(ids).any? ? "WHERE #{scope_foreign_key} IN (#{ids.join(", ")})" : ""
        sql_delete = <<~SQL.strip
          DELETE FROM fts_#{table_name} #{delete_where};
        SQL
        # Execute the SQL query.
        connection.execute(sql_delete)

        # For each ID, construct and execute an SQL query to insert the new index.
        target_ids.each do |id|
          record = where(id: id).pluck(*@@search_scope_attributes, :id).first
          if record.present?
            id = record.pop

            sql_insert = <<~SQL.strip
              INSERT INTO fts_#{table_name}(#{@@search_scope_attributes.join(", ")}, #{scope_foreign_key})
              VALUES (#{record.map { |value| "'#{quote_string(value)}'" }.join(", ")}, #{id});
            SQL
            connection.execute(sql_insert)
          end
        end
      end
    end
  end
end
