module Admin
  module CompaniesHelper
    def format_datetime(datetime)
      (datetime || Time.current).strftime("%Y/%m/%d %H:%M")
    end
  end
end
