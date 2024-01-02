class TagsController < ApplicationController
    before_action :set_tag, only: %i[ show edit update destroy ]
    before_action :authenticate_user!, only: %i[ new create edit update destroy ]
    before_action :correct_user, only: %i[ edit update destroy ]
    before_action :correct_create_user, only: %i[ create new ]
  
    # GET /tags or /tags.json
    def index
      @tags = Tag.all
    end
  
    # GET /tags/1 or /tags/1.json
    def show
    end
  
    # GET /tags/new
    def new
      @tag = Tag.new
    end
  
    # GET /tags/1/edit
    def edit
    end
  
    # POST /tags or /tags.json
    def create
      @tag = Tag.new(tag_params)
      # redirect_to(root_url, status: :see_other, notice: "Access denied") unless current_user && current_user.admin?
  
      if @tag.valid?
        @tag.save
        render json: @tag
      else
        flash[:notice] = @tag.errors.full_messages.to_sentence
        redirect_back(fallback_location: root_path, status: :unprocessable_entity)
      end
    end
  
    # PATCH/PUT /tags/1 or /tags/1.json
    def update
      respond_to do |format|
        if @tag.update(tag_params)
          format.html { redirect_to tag_url(@tag), notice: "Tag was successfully updated." }
          format.json { render :show, status: :ok, location: @tag }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @tag.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /tags/1 or /tags/1.json
    def destroy
      @tag.destroy
  
      respond_to do |format|
        format.html { redirect_to tags_url, notice: "Tag was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_tag
        @tag = Tag.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def tag_params
        params.require(:tag).permit(:name)
      end
  
      # confirms the correct user
      def correct_user
        @tag ||= Tag.find(params[:id])
        redirect_to(root_url, status: :see_other, notice: "Access denied") unless current_user && current_user.admin?
      end
  
      # confirms the correct user
      def correct_create_user
        redirect_to(root_url, status: :see_other, notice: "Access denied") unless current_user && current_user.admin?
      end
  end
  