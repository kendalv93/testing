class CheckingForErrorsController < ApplicationController

  #a real number or decimal
  def is_number?
    self.to_f.to_s == self.to_s || self.to_i.to_s == self.to_s
  end

  def number?
    if headers.is_number?

      else
    end
  end


  class A
    attr_accessor :prod_weight, :pack_weight, :box_length, :box_width, :box_height, :hla_cost,
                  :hla_retail, :msrp, :compare_price, :wholesale_price, :map, :ca_prop_65, :overwight_shipcharge,
                  :errorState
    def new()
      @prod_weight = 10
      @pack_weight = 11
      @box_length = 12
      @box_width = 13
      @box_height = 14
      @hla_cost = 15
      @hla_retail = 16
      @msrp = 17
      @compare_price = 18
      @wholesale_price = 19
      @map = 20
      @ca_prop_65 = 21
      @overwight_shipcharge = 22
      @errorState = 100
    end


    #def attr
    #  {
    #      prod_height: 16,
    #      prod_weight: 5,
    #      box_width:3
    #  }
    #end

    def headers
      [:prod_weight, :pack_weight, :box_length, :box_width, :box_height, :hla_cost,
       :hla_retail, :msrp, :compare_price, :wholesale_price, :map, :ca_prop_65, :overwight_shipcharge,:errorState]
    end
  end

  b= A.new()

  b.headers.each do |x|
    puts x
    throw 'incorrect number ' unless b.attr[x] < 100
  end

  case checking
    when 10
      then is_number?
    when 11
      then is_number?
    when 12
      then is_number?
    when 13
      then is_number?
    when 14
      then is_number?
    when 15
      then
    when 16
      then
    when 17
      then
    when 18
      then
    when 19
      then
    when 20
      then
    when 21
      then
    when 22
      then
    when 100
      then print 'There has been an error'
  end
end


