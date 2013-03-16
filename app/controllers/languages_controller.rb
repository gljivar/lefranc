class LanguagesController < ApplicationController
	before_filter :find_language, :only => [:show, :edit, :update, :destroy]	

	def index
		@languages = Language.all

                respond_to do |format|
                    format.html
                    format.json { render :json => @languages}
                end
	end

	def show
            @language = Language.find(params[:id])

            respond_to do |format|
                format.html
                format.json { render :json => @language }
            end
	end

	def new
		@language = Language.new	
	end

	def create
		@language = Language.new(params[:language])

                respond_to do |format|
                    if @language.save
                        format.html { redirect_to(@language,
                                        :notice => "Language was successfully created.") }
                        format.json { render :json =>@language,
                                        :status => :created, :location => @language }
		    else
			format.html { render :action => "new" }
                        format.json { render :json => @language.errors,
                                        :status => :unprocessable_entity }
                    end
		end
	end

	def edit
	end

	def update
                respond_to do |format|
        		if @language.update_attributes(params[:language])
                            format.html { redirect_to languages_path,
                                            :notice => "Language has been updated" }
                            format.json { head :no_content }
        		else
                            format.html { render :action => "edit" }
        			format.json { render :json => @language.errors,
                                                :status => :unprocessable_entity }
		        end	
                end
	end

	def destroy
		@language.destroy

                respond_to do |format|
                    format.html { redirect_to languages_path,
                                    :notice => "Language has been deleted" }
                    format.json { head :no_content }
                end
	end
	
	protected
	
	def find_language
		@language = Language.find(params[:id])
	end
end
