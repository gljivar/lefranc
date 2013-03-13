load 'lib/translatable.rb'

class ActiveRecord::Base
  def self.acts_as_language_object
   include Translatable
  end
end
