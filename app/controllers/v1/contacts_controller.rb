module V1
  class ContactsController < ApplicationController
    include ErrorSerializer
    before_action :set_contact, only: [:show, :update, :destroy]

    # GET /contacts
    def index
      page_number = params[:page].try(:[], :number)
      per_page = params[:page].try(:[], :size)
      @contacts = Contact.all.page(page_number).per(per_page)

      # expires_in 30.seconds, public: true # Cache-control
      render json: @contacts
      # paginate json: @contacts
    end

    # GET /contacts/1
    def show
      # root: true, status: :no_content (manda outro status.code), only: [:name, :email] e expect: [:email]
      render json: @contact, include: %i[kind address phones] #, meta: { author: "Caio" }
    end

    # POST /contacts
    def create
      @contact = Contact.new(contact_params)

      if @contact.save
        render json: @contact, include: [:kind, :phones, :address], status: :created, location: @contact
      else
        render json: ErrorSerializer.serialize(@contact.errors) # @contact.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /contacts/1
    def update
      if @contact.update(contact_params)
        render json: @contact, include: [:kind, :phones, :address]
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end

    # DELETE /contacts/1
    def destroy
      @contact.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_contact
        @contact = Contact.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def contact_params
        # params.require(:contact).permit(
        #   :name,
        #   :email,
        #   :birthdate,
        #   :kind_id,
        #   phones_attributes: %i[id number _destroy],
        #   address_attributes: %i[id street city]
        # )
        # Passando um atributo "_destroy" em nested_attributes você pode destruir ele a partir de outro model, no caso do contact destruindo um phone

        ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      end
  end
end