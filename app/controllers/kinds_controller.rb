class KindsController < ApplicationController
  before_action :authenticate_user!
  # include ActionController::HttpAuthentication::Basic::ControllerMethods
  # http_basic_authenticate_with name: "caio", password: "secret"

  # include ActionController::HttpAuthentication::Digest::ControllerMethods
  # USER = { "caio" => Digest::MD5.hexdigest(["caio","Application","secret"].join(":")) }

  # include ActionController::HttpAuthentication::Token::ControllerMethods
  # TOKEN = "secret123"

  # before_action :authenticate
  before_action :set_kind, only: [:show, :update, :destroy]

  # GET /kinds
  def index
    @kinds = Kind.all

    render json: @kinds
  end

  # GET /kinds/1
  def show
    render json: @kind
  end

  # POST /kinds
  def create
    @kind = Kind.new(kind_params)

    if @kind.save
      render json: @kind, status: :created, location: @kind
    else
      render json: @kind.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /kinds/1
  def update
    if @kind.update(kind_params)
      render json: @kind
    else
      render json: @kind.errors, status: :unprocessable_entity
    end
  end

  # DELETE /kinds/1
  def destroy
    @kind.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kind
      return @kind = Contact.find(params[:contact_id]).kind if params[:contact_id]

      @kind = Kind.find(params[:id])
    end

    # def authenticate
    #   # authenticate_or_request_with_http_digest("Application") do |username|
    #   #   USER[username]
    #   # end
    #   authenticate_or_request_with_http_token do |token, options|
    #     hmac_secret = 'my$ecretK3y'
    #     JWT.decode token, hmac_secret, true, { :algorithm => 'HS256' }
    #     # ActiveSupport::SecurityUtils.secure_compare(
    #     #   ::Digest::SHA256.hexdigest(token),
    #     #   ::Digest::SHA256.hexdigest(TOKEN)
    #     # )
    #   end
    # end

    # Only allow a trusted parameter "white list" through.
    def kind_params
      params.require(:kind).permit(:description)
    end
end
