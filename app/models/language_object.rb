class LanguageObject < ActiveRecord::Base
  # Self referential association

  belongs_to :language
  belongs_to :user

  has_many :translations
  has_many :language_objects, :through => :translations

  attr_accessible :meaning, :text, :translations
end
