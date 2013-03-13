class Word < ActiveRecord::Base
  acts_as_language_object
 
  belongs_to :word_gender
  # attr_accessible :title, :body
end
