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
    #errors.add(:must_have_one, "value is not 1") if !have_one(must_be_one)
    must_be_zero = [prod_int_num, was_price, orig_upc, orig_model_num, orig_part_num, ca_lcd_led]
    #errors.add(:must_be_zero, "#{must_be_zero} is not 0") if !have_0(must_be_zero)
    must_have_value = [web_desc, manufacturer, upc, headline, lead_in, copy, comp_line]
    must_have_value(must_have_value)
  puts 'hello'
  end
end