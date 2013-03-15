class LanguageObject < ActiveRecord::Base
  # Self referential association
  # Parent of translatable objects 
 
  belongs_to :translatable, :polymorphic => true, :dependent => :destroy
 
  belongs_to :language
  belongs_to :user
  belongs_to :lesson

  has_many :translations
  has_many :language_objects, :through => :translations

  #FIXME: Not working
  has_many :inverse_translations, :class_name => "Translation", :foreign_key => "translation_id"
  has_many :inverse_language_objects, :through => :inverse_translations, :source => :language_object

  attr_accessible :meaning, :text, :translations
end
