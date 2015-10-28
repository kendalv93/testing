class Form < ActiveRecord::Base
  has_many :cosmo_sigma_rows
  has_many :cosmo_web_rows
  def rows
    case csv_type
      when 'cosmo_sigma'
        self.cosmo_sigma_rows
      when 'cosmo_web'

        validates :prod_int_num, presence:  true, format: {
            with:    %r{\.(gif|jpg|png)\Z}i,
            message: 'Must contain something'
        }
        validates :prod_num, uniqueness:  true, format: {
                               with:    %r{\.(gif|jpg|png)\Z}i,
                               message: 'Must contain something'
                           }
        validates :model_num, uniqueness: true, format: {
                                with:    %r{\.(gif|jpg|png)\Z}i,
                                message: 'Must contain something'
                            }
        validates :manufacturer, presence:  true, format: {
                                   with:    %r{\.(gif|jpg|png)\Z}i,
                                   message: 'Must contain something'
                               }
        validates :upc, uniqueness: true, format: {
                          with:    %r{\.(gif|jpg|png)\Z}i,
                          message: 'Must contain something'
                      }
        self.cosmo_web_rows
      else
        throw 'unknown csv type'
    end
  end
end
