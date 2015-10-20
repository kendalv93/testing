module Import
  extend ActiveSupport::Concern

  module ClassMethods
    require 'csv'
    def import(file, form_id)
      CSV.foreach(file.path, headers: headers) do |row|
        puts row.inspect
        product_hash = row.to_hash
        product = find_or_initialize_by(id: product_hash['id'], form_id: form_id)
        product.update(product_hash)
        product.save
      end # end CSV.foreach
    end # end self.import(file)

  end

module InstanceMethods
  def is_correct()

  end

  #exclude price on update
  def update(args)
    #deletes param if the key is :price and the object has persisted(been saved before)
    args.delete_if{|k| k.to_sym == :price && persisted?}
    super(args)
  end
end
end