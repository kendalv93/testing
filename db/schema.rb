# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151110075745) do

  create_table "checking_for_errors", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cosmo_sigma_rows", force: :cascade do |t|
    t.integer  "form_id"
    t.string   "vendor_sku"
    t.string   "hla_sku"
    t.string   "product_id"
    t.string   "product_name"
    t.string   "manufacturer"
    t.string   "mfr_part_number"
    t.string   "mfr_model_number"
    t.string   "upc_number"
    t.string   "product_description"
    t.string   "ad_copy"
    t.string   "product_weight"
    t.string   "package_weight"
    t.string   "box_length"
    t.string   "box_width"
    t.string   "box_height"
    t.string   "origin_country"
    t.string   "condition_"
    t.string   "hla_cost"
    t.string   "hla_retail"
    t.string   "msrp"
    t.string   "compare_price"
    t.string   "wholesale_price"
    t.string   "map"
    t.string   "mfr_rebate"
    t.string   "color"
    t.string   "power_source"
    t.string   "warranty_provider"
    t.string   "warranty_length"
    t.string   "customer_warranty_length"
    t.string   "warranty_contact"
    t.string   "warranty_contact_phone"
    t.string   "order_retrieval_contact"
    t.string   "order_retrieval_phone"
    t.string   "order_retrieval_email"
    t.string   "drop_ship_zip"
    t.string   "drop_ship_fee"
    t.string   "terms"
    t.string   "ca_prop_65"
    t.string   "overweight"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "cosmo_web_rows", force: :cascade do |t|
    t.integer  "form_id"
    t.integer  "prod_int_num"
    t.string   "prod_num"
    t.string   "web_desc"
    t.string   "model_num"
    t.string   "manufacturer"
    t.integer  "upc",              limit: 6
    t.string   "part_num"
    t.string   "prod_type"
    t.string   "prod_terms"
    t.string   "headline"
    t.string   "lead_in"
    t.string   "copy"
    t.string   "features_1"
    t.string   "features_2"
    t.string   "notes"
    t.string   "factory_serviced"
    t.string   "dropship"
    t.string   "hype"
    t.string   "upgrade_text"
    t.string   "comp_line"
    t.decimal  "comp_price"
    t.string   "was_price_line"
    t.decimal  "was_price"
    t.string   "adv_price_line"
    t.decimal  "adv_price"
    t.string   "price_add_on"
    t.string   "sold_in_pairs"
    t.string   "warr"
    t.string   "mfr_reb"
    t.string   "vc_reb"
    t.decimal  "before_red_ship"
    t.string   "web_rest"
    t.string   "prop_65"
    t.string   "orig_upc"
    t.string   "orig_model_num"
    t.string   "orig_part_num"
    t.string   "ca_lcd_led"
    t.string   "add_column1"
    t.string   "add_column2"
    t.string   "add_column3"
    t.string   "add_column4"
    t.string   "add_column5"
    t.string   "avail"
    t.string   "alt_images"
    t.string   "ent_dt"
    t.string   "condition"
    t.string   "var_opt"
    t.string   "var_val"
    t.string   "var_num"
    t.integer  "offer_num"
    t.integer  "cat_grp_num"
    t.string   "acc_1"
    t.string   "acc_2"
    t.string   "acc_3"
    t.string   "acc_4"
    t.string   "up_1"
    t.string   "up_2"
    t.string   "up_3"
    t.integer  "cat_main_id_1"
    t.string   "cat_main_name_1"
    t.integer  "cat_sub_id_1"
    t.string   "cat_sub_name_1"
    t.integer  "cat_main_id_2"
    t.string   "cat_main_name_2"
    t.integer  "cat_sub_id_2"
    t.string   "cat_sub_name_2"
    t.string   "cat_main_id_3"
    t.string   "cat_main_name_3"
    t.string   "cat_sub_id_3"
    t.string   "cat_sub_name_3"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "forms", force: :cascade do |t|
    t.string   "csv_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
