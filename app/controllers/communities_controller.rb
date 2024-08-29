class CommunitiesController < ApplicationController
  before_action :set_community, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[ index show ]

  def index
    @communities = Community.all
  end

  def show; end

  def new
    @community = current_user.communities.build
  end

  def edit; end

  def create
    @community = current_user.communities.build(community_params)

    if @community.save
      redirect_to community_url(@community), notice: "Community was successfully created."
    else
      render :new, status: :unprocessable_entity
     end
  end

  def update

    if @community.update(community_params)
      redirect_to community_url(@community), notice: "Community was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @community.destroy
    redirect_to communities_url, notice: "Community was successfully destroyed."
  end

  private
    def set_community
      @community = Community.find(params[:id])
    end

    def community_params
      params.require(:community).permit(:name, :title, :description, :sidebar)
    end
end
