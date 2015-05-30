class PeopleController < WorkspaceController
  before_action :load_person, only: [:show, :edit, :update, :destroy]

  def index
    @people = Person.all.page(params[:page])
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
  end

  def destroy
  end

  private

  def load_person
    @person = Person.friendly.find(params[:id])
  end

  def person_params
    params.require(:person).permit(
      :slug, :property,
      :first_name, :last_name,
      :country, :division, :postcode, :address,
      :phone, :email,
      :joined_at, :left_at)
  end
end
