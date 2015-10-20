class Form < ActiveRecord::Base
  has_many :cosmo_sigma_rows
  has_many :cosmo_web_rows
  def rows
    case csv_type
      when 'cosmo_sigma'
        self.cosmo_sigma_rows
      when 'cosmo_web'
        self.cosmo_web_rows
      else
        throw 'unknown csv type'
    end
  end
end
