class Language < ActiveRecord::Base
  attr_accessible :english_name, :name
  
  has_many :word_genders , :inverse_of => :language

  validates :name, :english_name, :presence => true
  validates :name, :length => { :minimum => 2 }
  validates :name, :uniqueness => true
end
