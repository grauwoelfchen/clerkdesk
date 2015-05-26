class PeopleController < WorkspaceController
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

  private

  def load_person
    @person = Person.friendly.find(params[:id])
  end

  def person_params
    params.require(:person).permit(
      :slug, :property,
      :first_name, :last_name, :zip_code, :address, :phone, :email,
      :joined_at, :left_at)
  end
end
