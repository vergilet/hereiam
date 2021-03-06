class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.all
    @hash = Gmaps4rails.build_markers(@topics) do |topic, marker|
      marker.lat topic.latitude
      marker.lng topic.longitude
      marker.title topic.title
      marker.infowindow topic.description
    end
  end

  def my_location
    coordinates = params[:my_location]
    return if coordinates.blank?
    @near_topics = Topic.near(
      [coordinates['latitude'], coordinates['longitude']],
      coordinates['range'],
      :units => :km
    )
    render json: @near_topics
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
  end

  # GET /topics/new
  def new
    @topic = Topic.new()
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(topic_params)

    respond_to do |format|
      if @topic.save
        format.html { redirect_to @topic, notice: 'Topic was successfully created.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: 'Topic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      new_params = params.require(:topic).permit(:latitude, :longitude, :address, :description, :title)
      new_params[:latitude] = randomize_location(params[:topic][:latitude])
      new_params[:longitude] = randomize_location(params[:topic][:longitude])
      new_params
    end

    def randomize_location location
       result = location.to_s[0..6] + rand(0..99).to_s
       result
    end


end
