class WordGendersController < ApplicationController
  before_filter :find_language, :only => [:index, :show, :edit, :update, :new, :create, :destroy ]
  before_filter :find_word_gender, :only => [:show, :edit, :update, :destroy]

  def index
	@word_genders = WordGender.find(:all, :conditions => { :language_id => @language.id })
  end

  def new
	@word_gender = WordGender.new
  end  

  def create
 	@word_gender = WordGender.new(params[:word_gender])
       	@word_gender.language = @language
	
	if @word_gender.save
  		redirect_to language_word_genders_path(@language), :notice => "New word gender was saved"
        else
		render "new"
        end

  end

  def update
	if @word_gender.update_attributes(params[:word_gender])
        	redirect_to language_word_genders_path(@language), :notice => "Word gender has been updated"
        else
        	render "edit"
        end
  end

  def destroy
	@word_gender.destroy
        redirect_to language_word_genders_path(@language), :notice => "Word gender has been deleted"
  end

  protected

  def find_word_gender
        @word_gender = WordGender.find(params[:id])
  end

  def find_language
	@language = Language.find(params[:language_id])
  end

end
