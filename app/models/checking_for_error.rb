class CheckingForError < ActiveRecord::Base



  module TheRules

    def is_number?
      self.to_f.to_s == self.to_s || self.to_i.to_s == self.to_s
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

    def zero_or_one
      self == 0 || self == 1
    end

    def cannot_be_empty
      self == ''
    end


  end




  module CheckingForErrors


    


      def errorchecker
        is_error = 100

        list_of_errors = []

        while is_error == 100
          if headers == product_weight || package_weight || box_length || box_width || box_height
            self.is_number?
            puts 'Error: ' + headers + ' is not a number. ' >> list_of_errors
            is_error = 100
          elsif headers == compare_price || wholesale_price
            self.has_dollar?
            puts 'Error: ' + headers + ' contains a $ sign. ' >> list_of_errors
            is_error = 100
          elsif headers == hla_cost || hla_retail || msrp || map
            self.has_dollar? || self.has_0
            puts 'Error: ' + headers + ' contains a $ sign or a 0. ' >> list_of_errors
            is_error = 100
          elsif headers == ca_prop_65
            self.zero_or_one
            puts 'Error: ' + headers + ' must be a 0 or a 1. ' >> list_of_errors
            is_error = 100
          elsif headers == product_weight || package_weight || box_length || box_width || box_height ||
              hla_cost || hla_retail || msrp || map || ca_prop_65
            self.cannot_be_empty
            puts 'Error: ' + headers + ' cannot be empty. ' >> list_of_errors
            is_error = 100
          elsif
          puts list_of_errors
            is_error = 101

          end
        end
      end

  end



end
