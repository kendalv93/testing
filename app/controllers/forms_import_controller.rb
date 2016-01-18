class FormsImportController< ApplicationController

  def new
  @forms_import = FormsImport.new(params[:file], params[:row])
  end

  def create

    @forms_import = FormsImport.new(params[:file], params[:row])
    if @forms_import.save
      redirect_to root_url, notice: "Imported products successfully."
    else
      puts @forms_import.errors
      respond_to do |format|
      format.html { render :new }
      format.json { render json: @forms_import.errors, status: :unprocessable_entity }
      end
    end
  end

end