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


  #exclude price on update
  def update(args)
    #deletes param if the key is :price and the object has persisted(been saved before)
    args.delete_if{|k| k.to_sym == :price && persisted?}
    super(args)
  end
end









  module TheRules
    def is_number?
      self.to_f.to_s == self.to_s || self.to_i.to_s == self.to_s
    end
  end


  def has_dollar?
    self.include? '$'
  end

  def has_0
    self.include? '0'
  end


  def two_decimals
    self.round(2)
  end





  module CheckingForErrors

def reading_out_errors

error_num = 0

  def number?
    if headers.is_number?
      error_num = 0
    else
      reading_out_errors = 1
    end
  end



  def has_dollar_and_0
    if has_dollar? || has_0
#leaving blank so if true do nothing
    else
      'Error: Dollar sign or 0 has been found'
    end
  end



  def not_empty_no_dollar
    if  self.to_s == ''
#leaving blank so if true do nothing
    else
      if self.has_dollar_and_0
        two_decimals
      else

      end

    end
  end


  def has_dollarsign
    if has_dollar?

    end
  end


  error_num = 0
  is_error = 100

    while is_error == 100
      if error_num == 1
        puts 'Error: ' + headers + ' is not a number'
        is_error = 100
      elsif error_num == 2
        puts 'Error: ' + headers + ' contains a $ sign'
        is_error = 100
      elsif error_num == 3
        puts 'Error: ' + headers + ' contains a $ sign or a 0'
        is_error = 100
      elsif error_num == 4
        puts 'Error: ' + headers + ' must be a 0 or a 1'
        is_error = 100
      elsif error_num == 5
        puts 'Error: ' + headers + ' cannot be empty'
        is_error = 100
      elsif error_num == 0
        puts 'Upload successful!'
        is_error = 101
      end
    end




      end
  end

end