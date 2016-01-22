class CosmoWebRow < ActiveRecord::Base
  belongs_to :form
  include Import::InstanceMethods
  class << self #load as class methods
    include Import::ClassMethods

    def headers
      %w{prod_int_num prod_num web_desc model_num manufacturer upc part_num prod_type prod_terms headline lead_in
               copy features_1 features_2 notes factory_serviced dropship hype upgrade_text comp_line comp_price
               was_price_line was_price adv_price_line adv_price price_add_on sold_in_pairs warr mfr_reb vc_reb
               before_red_ship web_rest prop_65 orig_upc orig_model_num orig_part_num ca_lcd_led add_column1
               add_column2 add_column3 add_column4 add_column5 avail alt_images ent_dt condition var_opt var_val var_num
               offer_num cat_grp_num acc_1 acc_2 acc_3 acc_4 up_1 up_2 up_3 cat_main_id_1 cat_main_name_1 cat_sub_id_1
               cat_sub_name_1 cat_main_id_2 cat_main_name_2 cat_sub_id_2 cat_sub_name_2 cat_main_id_3 cat_main_name_3
               cat_sub_id_3 cat_sub_name_3}
    end
  end

  def valid_main_id_name_combo?(id, name)
    id_name = [['1000', 'Electronics'],
     ['2000', 'Cameras & Optics'],
     ['3000', 'Fashion'],
     ['4000', 'Household'],
     ['5000', 'Computers & Office'],
     ['6000', 'Auto & Hardware'],
     ['7000', 'Recreation & Health'],
     ['8000', 'Gifts & Collectibles'],
     ['9000', 'Footwear']]
    id_name.any? { |x| id.to_s === x[0] && name === x[1] }
  end

  def valid_id_name_combo?(id, name)
    id_name = [
        ['1001', 'TV'],
        ['1002', 'DVD'],
        ['1003', 'VCR'],
        ['1004', 'Home Theater'],
        ['1005', 'Camcorders'],
        ['1006', 'Security Systems'],
        ['1007', 'Stereo'],
        ['1008', 'Speakers'],
        ['1009', 'CD Players'],
        ['1010', '2 Way Radios'],
        ['1011', 'Nostalgia'],
        ['1013', 'Radios'],
        ['1014', 'Backup Power and Lighting'],
        ['1015', 'MP3'],
        ['1016', 'GPS'],
        ['2001', 'Digital Cameras'],
        ['2002', 'Film Cameras'],
        ['2003', 'Camcorders'],
        ['2004', 'Photo Printers'],
        ['2005', 'Telescopes'],
        ['2006', 'Binoculars'],
        ['2007', 'Camera Accessories'],
        ['3001', 'Outerwear'],
        ['3002', 'Watches & Jewelry'],
        ['3003', 'Sunglasses'],
        ['3004', 'Bed & Bath'],
        ['3005', 'Personal Care'],
        ['3006', 'Luggage'],
        ['3007', 'Fashion Accessories'],
        ['3008', 'Shoes'],
        ['3009', 'Apparel'],
        ['4001', 'Lamps'],
        ['4002', 'Clocks'],
        ['4003', 'Weather Stations'],
        ['4004', 'Furniture'],
        ['4005', 'Artwork'],
        ['4006', 'Heating & Cooling'],
        ['4007', 'Kitchen'],
        ['4008', 'Cleaning'],
        ['4009', 'Security'],
        ['4010', 'Bed & Bath'],
        ['4011', 'Lawn & Garden'],
        ['4012', 'Pets & Pests'],
        ['4013', 'Air Quality'],
        ['4014', 'Solar Lights'],
        ['5001', 'Cordless Phones'],
        ['5002', 'Conference Phones'],
        ['5003', 'Cellular Phones'],
        ['5004', 'General Phones'],
        ['5005', 'Computers'],
        ['5006', 'Fax Machines '],
        ['5007', 'Scanners'],
        ['5008', 'Printers'],
        ['5009', 'Furniture & Lighting'],
        ['5010', 'General Office'],
        ['5011', 'Personal Organizers'],
        ['6001', 'Cordless Tools'],
        ['6002', 'Workshop Tools'],
        ['6003', 'Levels'],
        ['6004', 'Radar & Radios'],
        ['6005', 'Lawn & Garden'],
        ['6006', 'Home Improvement'],
        ['6007', 'Maintenance '],
        ['6008', 'Emergency'],
        ['6009', 'Recreation'],
        ['6010', 'Auto Accessories'],
        ['6011', 'Navigation'],
        ['6012', 'Vehicle Covers'],
        ['6013', 'Motorcycle Accessories'],
        ['7001', 'Golf'],
        ['7002', 'Fitness Equipment'],
        ['7003', 'Health & Diet'],
        ['7004', 'Personal Care'],
        ['7005', 'Outdoor & Camping'],
        ['7006', 'Home Entertainment'],
        ['7007', 'Toys and Games'],
        ['7008', 'Movies'],
        ['7009', 'Flashlights and Spotlights'],
        ['7010', 'Scooters'],
        ['7011', 'Musical Instruments'],
        ['7012', 'Music'],
        ['7013', 'Watercraft'],
        ['7014', 'Sportsmans & Hunting'],
        ['8001', 'Collectibles'],
        ['8002', 'Gifts For Him'],
        ['8003', 'Gifts For Her'],
        ['8004', 'Gifts For Kids'],
        ['8005', 'Gifts Under $20'],
        ['8006', 'Gifts $21-$50'],
        ['8007', 'Gifts $51-$100'],
        ['8008', 'Gifts $101-$200'],
        ['8009', 'Gifts Over $200 '],
        ['8010', 'Coins'],
        ['8011', 'Sports Fan Shop'],
        ['9001', 'Athletic'],
        ['9002', 'Boots'],
        ['9003', 'Dress/Casual'],
        ['9004', 'Sandals'],
        ['9005', 'Slippers'],
        ['9006', 'Womens']]
    id_name.any? { |x| id.to_s === x[0] && name === x[1] }
  end

  def has_errors
    errors.add(:Not_a_one_error, ": Found [[#{:dropship}]] - [#{dropship}]") if dropship != "1"
    errors.add(:Not_a_one_error, ": Found [[#{:avail}]] - [#{avail}]") if avail != "1"
    #gotta_be_zero = [prod_int_num, orig_upc, orig_model_num, orig_part_num, ca_lcd_led]
    errors.add(:must_be_zero_error, ": Found [[prod_int_num]] - [#{prod_int_num}]") unless must_be_zero(prod_int_num)
    errors.add(:must_be_zero_error, ": Found [[orig_upc]] - [#{orig_upc}]") unless must_be_zero(orig_upc)
    errors.add(:must_be_zero_error, ": Found [[orig_model_num]] - [#{orig_model_num}]") unless must_be_zero(orig_model_num)
    errors.add(:must_be_zero_error, ": Found [[orig_part_num]] - [#{orig_part_num}]") unless must_be_zero(orig_part_num)
    errors.add(:must_be_zero_error, ": Found [[ca_lcd_led]] - [#{ca_lcd_led}]") unless must_be_zero(ca_lcd_led)

    must_zero_or_one = [factory_serviced, prop_65]
    #errors.add(:must_be_a_zero_or_one, "#{must_zero_or_one}") if !one_or_zero(must_zero_or_one)
    errors.add(:must_be_a_zero_or_one_error, ": Found [[factory_serviced]] - [#{factory_serviced}]") unless zero_or_one(factory_serviced)
    errors.add(:must_be_a_zero_or_one_error, ": Found [[prop_65]] - [#{prop_65}]") unless zero_or_one(prop_65)

    errors.add(:must_have_value_and_start_with_M, ": Found [[#{:prod_num}]] - [#{prod_num}]") unless must_have_M_and_value(prod_num)

    errors.add(:dollar_sign_or_not_decimal_error, ": Found [[#{:comp_price}]] - [#{comp_price}]") if have_dollar?(comp_price) ||
        is_empty?(comp_price) || include_letters?(comp_price) || round_2(comp_price)
    errors.add(:dollar_sign_or_not_decimal_error, ": Found [[#{:adv_price}]] - [#{adv_price}]") if have_dollar?(adv_price) ||
        is_empty?(adv_price) || include_letters?(adv_price)
    errors.add(:dollar_sign_or_not_decimal_error, ": Found [[#{:before_red_ship}]] - [#{before_red_ship}]") if have_dollar?(before_red_ship) ||
        is_empty?(before_red_ship) || include_letters?(before_red_ship)



    #needs_something_inside = [web_desc, manufacturer, upc, headline, lead_in, copy, comp_line]
    errors.add(:No_input_error, ": Found [[web_desc]] - [#{web_desc}]") unless must_have_value(web_desc)
    errors.add(:No_input_error, ": Found [[manufacturer]] - [#{manufacturer}]") unless must_have_value(manufacturer)
    errors.add(:No_input_error, ": Found [[upc]] - [#{upc}]") unless must_have_value(upc)
    errors.add(:No_input_error, ": Found [[headline]] - [#{headline}]") unless must_have_value(headline)
    errors.add(:No_input_error, ": Found [[lead_in]] - [#{lead_in}]") unless must_have_value(lead_in)
    errors.add(:No_input_error, ": Found [[copy]] - [#{copy}]") unless must_have_value(copy)
    errors.add(:No_input_error, ": Found [[comp_line]] - [#{comp_line}]") unless must_have_value(comp_line)


    main_ids = [cat_main_id_1] #, cat_main_id_2, cat_main_id_3]
    unless valid_main_id_name_combo?(cat_main_id_1, cat_main_name_1)
      errors.add(:invalid_name_and_identifier, ": Found [[cat_main_id_1]] - [#{cat_main_id_1}] with the [[cat_main_name_1]] - [#{cat_main_name_1}]")
    end

    if (cat_main_id_2  != ''  && !cat_main_id_2.nil?) || (cat_main_name_2  != ''  && !cat_main_name_2.nil?)
      unless valid_main_id_name_combo?(cat_main_id_2, cat_main_name_2)
        errors.add(:invalid_name_and_identifier, ": Found [[cat_main_id_2]] - [#{cat_main_id_2}] with the [[cat_main_name_2]] - [#{cat_main_name_2}]")
      end
    end

    if cat_main_id_3  != ''  && !cat_main_id_3.nil?
      unless valid_main_id_name_combo?(cat_main_id_3, cat_main_name_3)
        errors.add(:invalid_name_and_identifier, ": Found [[cat_main_id_3]] - [#{cat_main_id_3}] with the [[cat_main_name_3]] - [#{cat_main_name_3}]")
      end
    end

    sub_ids = [cat_sub_id_1]
    unless valid_id_name_combo?(cat_sub_id_1, cat_sub_name_1)
      errors.add(:sub_category_error, ":I found [[cat_sub_id_1]] - [#{cat_sub_id_1}] with the [[cat_sub_name_1]] [#{cat_sub_name_1}]")
    end

    sub_cat_2_3 = [cat_sub_id_2, cat_sub_id_3]
    if (cat_sub_id_2 != ''  && !cat_sub_id_2.nil?) || (cat_sub_name_2 != ''  && !cat_sub_name_2.nil?)
      unless valid_id_name_combo?(cat_sub_id_2, cat_sub_name_2)
        errors.add(:sub_category_error, ":I found [[cat_sub_id_2]] - [#{cat_sub_id_2}] with the [[cat_sub_name_2]] [#{cat_sub_name_2}]")
      end
    end

    if (cat_sub_id_3 != ''  && !cat_sub_id_3.nil?) || (cat_sub_name_3 != ''  && !cat_sub_name_3.nil?)
      unless valid_id_name_combo?(cat_sub_id_3, cat_sub_name_3)
        errors.add(:sub_category_error, ":I found [[cat_sub_id_3]] - [#{cat_sub_id_3}] with the [[cat_sub_name_3]] [#{cat_sub_name_3}]")
      end
    end
  end
end