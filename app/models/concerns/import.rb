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
      end
    end



  end

  module InstanceMethods

    #exclude price on update
    def update(args)
      #deletes param if the key is :price and the object has persisted(been saved before)
      args.delete_if{|k| k.to_sym == :price && persisted?}
      super(args)
    end

    def has_errors
      raise 'has errors not overriden for model'
    end

    def are_numbers? x
      i =0
      x.map do |y|
        i += 1
        true if Float self.send(y) rescue self.errors.add(:nan, "#{x[i]} is not a number")
      end.all?
    end

    def have_dollar? x
      x.map{|y| y.include?('$') unless y.nil?}.any?
    end

    def have_0 x
      x.map{|y| y == '0'}.any?
    end

    def two_decimals x
      x.round(2)
    end

    def zero_or_one x
      x == 0 || x == 1
    end
  end
end