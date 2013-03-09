class Translation < ActiveRecord::Base
  belongs_to :language_object
  belongs_to :translation, :class_name => 'LanguageObject'

  attr_accessible :language_object_id, :translation_id 
end
