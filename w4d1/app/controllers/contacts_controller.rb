class ContactsController < ApplicationController

  include ContactsHelper

  def index
    @contacts = Contact.find_by(:user_id => params[:user_id])

    user = User.find(params[:user_id])
    @shared_contacts = user.shared_contacts
    
    render json: @shared_contacts << @contacts
  end

  def show
    @contact = Contact.find(params[:id])
    render json: @contact
  end

  def update
    @contact = Contact.find(params[:id])

    if @contact.update(contact_params)
      render json: @contact
    else
      render(json: @contact.errors.full_messages, status: :unprocessable_entity)
    end
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      render json: @contact
    else
      render(json: @contact.errors.full_messages, status: :unprocessable_entity)
    end
  end


  def destroy
    @contact = Contact.find(params[:id])

    if Contact.destroy(@contact)
      render json: @contact
    else
      render json: @contact.errors.full_messages, status: :unprocessable_entity
    end

  end

end
