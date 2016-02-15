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
               order_retrieval_email, drop_ship_zip, drop_ship_fee, terms, ca_prop_65, overweight, compare_price, wholesale_price]


    illegal_character(CosmoSigmaRow.headers)
    #errors.add(:Must_have_values, "#{}") if have_values?(CosmoSigmaRow.headers)
    values?(CosmoSigmaRow.headers)

    errors.add(:These_have_to_be_a_number, " :Found [[#{:product_weight}]] - [#{product_weight}], [[#{:package_weight}]] - [#{package_weight}], [[#{:box_length}]] - [#{box_length}], [[#{:box_width}]] - [#{box_width}], [[#{:box_height}]] - [#{box_height}]") unless are_numbers? [:product_weight, :package_weight, :box_length, :box_width, :box_height]

    errors.add(:These_fields_cannot_contain_a_dollar_sign, " :Found [[#{:wholesale_price}]] - [#{wholesale_price}]") unless !have_dollar? [wholesale_price]
    errors.add(:This_cannot_contain_a_dollar_sign_or_be_a_zero, " :Found [[hla_cost]] - [#{hla_cost}]") unless !contains_dollar?(hla_cost ) && !contains_0?(hla_cost)
    errors.add(:This_cannot_contain_a_dollar_sign_or_be_a_zero, " :Found [[hla_retail]] - [#{hla_retail}]") unless !contains_dollar?(hla_retail ) && !contains_0?(hla_retail)
    errors.add(:This_cannot_contain_a_dollar_sign_or_be_a_zero, " :Found [[msrp]] - [#{msrp}]") unless !contains_dollar?(msrp ) && !contains_0?(msrp)
    errors.add(:This_cannot_contain_a_dollar_sign_or_be_a_zero, " :Found [[map]] - [#{map}]") unless !contains_dollar?(map ) && !contains_0?(map)

    errors.count != 0
  end

end