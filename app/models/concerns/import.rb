module Import
  extend ActiveSupport::Concern

  module ClassMethods
    require 'csv'

    def import(file, form_id)
      CSV.foreach(file.path, headers: headers) do |row|
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
      args.delete_if{|k| !k.nil? && k.to_sym == :price && persisted?}
      super(args)
    end

    def has_errors
      raise 'has errors not overriden for model'
    end

    def are_numbers? x
      i =0
      x.map do |y|
        i += 1
        true if Float self.send(y) rescue self.errors.add(:This_must_be_a_number, " : Found [[#{x[i]}]] - [#{self.send(y)}]")
      end.all?
    end

    def include_letters? x
       x.include?('a'||'b'||'c'||'d'||'e'||'f'||'g'||'h'||'i'||'j'||'k'||'l'||'m'||'n'||'o'||'p'||'q'||'r'||'s'||'t'||'u'||'v'||'w'||'x'||'y'||'z') unless x.nil?
    end

    #def is_empty? x
    #  x.map{|y| y.nil?}.any?
    #end

    def is_empty? x
      x.to_s=='' || x.nil?
    end

    #def have_dollar? x
    #  x.map{|y| y.include?('$') unless y.nil?}.any?
    #end

    def have_dollar? x
      x.to_s.include?('$')
    end

    def round_2 x

    end

    def have_0 x
      x.map{|y| y == '0'}.any?
    end

    def contains_0? x
      x == '0'
    end

    def contains_dollar? x
      x.include?('?') unless x.nil?
    end

    def have_one x
      x.map{|y| y == '1'}.any?
    end

    def two_decimals x
      x.round(2)
    end

    def two_numbers_follow x
      x.map{|y| /((?=:).+)/ unless y.nil?}.any?
    end

    #def zero_or_one x
    #  x == 0 || x == 1
    #end

    #def one_or_zero x  #looking for strings equaled to 0 and 1 and not integers
    #  #puts x.map{|y| "#{y} #{y.to_s === "1" || y.to_s === "0"} "}
    #  x.map{|y| y === "0" || y === "1"}.all?
    #end

    def zero_or_one x
      x.to_s==="0" || x.to_s==="1"
    end

    def illegal_character x
      x.map{|y| illegal_char(y) unless y.nil?}.any?
    end

    def illegal_char char
      cell = send(char)
      is_illegal = the_illegal_characters.map{|z| cell.is_a?(String) && cell != '' ? cell.include?(z) : false}.any?
      if is_illegal
        self.errors.add(:An_illegal_character_has_been_found_in, " : [[#{char}]] - [#{cell}]")
      end
      is_illegal
    end


    def the_illegal_characters
      backslash = "/"
      forward = "\\"
      [';', '!', '"', forward, '$', '\'']
    end

    #def must_have_value x
    #  x.map{|y| y.nil?}.any?
    #end

    def must_have_value x
      x.to_s!='' || x==''
    end


    #def have_values? x
    #  i =0
    #  x.map do |y|
    #    i += 1
    #    val = send(y)
    #    if val.nil? || val.empty?
    #      errors.add(:No_value_found, ": #{y} is nil: #{val}")
    #      false
    #    else
    #      true
    #    end
    #  end.all?
    #end

    #method is used for SigmaRow compare_price and wholesale_price are both headers inside SigmaRow ONLY
    def values? x
      i =0
      x.map do |y|
        i += 1
        val = send(y)
        if val.nil? || val==''
          errors.add(:You_need_a_value_at, ": Found [[#{y}]] - [#{val}]") unless y=='compare_price' || y=='wholesale_price'
          false
        elsif y=='compare_price' || y=='wholesale_price'
          errors.add(:This_needs_to_be_a_real_number, ": Found [[#{y}]] -  [#{val}]") if val.include?('a'||'b'||'c'||'d'||'e'||'f'||'g'||'h'||'i'||'j'||'k'||'l'||'m'||'n'||'o'||'p'||'q'||'r'||'s'||'t'||'u'||'v'||'w'||
                                                                                                'x'||'y'||'z'||'-') || (val.include?('-') || val.include?('..'))
          false
        else
          true
        end
      end.all?
    end



    def must_have_M_and_value x
      x != nil && x[0] == 'M'
    end

    #def must_be_zero x
    #  i=0
    # x.map{|y, i|i+1; y.to_s != '0' unless y.nil? } rescue self.errors.add(:bad, "#{x[i]}")
    #end

    def must_be_zero x
      x.to_s==="0"
    end


  end
end