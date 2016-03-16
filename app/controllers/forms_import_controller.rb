class FormsImportController< ApplicationController
  rescue_from ActiveRecord::UnknownAttributeError, with: :nothing_picked

  def new
  @forms_import = FormsImport.new(params[:file], params[:row])
  end

  def index
    render :new
  end

  def show
    'NO errors have been found!'
  end

  def create
    @forms_import = FormsImport.new(params[:file], params[:row])
    if @forms_import.save
      respond_to do |format|
        format.html { redirect_to root_url, notice: "Congratulations no errors found!"}
      end
    else
      #puts "MY ERRORS: #{@forms_import.errors.map{|x| "1st: x.to_s"}}"
      respond_to do |format|
        format.html { render :new}
        format.json { render json: @forms_import.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def nothing_picked
    respond_to do |format|
    format.html { redirect_to root_url, notice: "Check to see if correct sigma or web button has been checked" }
    end
  end
end