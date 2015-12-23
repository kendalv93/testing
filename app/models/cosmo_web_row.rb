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
    headers = [prod_int_num, prod_num, web_desc, model_num, manufacturer, upc, part_num, prod_type, prod_terms,
               factory_serviced, dropship, hype, upgrade_text, comp_line, comp_price,
               was_price_line, was_price, adv_price_line, adv_price, price_add_on, sold_in_pairs, warr, mfr_reb, vc_reb, 
               add_column2, add_column3, add_column4, add_column5, avail, alt_images, ent_dt, condition, var_opt, var_val, var_num, 
               offer_num, cat_grp_num, acc_1, acc_2, acc_3, acc_4, up_1, up_2, up_3, cat_main_id_1, cat_main_name_1, cat_sub_id_1, 
               cat_sub_name_1, cat_main_id_2, cat_main_name_2, cat_sub_id_2, cat_sub_name_2, cat_main_id_3, cat_main_name_3, 
               cat_sub_id_3, cat_sub_name_3]
    errors.add(:char_errors, "barf ") unless !illegal_character(headers)

  end



end