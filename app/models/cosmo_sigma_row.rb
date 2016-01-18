class CosmoSigmaRow < ActiveRecord::Base
  belongs_to :form
  include Import::InstanceMethods
  class << self #load as class methods
    include Import::ClassMethods
    def headers
              %w{vendor_sku hla_sku product_id product_name manufacturer mfr_part_number mfr_model_number
           upc_number product_description ad_copy product_weight package_weight box_length box_width
           box_height origin_country condition_ hla_cost hla_retail msrp compare_price wholesale_price
           map mfr_rebate color power_source warranty_provider warranty_length customer_warranty_length
           warranty_contact warranty_contact_phone order_retrieval_contact order_retrieval_phone
           order_retrieval_email drop_ship_zip drop_ship_fee terms ca_prop_65 overweight}
    end
  end

  def has_errors
    #make note ad_copy and product_description were taken out of headers
    headers = [vendor_sku, hla_sku, product_id, product_name, manufacturer, mfr_part_number, mfr_model_number,
               upc_number, origin_country, condition_, compare_price, wholesale_price,
               mfr_rebate, color, power_source, warranty_provider, warranty_length, customer_warranty_length,
               warranty_contact, warranty_contact_phone, order_retrieval_contact, order_retrieval_phone,
               order_retrieval_email, drop_ship_zip, drop_ship_fee, terms, ca_prop_65, overweight]


    errors.add(:Illegal_character_found, "#{} ") if illegal_character(headers)

    errors.add(:Please_check_and_make_sure_these_are_valid_numbers, ": #{:product_weight} - [#{product_weight}], #{:package_weight} - [#{package_weight}], #{:box_length} - [#{box_length}], #{:box_width} - [#{box_width}], #{:box_height} - [#{box_height}]") unless are_numbers? [:product_weight, :package_weight, :box_length, :box_width, :box_height]

    errors.add(:contains_dollar_signs, "Found #{:wholesale_price}- #{wholesale_price}") unless !have_dollar? [wholesale_price]
    errors.add(:contains_dollar_signs, "Found #{:compare_price}- #{compare_price}") unless !have_dollar? [compare_price]
    dollar_or_zero = [hla_cost, hla_retail, msrp, map,]
    errors.add(:dollar_or_zero_error, "contains dollar or zero") unless !have_dollar?(dollar_or_zero ) && !have_0(dollar_or_zero)
  end

end