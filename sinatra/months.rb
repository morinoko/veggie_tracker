require 'sinatra/base'

module Sinatra
  module Months
    def this_month
      month = Time.now.month
      I18n.t('date.month_names')[month]
    end

    def month_name(month)
      I18n.t('date.month_names')[month]
    end

    def next_month_number(month)
      if month == 12
        1
      else
        month + 1
      end
    end

    def previous_month_number(month)
      if month == 1
        12
      else
        month - 1
      end
    end

    def next_month_name(month)
      if month == 12
        I18n.t('date.month_names')[1]
      else
        I18n.t('date.month_names')[month + 1]
      end
    end

    def previous_month_name(month)
      if month == 1
        I18n.t('date.month_names')[12]
      else
        I18n.t('date.month_names')[month - 1]
      end
    end
  end

  helpers Months
end
