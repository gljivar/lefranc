class WordGender < ActiveRecord::Base
  attr_accessible :name, :short_name, :language 

  validates :name, :short_name, :presence => true

  belongs_to :language , :inverse_of => :word_genders

end
