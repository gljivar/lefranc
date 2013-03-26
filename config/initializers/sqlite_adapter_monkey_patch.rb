class ActiveRecord::ConnectionAdapters::SQLiteAdapter

  def quoted_true
    1 #'t'.freeze
  end

  def quoted_false
    0 #'f'.freeze
  end

end
