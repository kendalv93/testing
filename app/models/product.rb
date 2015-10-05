class Product < ActiveRecord::Base
  require 'csv'

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      puts row.inspect
      product_hash = row.to_hash
      product = Product.find_or_initialize_by(id: product_hash['id'])

      product.update(product_hash)
      product.save
    end # end CSV.foreach
  end # end self.import(file)


  #exclude price on update
  def update(args)
    #deletes param if the key is :price and the object has persisted(been saved before)
    args.delete_if{|k| k.to_sym == :price && persisted?}
    super(args)
  end










end # end class