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


  def has_errors
    #PROD_INT_NUM  -      must be 0
    #PROD_NUM  -          must have a value and start with M
    #WEB_DESC  -          must have a value
    #MODEL_NUM  -
    #MANUFACTURER  -      must have a value
    #UPC  -               must have a value
    #PART_NUM
    #PROD_TYPE
    #PROD_TERMS
    #HEADLINE  -          must have a value
    #LEAD_IN  -           must have a value
    #COPY -               must have a value
    #FEATURES_1
    #FEATURES_2
    #NOTES
    #FACTORY_SERVICED -   Must be 0 or 1
    #DROPSHIP  -          Must be 1
    #HYPE
    #UPGRADE_TEXT
    #COMP_LINE          - Must have value
    #COMP_PRICE         - Must have decimal value, can't have '$'
    #WAS_PRICE_LINE
    #WAS_PRICE          - Must be 0
    #ADV_PRICE_LINE
    #ADV_PRICE          - Must have decimal value, can't have '$'
    #PRICE_ADD_ON
    #SOLD_IN_PAIRS
    #WARR
    #MFR_REB
    #VC_REB
    #BEFORE_RED_SHIP    - Must have decimal value, can't have '$'
    #WEB_REST
    #PROP_65            - Must be 0 or 1
    #ORIG_UPC           - Must be 0
    #ORIG_MODEL_NUM     - Must be 0
    #ORIG_PART_NUM      - Must be 0
    #CA_LCD_LED         - Must be 0
    #ADD_COLUMN1
    #ADD_COLUMN2
    #ADD_COLUMN3
    #ADD_COLUMN4
    #ADD_COLUMN5
    #AVAIL              - Must be 1
    #ALT_IMAGES
    #ENT_DT
    #CONDITION
    #VAR_OPT
    #VAR_VAL
    #VAR_NUM
    #OFFER_NUM
    #CAT_GRP_NUM
    #ACC_1
    #ACC_2
    #ACC_3
    #ACC_4
    #UP_1
    #UP_2
    #UP_3
    #CAT_MAIN_ID_1      - Must have a valid category ID
    #CAT_MAIN_NAME_1    - Must have corresponding category name
    #CAT_SUB_ID_1       - Must have a valid category ID
    #CAT_SUB_NAME_1     - Must have corresponding category name
    #CAT_MAIN_ID_2      - If a value exists, it must be a valid category ID
    #CAT_MAIN_NAME_2    - If a value exists, it must be the corresponding category name
    #CAT_SUB_ID_2       - If a value exists, it must be a valid category ID
    #CAT_SUB_NAME_2     - If a value exists, it must be the corresponding category name
    #CAT_MAIN_ID_3      - If a value exists, it must be a valid category ID
    #CAT_MAIN_NAME_3    - If a value exists, it must be the corresponding category name
    #CAT_SUB_ID_3       - If a value exists, it must be a valid category ID
    #CAT_SUB_NAME_3     - If a value exists, it must be the corresponding category name

    must_be_one = [dropship, avail]
    errors.add(:must_be_one_error_at, ":#{:dropship}") if dropship != "1"
    errors.add(:must_be_one_error_at, ":#{:avail}") if avail != "1"
    gotta_be_zero = [prod_int_num, orig_upc, orig_model_num, orig_part_num, ca_lcd_led]
    errors.add(:must_be_zero, "#{}" ) unless must_be_zero(gotta_be_zero)
    must_zero_or_one = [factory_serviced, prop_65]
    errors.add(:must_be_a_zero_or_one, "#{must_zero_or_one}") if !one_or_zero(must_zero_or_one)
    errors.add(:must_have_value_and_start_with_M, "@ #{:prod_num}- #{prod_num}") unless must_have_M_and_value(prod_num)

   no_dollar_not_decimal = [comp_price, adv_price, before_red_ship]
    errors.add(:dollar_sign_or_not_decimal, "#{no_dollar_not_decimal}") if have_dollar?(no_dollar_not_decimal) ||
        is_empty?(no_dollar_not_decimal) || includes_letters?(no_dollar_not_decimal)


    main_ids = [cat_main_id_1]#, cat_main_id_2, cat_main_id_3]
    if  cat_main_id_1 == '1000' && cat_main_name_1 === 'Electronics' ||
        cat_main_id_1 == '2000' && cat_main_name_1 === 'Cameras & Optics' ||
        cat_main_id_1 == '3000' && cat_main_name_1 === 'Fashion' ||
        cat_main_id_1 == '4000' && cat_main_name_1 === 'Household' ||
        cat_main_id_1 == '5000' && cat_main_name_1 === 'Computers & Office' ||
        cat_main_id_1 == '6000' && cat_main_name_1 === 'Auto & Hardware' ||
        cat_main_id_1 == '7000' && cat_main_name_1 === 'Recreation & Health' ||
        cat_main_id_1 == '8000' && cat_main_name_1 === 'Gifts & Collectibles' ||
        cat_main_id_1 == '9000' && cat_main_name_1 === 'Footwear'
      errors.add(:main_id_must_be_valid, "#{:main_ids} - #{main_ids}") unless valid_mains(main_ids)
    else
      errors.add(:invalid_name_and_identifier, ":I found the id [#{cat_main_id_1}] with the category name [#{cat_main_name_1}]")
    end
    sub_ids = [cat_sub_id_1]
      if cat_sub_id_1 == '1001' && cat_sub_name_1 === 'TV' ||
          cat_sub_id_1 == '1002' && cat_sub_name_1 === 'DVD' ||
          cat_sub_id_1 == '1003' && cat_sub_name_1 === 'VCR' ||
          cat_sub_id_1 == '1004' && cat_sub_name_1 === 'Home Theater' ||
          cat_sub_id_1 == '1005' && cat_sub_name_1 === 'Camcorders' ||
          cat_sub_id_1 == '1006' && cat_sub_name_1 === 'Security Systems' ||
          cat_sub_id_1 == '1007' && cat_sub_name_1 === 'Stereo' ||
          cat_sub_id_1 == '1008' && cat_sub_name_1 === 'Speakers' ||
          cat_sub_id_1 == '1009' && cat_sub_name_1 === 'CD Players' ||
          cat_sub_id_1 == '1010' && cat_sub_name_1 === '2 Way Radios' ||
          cat_sub_id_1 == '1011' && cat_sub_name_1 === 'Nostalgia' ||
          cat_sub_id_1 == '1013' && cat_sub_name_1 === 'Radios' ||
          cat_sub_id_1 == '1014' && cat_sub_name_1 === 'Backup Power and Lighting' ||
          cat_sub_id_1 == '1015' && cat_sub_name_1 === 'MP3' ||
          cat_sub_id_1 == '1016' && cat_sub_name_1 === 'GPS' ||
          cat_sub_id_1 == '2001' && cat_sub_name_1 === 'Digital Cameras' ||
          cat_sub_id_1 == '2002' && cat_sub_name_1 === 'Film Cameras' ||
          cat_sub_id_1 == '2003' && cat_sub_name_1 === 'Camcorders' ||
          cat_sub_id_1 == '2004' && cat_sub_name_1 === 'Photo Printers' ||
          cat_sub_id_1 == '2005' && cat_sub_name_1 === 'Telescopes' ||
          cat_sub_id_1 == '2006' && cat_sub_name_1 === 'Binoculars' ||
          cat_sub_id_1 == '2007' && cat_sub_name_1 === 'Camera Accessories' ||
          cat_sub_id_1 == '3001' && cat_sub_name_1 === 'Outerwear' ||
          cat_sub_id_1 == '3002' && cat_sub_name_1 === 'Watches & Jewelry' ||
          cat_sub_id_1 == '3003' && cat_sub_name_1 === 'Sunglasses' ||
          cat_sub_id_1 == '3004' && cat_sub_name_1 === 'Bed & Bath' ||
          cat_sub_id_1 == '3005' && cat_sub_name_1 === 'Personal Care' ||
          cat_sub_id_1 == '3006' && cat_sub_name_1 === 'Luggage' ||
          cat_sub_id_1 == '3007' && cat_sub_name_1 === 'Fashion Accessories' ||
          cat_sub_id_1 == '3008' && cat_sub_name_1 === 'Shoes' ||
          cat_sub_id_1 == '3009' && cat_sub_name_1 === 'Apparel' ||
          cat_sub_id_1 == '4001' && cat_sub_name_1 === 'Lamps' ||
          cat_sub_id_1 == '4002' && cat_sub_name_1 === 'Clocks' ||
          cat_sub_id_1 == '4003' && cat_sub_name_1 === 'Weather Stations' ||
          cat_sub_id_1 == '4004' && cat_sub_name_1 === 'Furniture' ||
          cat_sub_id_1 == '4005' && cat_sub_name_1 === 'Artwork' ||
          cat_sub_id_1 == '4006' && cat_sub_name_1 === 'Heating & Cooling' ||
          cat_sub_id_1 == '4007' && cat_sub_name_1 === 'Kitchen' ||
          cat_sub_id_1 == '4008' && cat_sub_name_1 === 'Cleaning' ||
          cat_sub_id_1 == '4009' && cat_sub_name_1 === 'Security' ||
          cat_sub_id_1 == '4010' && cat_sub_name_1 === 'Bed & Bath' ||
          cat_sub_id_1 == '4011' && cat_sub_name_1 === 'Lawn & Garden' ||
          cat_sub_id_1 == '4012' && cat_sub_name_1 === 'Pets & Pests' ||
          cat_sub_id_1 == '4013' && cat_sub_name_1 === 'Air Quality' ||
          cat_sub_id_1 == '4014' && cat_sub_name_1 === 'Solar Lights' ||
          cat_sub_id_1 == '5001' && cat_sub_name_1 === 'Cordless Phones' ||
          cat_sub_id_1 == '5002' && cat_sub_name_1 === 'Conference Phones' ||
          cat_sub_id_1 == '5003' && cat_sub_name_1 === 'Cellular Phones' ||
          cat_sub_id_1 == '5004' && cat_sub_name_1 === 'General Phones' ||
          cat_sub_id_1 == '5005' && cat_sub_name_1 === 'Computers' ||
          cat_sub_id_1 == '5006' && cat_sub_name_1 === 'Fax Machines ' ||
          cat_sub_id_1 == '5007' && cat_sub_name_1 === 'Scanners' ||
          cat_sub_id_1 == '5008' && cat_sub_name_1 === 'Printers' ||
          cat_sub_id_1 == '5009' && cat_sub_name_1 === 'Furniture & Lighting' ||
          cat_sub_id_1 == '5010' && cat_sub_name_1 === 'General Office' ||
          cat_sub_id_1 == '5011' && cat_sub_name_1 === 'Personal Organizers' ||
          cat_sub_id_1 == '6001' && cat_sub_name_1 === 'Cordless Tools' ||
          cat_sub_id_1 == '6002' && cat_sub_name_1 === 'Workshop Tools' ||
          cat_sub_id_1 == '6003' && cat_sub_name_1 === 'Levels' ||
          cat_sub_id_1 == '6004' && cat_sub_name_1 === 'Radar & Radios' ||
          cat_sub_id_1 == '6005' && cat_sub_name_1 === 'Lawn & Garden' ||
          cat_sub_id_1 == '6006' && cat_sub_name_1 === 'Home Improvement' ||
          cat_sub_id_1 == '6007' && cat_sub_name_1 === 'Maintenance ' ||
          cat_sub_id_1 == '6008' && cat_sub_name_1 === 'Emergency' ||
          cat_sub_id_1 == '6009' && cat_sub_name_1 === 'Recreation' ||
          cat_sub_id_1 == '6010' && cat_sub_name_1 === 'Auto Accessories' ||
          cat_sub_id_1 == '6011' && cat_sub_name_1 === 'Navigation' ||
          cat_sub_id_1 == '6012' && cat_sub_name_1 === 'Vehicle Covers' ||
          cat_sub_id_1 == '6013' && cat_sub_name_1 === 'Motorcycle Accessories' ||
          cat_sub_id_1 == '7001' && cat_sub_name_1 === 'Golf' ||
          cat_sub_id_1 == '7002' && cat_sub_name_1 === 'Fitness Equipment' ||
          cat_sub_id_1 == '7003' && cat_sub_name_1 === 'Health & Diet' ||
          cat_sub_id_1 == '7004' && cat_sub_name_1 === 'Personal Care' ||
          cat_sub_id_1 == '7005' && cat_sub_name_1 === 'Outdoor & Camping' ||
          cat_sub_id_1 == '7006' && cat_sub_name_1 === 'Home Entertainment' ||
          cat_sub_id_1 == '7007' && cat_sub_name_1 === 'Toys and Games' ||
          cat_sub_id_1 == '7008' && cat_sub_name_1 === 'Movies' ||
          cat_sub_id_1 == '7009' && cat_sub_name_1 === 'Flashlights and Spotlights' ||
          cat_sub_id_1 == '7010' && cat_sub_name_1 === 'Scooters' ||
          cat_sub_id_1 == '7011' && cat_sub_name_1 === 'Musical Instruments' ||
          cat_sub_id_1 == '7012' && cat_sub_name_1 === 'Music' ||
          cat_sub_id_1 == '7013' && cat_sub_name_1 === 'Watercraft' ||
          cat_sub_id_1 == '7014' && cat_sub_name_1 === 'Sportsmans & Hunting' ||
          cat_sub_id_1 == '8001' && cat_sub_name_1 === 'Collectibles' ||
          cat_sub_id_1 == '8002' && cat_sub_name_1 === 'Gifts For Him' ||
          cat_sub_id_1 == '8003' && cat_sub_name_1 === 'Gifts For Her' ||
          cat_sub_id_1 == '8004' && cat_sub_name_1 === 'Gifts For Kids' ||
          cat_sub_id_1 == '8005' && cat_sub_name_1 === 'Gifts Under $20' ||
          cat_sub_id_1 == '8006' && cat_sub_name_1 === 'Gifts $21-$50' ||
          cat_sub_id_1 == '8007' && cat_sub_name_1 === 'Gifts $51-$100' ||
          cat_sub_id_1 == '8008' && cat_sub_name_1 === 'Gifts $101-$200' ||
          cat_sub_id_1 == '8009' && cat_sub_name_1 === 'Gifts Over $200 ' ||
          cat_sub_id_1 == '8010' && cat_sub_name_1 === 'Coins' ||
          cat_sub_id_1 == '8011' && cat_sub_name_1 === 'Sports Fan Shop' ||
          cat_sub_id_1 == '9001' && cat_sub_name_1 === 'Athletic' ||
          cat_sub_id_1 == '9002' && cat_sub_name_1 === 'Boots' ||
          cat_sub_id_1 == '9003' && cat_sub_name_1 === 'Dress/Casual' ||
          cat_sub_id_1 == '9004' && cat_sub_name_1 === 'Sandals' ||
          cat_sub_id_1 == '9005' && cat_sub_name_1 === 'Slippers' ||
          cat_sub_id_1 == '9006' && cat_sub_name_1 === 'Womens'
        #errors.add(:main_id_must_be_valid, "#{:sub_ids} - #{sub_ids}") unless valid_mains(main_ids)
      else
        errors.add(:sub_category_error, ":I found the id [#{cat_sub_id_1}] with the category name [#{cat_sub_name_1}]")
      end

    sub_cat_2_3 = [cat_sub_id_2, cat_sub_id_3]
    if cat_sub_id_2 || cat_sub_id_3 != ''
      if cat_sub_id_2 || cat_sub_id_3 == '1001' && cat_sub_name_2 || cat_sub_name_3 === 'TV' ||
          cat_sub_id_2 || cat_sub_id_3 == '1002' && cat_sub_name_2 || cat_sub_name_3 === 'DVD' ||
         cat_sub_id_2 || cat_sub_id_3 == '1003' && cat_sub_name_2 || cat_sub_name_3 === 'VCR' ||
         cat_sub_id_2 || cat_sub_id_3 == '1004' && cat_sub_name_2 || cat_sub_name_3 === 'Home Theater' ||
         cat_sub_id_2 || cat_sub_id_3 == '1005' && cat_sub_name_2 || cat_sub_name_3 === 'Camcorders' ||
         cat_sub_id_2 || cat_sub_id_3 == '1006' && cat_sub_name_2 || cat_sub_name_3 === 'Security Systems' ||
          cat_sub_id_2 || cat_sub_id_3 == '1007' && cat_sub_name_2 || cat_sub_name_3 === 'Stereo' ||
         cat_sub_id_2 || cat_sub_id_3 == '1008' && cat_sub_name_2 || cat_sub_name_3 === 'Speakers' ||
         cat_sub_id_2 || cat_sub_id_3 == '1009' && cat_sub_name_2 || cat_sub_name_3 === 'CD Players' ||
         cat_sub_id_2 || cat_sub_id_3 == '1010' && cat_sub_name_2 || cat_sub_name_3 === '2 Way Radios' ||
         cat_sub_id_2 || cat_sub_id_3 == '1011' && cat_sub_name_2 || cat_sub_name_3 === 'Nostalgia' ||
         cat_sub_id_2 || cat_sub_id_3 == '1013' && cat_sub_name_2 || cat_sub_name_3 === 'Radios' ||
         cat_sub_id_2 || cat_sub_id_3 == '1014' && cat_sub_name_2 || cat_sub_name_3 === 'Backup Power and Lighting' ||
         cat_sub_id_2 || cat_sub_id_3 == '1015' && cat_sub_name_2 || cat_sub_name_3 === 'MP3' ||
         cat_sub_id_2 || cat_sub_id_3 == '1016' && cat_sub_name_2 || cat_sub_name_3 === 'GPS' ||
         cat_sub_id_2 || cat_sub_id_3 == '2001' && cat_sub_name_2 || cat_sub_name_3 === 'Digital Cameras' ||
         cat_sub_id_2 || cat_sub_id_3 == '2002' && cat_sub_name_2 || cat_sub_name_3 === 'Film Cameras' ||
         cat_sub_id_2 || cat_sub_id_3 == '2003' && cat_sub_name_2 || cat_sub_name_3 === 'Camcorders' ||
         cat_sub_id_2 || cat_sub_id_3 == '2004' && cat_sub_name_2 || cat_sub_name_3 === 'Photo Printers' ||
         cat_sub_id_2 || cat_sub_id_3 == '2005' && cat_sub_name_2 || cat_sub_name_3 === 'Telescopes' ||
         cat_sub_id_2 || cat_sub_id_3 == '2006' && cat_sub_name_2 || cat_sub_name_3 === 'Binoculars' ||
         cat_sub_id_2 || cat_sub_id_3 == '2007' && cat_sub_name_2 || cat_sub_name_3 === 'Camera Accessories' ||
         cat_sub_id_2 || cat_sub_id_3 == '3001' && cat_sub_name_2 || cat_sub_name_3 === 'Outerwear' ||
         cat_sub_id_2 || cat_sub_id_3 == '3002' && cat_sub_name_2 || cat_sub_name_3 === 'Watches & Jewelry' ||
         cat_sub_id_2 || cat_sub_id_3 == '3003' && cat_sub_name_2 || cat_sub_name_3 === 'Sunglasses' ||
         cat_sub_id_2 || cat_sub_id_3 == '3004' && cat_sub_name_2 || cat_sub_name_3 === 'Bed & Bath' ||
         cat_sub_id_2 || cat_sub_id_3 == '3005' && cat_sub_name_2 || cat_sub_name_3 === 'Personal Care' ||
         cat_sub_id_2 || cat_sub_id_3 == '3006' && cat_sub_name_2 || cat_sub_name_3 === 'Luggage' ||
         cat_sub_id_2 || cat_sub_id_3 == '3007' && cat_sub_name_2 || cat_sub_name_3 === 'Fashion Accessories' ||
         cat_sub_id_2 || cat_sub_id_3 == '3008' && cat_sub_name_2 || cat_sub_name_3 === 'Shoes' ||
         cat_sub_id_2 || cat_sub_id_3 == '3009' && cat_sub_name_2 || cat_sub_name_3 === 'Apparel' ||
         cat_sub_id_2 || cat_sub_id_3 == '4001' && cat_sub_name_2 || cat_sub_name_3 === 'Lamps' ||
         cat_sub_id_2 || cat_sub_id_3 == '4002' && cat_sub_name_2 || cat_sub_name_3 === 'Clocks' ||
         cat_sub_id_2 || cat_sub_id_3 == '4003' && cat_sub_name_2 || cat_sub_name_3 === 'Weather Stations' ||
         cat_sub_id_2 || cat_sub_id_3 == '4004' && cat_sub_name_2 || cat_sub_name_3 === 'Furniture' ||
         cat_sub_id_2 || cat_sub_id_3 == '4005' && cat_sub_name_2 || cat_sub_name_3 === 'Artwork' ||
         cat_sub_id_2 || cat_sub_id_3 == '4006' && cat_sub_name_2 || cat_sub_name_3 === 'Heating & Cooling' ||
         cat_sub_id_2 || cat_sub_id_3 == '4007' && cat_sub_name_2 || cat_sub_name_3 === 'Kitchen' ||
         cat_sub_id_2 || cat_sub_id_3 == '4008' && cat_sub_name_2 || cat_sub_name_3 === 'Cleaning' ||
         cat_sub_id_2 || cat_sub_id_3 == '4009' && cat_sub_name_2 || cat_sub_name_3 === 'Security' ||
         cat_sub_id_2 || cat_sub_id_3 == '4010' && cat_sub_name_2 || cat_sub_name_3 === 'Bed & Bath' ||
         cat_sub_id_2 || cat_sub_id_3 == '4011' && cat_sub_name_2 || cat_sub_name_3 === 'Lawn & Garden' ||
         cat_sub_id_2 || cat_sub_id_3 == '4012' && cat_sub_name_2 || cat_sub_name_3 === 'Pets & Pests' ||
         cat_sub_id_2 || cat_sub_id_3 == '4013' && cat_sub_name_2 || cat_sub_name_3 === 'Air Quality' ||
         cat_sub_id_2 || cat_sub_id_3 == '4014' && cat_sub_name_2 || cat_sub_name_3 === 'Solar Lights' ||
         cat_sub_id_2 || cat_sub_id_3 == '5001' && cat_sub_name_2 || cat_sub_name_3 === 'Cordless Phones' ||
         cat_sub_id_2 || cat_sub_id_3 == '5002' && cat_sub_name_2 || cat_sub_name_3 === 'Conference Phones' ||
         cat_sub_id_2 || cat_sub_id_3 == '5003' && cat_sub_name_2 || cat_sub_name_3 === 'Cellular Phones' ||
         cat_sub_id_2 || cat_sub_id_3 == '5004' && cat_sub_name_2 || cat_sub_name_3 === 'General Phones' ||
         cat_sub_id_2 || cat_sub_id_3 == '5005' && cat_sub_name_2 || cat_sub_name_3 === 'Computers' ||
         cat_sub_id_2 || cat_sub_id_3 == '5006' && cat_sub_name_2 || cat_sub_name_3 === 'Fax Machines ' ||
         cat_sub_id_2 || cat_sub_id_3 == '5007' && cat_sub_name_2 || cat_sub_name_3 === 'Scanners' ||
         cat_sub_id_2 || cat_sub_id_3 == '5008' && cat_sub_name_2 || cat_sub_name_3 === 'Printers' ||
         cat_sub_id_2 || cat_sub_id_3 == '5009' && cat_sub_name_2 || cat_sub_name_3 === 'Furniture & Lighting' ||
         cat_sub_id_2 || cat_sub_id_3 == '5010' && cat_sub_name_2 || cat_sub_name_3 === 'General Office' ||
         cat_sub_id_2 || cat_sub_id_3 == '5011' && cat_sub_name_2 || cat_sub_name_3 === 'Personal Organizers' ||
         cat_sub_id_2 || cat_sub_id_3 == '6001' && cat_sub_name_2 || cat_sub_name_3 === 'Cordless Tools' ||
         cat_sub_id_2 || cat_sub_id_3 == '6002' && cat_sub_name_2 || cat_sub_name_3 === 'Workshop Tools' ||
         cat_sub_id_2 || cat_sub_id_3 == '6003' && cat_sub_name_2 || cat_sub_name_3 === 'Levels' ||
         cat_sub_id_2 || cat_sub_id_3 == '6004' && cat_sub_name_2 || cat_sub_name_3 === 'Radar & Radios' ||
         cat_sub_id_2 || cat_sub_id_3 == '6005' && cat_sub_name_2 || cat_sub_name_3 === 'Lawn & Garden' ||
         cat_sub_id_2 || cat_sub_id_3 == '6006' && cat_sub_name_2 || cat_sub_name_3 === 'Home Improvement' ||
         cat_sub_id_2 || cat_sub_id_3 == '6007' && cat_sub_name_2 || cat_sub_name_3 === 'Maintenance ' ||
         cat_sub_id_2 || cat_sub_id_3 == '6008' && cat_sub_name_2 || cat_sub_name_3 === 'Emergency' ||
         cat_sub_id_2 || cat_sub_id_3 == '6009' && cat_sub_name_2 || cat_sub_name_3 === 'Recreation' ||
         cat_sub_id_2 || cat_sub_id_3 == '6010' && cat_sub_name_2 || cat_sub_name_3 === 'Auto Accessories' ||
         cat_sub_id_2 || cat_sub_id_3 == '6011' && cat_sub_name_2 || cat_sub_name_3 === 'Navigation' ||
         cat_sub_id_2 || cat_sub_id_3 == '6012' && cat_sub_name_2 || cat_sub_name_3 === 'Vehicle Covers' ||
         cat_sub_id_2 || cat_sub_id_3 == '6013' && cat_sub_name_2 || cat_sub_name_3 === 'Motorcycle Accessories' ||
         cat_sub_id_2 || cat_sub_id_3 == '7001' && cat_sub_name_2 || cat_sub_name_3 === 'Golf' ||
         cat_sub_id_2 || cat_sub_id_3 == '7002' && cat_sub_name_2 || cat_sub_name_3 === 'Fitness Equipment' ||
         cat_sub_id_2 || cat_sub_id_3 == '7003' && cat_sub_name_2 || cat_sub_name_3 === 'Health & Diet' ||
         cat_sub_id_2 || cat_sub_id_3 == '7004' && cat_sub_name_2 || cat_sub_name_3 === 'Personal Care' ||
         cat_sub_id_2 || cat_sub_id_3 == '7005' && cat_sub_name_2 || cat_sub_name_3 === 'Outdoor & Camping' ||
         cat_sub_id_2 || cat_sub_id_3 == '7006' && cat_sub_name_2 || cat_sub_name_3 === 'Home Entertainment' ||
         cat_sub_id_2 || cat_sub_id_3 == '7007' && cat_sub_name_2 || cat_sub_name_3 === 'Toys and Games' ||
         cat_sub_id_2 || cat_sub_id_3 == '7008' && cat_sub_name_2 || cat_sub_name_3 === 'Movies' ||
         cat_sub_id_2 || cat_sub_id_3 == '7009' && cat_sub_name_2 || cat_sub_name_3 === 'Flashlights and Spotlights' ||
         cat_sub_id_2 || cat_sub_id_3 == '7010' && cat_sub_name_2 || cat_sub_name_3 === 'Scooters' ||
         cat_sub_id_2 || cat_sub_id_3 == '7011' && cat_sub_name_2 || cat_sub_name_3 === 'Musical Instruments' ||
         cat_sub_id_2 || cat_sub_id_3 == '7012' && cat_sub_name_2 || cat_sub_name_3 === 'Music' ||
         cat_sub_id_2 || cat_sub_id_3 == '7013' && cat_sub_name_2 || cat_sub_name_3 === 'Watercraft' ||
         cat_sub_id_2 || cat_sub_id_3 == '7014' && cat_sub_name_2 || cat_sub_name_3 === 'Sportsmans & Hunting' ||
         cat_sub_id_2 || cat_sub_id_3 == '8001' && cat_sub_name_2 || cat_sub_name_3 === 'Collectibles' ||
         cat_sub_id_2 || cat_sub_id_3 == '8002' && cat_sub_name_2 || cat_sub_name_3 === 'Gifts For Him' ||
         cat_sub_id_2 || cat_sub_id_3 == '8003' && cat_sub_name_2 || cat_sub_name_3 === 'Gifts For Her' ||
         cat_sub_id_2 || cat_sub_id_3 == '8004' && cat_sub_name_2 || cat_sub_name_3 === 'Gifts For Kids' ||
         cat_sub_id_2 || cat_sub_id_3 == '8005' && cat_sub_name_2 || cat_sub_name_3 === 'Gifts Under $20' ||
          cat_sub_id_2 || cat_sub_id_3 == '8006' && cat_sub_name_2 || cat_sub_name_3 === 'Gifts $21-$50' ||
          cat_sub_id_2 || cat_sub_id_3 == '8007' && cat_sub_name_2 || cat_sub_name_3 === 'Gifts $51-$100' ||
         cat_sub_id_2 || cat_sub_id_3 == '8008' && cat_sub_name_2 || cat_sub_name_3 === 'Gifts $101-$200' ||
         cat_sub_id_2 || cat_sub_id_3 == '8009' && cat_sub_name_2 || cat_sub_name_3 === 'Gifts Over $200 ' ||
         cat_sub_id_2 || cat_sub_id_3 == '8010' && cat_sub_name_2 || cat_sub_name_3 === 'Coins' ||
         cat_sub_id_2 || cat_sub_id_3 == '8011' && cat_sub_name_2 || cat_sub_name_3 === 'Sports Fan Shop' ||
         cat_sub_id_2 || cat_sub_id_3 == '9001' && cat_sub_name_2 || cat_sub_name_3 === 'Athletic' ||
         cat_sub_id_2 || cat_sub_id_3 == '9002' && cat_sub_name_2 || cat_sub_name_3 === 'Boots' ||
         cat_sub_id_2 || cat_sub_id_3 == '9003' && cat_sub_name_2 || cat_sub_name_3 === 'Dress/Casual' ||
         cat_sub_id_2 || cat_sub_id_3 == '9004' && cat_sub_name_2 || cat_sub_name_3 === 'Sandals' ||
         cat_sub_id_2 || cat_sub_id_3 == '9005' && cat_sub_name_2 || cat_sub_name_3 === 'Slippers' ||
         cat_sub_id_2 || cat_sub_id_3 == '9006' && cat_sub_name_2 || cat_sub_name_3 === 'Womens'
      #errors.add(:main_id_must_be_valid, "#{:sub_ids} - #{sub_ids}") unless valid_mains(main_ids)
      else
       errors.add(:sub_category_error, ":I found the id [#{cat_sub_id_3}] with the category name [#{cat_sub_}]")
      end

      end

    needs_something_inside = [web_desc, manufacturer, upc, headline, lead_in, copy, comp_line]
    errors.add(:no_value_error_at, ":#{}") unless !must_have_value(needs_something_inside)
  end
end