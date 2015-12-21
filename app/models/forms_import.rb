class FormsImport
  include ActiveModel::Model
  require 'csv'
  def hashify
    products = []
    form = Form.new(csv_type: @row)
    form.save
    CSV.foreach(@file.path, headers: find_row.headers) do |row|
      puts row.inspect
      product_hash = row.to_hash
      puts product_hash
      product = find_row.new
      product.update(product_hash)
      products<< product


    end
    products
  end

  def find_row
    case @row
      when 'cosmo_sigma'
        CosmoSigmaRow
      when 'cosmo_web'
        CosmoWebRow
    end
  end

  def initialize(file,  row)
    @file = file
    @row = row


  end

  def save
    @forms = hashify
    if @forms.map(&:has_errors).all?
      @forms.each(&:save!)
      true
    else
      @forms.each_with_index do |product, index|
        product.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end

  def new


    redirect_to root_url, notice: "Products imported."
  end





end