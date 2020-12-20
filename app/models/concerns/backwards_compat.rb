module BackwardsCompat
  extend ActiveSupport::Concern

  class_methods do
    def qcn(string)
      connection.quote_column_name(string)
    end

    def qtn(string)
      connection.quote_table_name(string)
    end
    
    def qtcn(string)
      "#{self.quoted_table_name}.#{connection.quote_column_name(string)}"
    end
  end
end
