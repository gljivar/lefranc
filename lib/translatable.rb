module Translatable

  def self.included(base)
   base.has_one :language_object, :as => :translatable, :autosave => true
   base.validate :language_object_must_be_valid
   base.alias_method_chain :language_object, :autobuild
   base.extend ClassMethods
   base.define_language_object_accessors
  end

  def language_object_with_autobuild
   language_object_without_autobuild || build_language_object
  end

  def method_missing(meth, *args, &blk)
   language_object.send(meth, *args, &blk)
  rescue NoMethodError
   super
  end 
  
  module ClassMethods
   def define_language_object_accessors
    all_attributes = LanguageObject.content_columns.map(&:name)
    ignored_attributes = ["created_at", "updated_at", "translatable_type"]
    attributes_to_delegate = all_attributes - ignored_attributes
    attributes_to_delegate.each do |attrib|
     class_eval <<-RUBY
      def #{attrib}
       language_object.#{attrib}
      end

      def #{attrib}=(value)
       self.language_object.#{attrib} = value
      end

      def #{attrib}?
       self.language_object.#{attrib}?
      end
     RUBY
    end
   end
  end 
  
 protected
  def language_object_must_be_valid
   unless language_object.valid?
    language_object.errors.each do |attr, message|
     errors.add(attr, message)
    end
   end 
  end
 end

