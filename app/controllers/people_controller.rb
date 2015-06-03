class PeopleController < WorkspaceController
  before_action :load_person, only: [:show, :edit, :update, :destroy]

  def index
    @people = Person
      .sort(params[:field], params[:direction])
      .page(params[:page])
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)
    if @person.save
      redirect_to @person, :notice => "Person has been successfully created."
    else
      flash.now[:alert] = "Person could not be created."
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @person.update_attributes(person_params)
      redirect_to @person, :notice => "Person has been successfully updated."
    else
      flash.now[:alert] = "Person could not be updated."
      render :edit
    end
  end

  def destroy
    @person.destroy
    redirect_to people_url,
      :notice => "Person has been successfully destroyed."
  end

  private

  def load_person
    @person = Person.friendly.find(params[:id])
  end

  def person_params
    params.require(:person).permit(
      :slug, :property,
      :first_name, :last_name,
      :country, :division, :postcode, :address, :phone, :email,
      :memo, :joined_at, :left_at)
  end
end
