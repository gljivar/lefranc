class LanguagesController < ApplicationController
	before_filter :find_language, :only => [:show, :edit, :update, :destroy]	

	def index
		@languages = Language.all			
	end

	def show
	end

	def new
		@language = Language.new	
	end

	def create
		@language = Language.new(params[:language])
	
		if @language.save	
			redirect_to languages_path, :notice => "Your post was saved"	
		else
			render "new"	
		end
	end

	def edit
	end

	def update
		if @language.update_attributes(params[:language])	
			redirect_to languages_path, :notice => "Language has been updated"
		else
			render "edit"
		end	
	end

	def destroy
		@language.destroy
		redirect_to languages_path, :notice => "Language has been deleted"	
	end
	
	protected
	
	def find_language
		@language = Language.find(params[:id])
	end
end
