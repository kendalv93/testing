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
        true if Float self.send(y) rescue self.errors.add(:nan, " #{x[i]} is not a number")
      end.all?
    end

    def includes_letters? x
      x.map{|y| y.include?('a'||'b'||'c'||'d'||'e'||'f'||'g'||'h'||'i'||'j'||'k'||'l'||'m'||'n'||'o'||'p'||'q'||'r'||'s'||'t'||'u'||'v'||'w'||'x'||'y'||'z') unless y.nil?}.any?
    end

    def is_empty? x
      x.map{|y| y.nil?}.any?
    end

    def have_dollar? x
      x.map{|y| y.include?('$') unless y.nil?}.any?
    end

    def have_0 x
      x.map{|y| y == '0'}.any?
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

    def one_or_zero x  #looking for strings equaled to 0 and 1 and not integers
      #puts x.map{|y| "#{y} #{y.to_s === "1" || y.to_s === "0"} "}
      x.map{|y| y === "0" || y === "1"}.all?
    end

    def illegal_character x
      x.map{|y| illegal_char(y) unless y.nil?}.any?

    end

    def illegal_char char
      is_illegal = the_illegal_characters.map{|z| char.is_a?(String) ? char.include?(z) : true}.any?
      is_illegal
    end

    def the_illegal_characters
      backslash = '/'
      forwardslash = "\\"
      %w{; !  " backslash forwardslash}
    end

    def valid_mains x
      x.map{|y| legal_main_ids(y) unless y.nil?}.any?
    end

    def legal_main_ids x
      legal_mains = the_legal_mains.map{|y| x.eql?(y) unless y.nil?}.any?
      legal_mains
    end

    def the_legal_mains
      %w{1000 2000 3000 4000 5000 6000 7000 8000 9000}
    end

    def valid_names x
      x.map{|y| legal_main_names(y) unless y.nil?}.any?
    end

    def legal_main_names x
      legal_mains = the_legal_names.map{|y| x.eql?(y) unless y.nil?}.any?
      legal_mains
    end

    def the_legal_names
      legal_names = ['Electronics', 'Cameras & Optics', 'Fashion', 'Household', 'Computers & Office', 'Auto & Hardware', 'Recreation & Health', 'Gifts & Collectibles', 'Footwear']
      legal_names
    end

    def must_have_value x
      x.map{|y| y.nil?}.any?
    end

    def must_have_M_and_value x
      x != nil && x[0] == 'M'
    end

    def must_be_zero x
      puts x.map{|y| "#{y} #{y.to_s === '0'}"}
      x.map{|y| y.to_s === '0'}.all?
    end
  end
end