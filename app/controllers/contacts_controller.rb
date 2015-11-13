class ContactsController < WorkspaceController
  before_filter :xhr_only,    only: [:search]
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  def index
    @contacts = Contact
      .sort(params[:field], params[:direction])
      .page(params[:page])
  end

  def search
    @contacts = Contact.select(:id, :slug, :name)
    if params[:term]
      @contacts = @contacts.search(params[:term], :slug, :name)
    end
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      redirect_to(@contact,
        :notice => 'Contact has been successfully created.')
    else
      flash.now[:alert] = 'Contact could not be created.'
      render(:new)
    end
  end

  def show
  end

  def edit
  end

  def update
    if @contact.update_attributes(contact_params)
      redirect_to(@contact,
        :notice => 'Contact has been successfully updated.')
    else
      flash.now[:alert] = 'Contact could not be updated.'
      render(:edit)
    end
  end

  def destroy
    @contact.destroy
    redirect_to(contacts_url,
      :notice => 'Contact has been successfully destroyed.')
  end

  private

  def xhr_only
    not_found = {
      :file   => Rails.public_path.join('404.html'),
      :layout => false,
      :status => 404
    }
    render(not_found) unless request.xhr?
  end

  def set_contact
    @contact = Contact.friendly.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(
      :slug, :property, :name,
      :country, :division, :postcode, :address, :phone, :email, :memo)
  end
end
