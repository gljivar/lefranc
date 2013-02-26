class WordGendersController < ApplicationController
  def index
 	@language = Language.find(params[:language_id])
#	@word_genders = WordGender.by_language(@language.id) if @language.id 
	@word_genders = WordGender.find(:all, :conditions => { :language_id => @language.id })

  end

  def show
	
  end

  def new
	@language = Language.find(params[:language_id])
	@word_gender = WordGender.new
	@word_gender.language = @language
  end  
end
