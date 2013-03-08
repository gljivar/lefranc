class LanguageObject < ActiveRecord::Base
  belongs_to :language
  belongs_to :user
  belongs_to :language_object

  has_many :language_object

  attr_accessible :meaning, :text
end
