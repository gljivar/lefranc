class ActiveRecord::ConnectionAdapters::SQLiteAdapter

  #This is here because Sqlite3 doesn't support 'f' as representation of false. And Rails uses that. Sqlite3 needs 0 and 1 for true and false, everything else is true for it.

QUOTED_TRUE, QUOTED_FALSE = '1'.freeze, '0'.freeze

def quoted_true
  QUOTED_TRUE
end

def quoted_false
  QUOTED_FALSE
end


#  def quoted_true
#    '1'
#  end

#  def quoted_false
#    '0'
#  end

end
