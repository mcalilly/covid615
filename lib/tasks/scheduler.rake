namespace :fetch_update do

  desc "fetch and scrape today's Covid update for Nashville"
  task nashville: :environment do

    # Fetch the page
    page_html = Nokogiri::HTML(HTTParty.get("https://asafenashville.org"))

    # Parse the response
    ## Total cases
    total_cases_today_raw = page_html.css(".home #main-wrapper .homeLower .question table:nth-child(5) tr:nth-child(2) td:nth-child(2)").text
    total_cases_today_formatted = total_cases_today_raw.gsub(/[\s,]/ ,"").to_i
    total_cases_yesterday = Update.last.total_cases

    ## Total deaths
    total_deaths_today_raw = page_html.css(".home #main-wrapper .homeLower .question table tr:nth-child(4) td:nth-child(2)").text
    total_deaths_today_formatted = total_deaths_today_raw.gsub(/[\s,]/ ,"").to_i
    total_deaths_yesterday = Update.last.total_deaths

    if total_cases_today_formatted.blank? || total_deaths_today_formatted.blank?
      @no_data_warning = "Warning: data today is not being successfully fetched from asafenashville.org. The html on the page might have changed."
      puts "#{@no_data_warning}"
      Rails.logger.info "#{@no_data_warning}"
    elsif total_cases_today_formatted.class != Integer || total_deaths_today_formatted.class != Integer
      @incorrect_data_warning = "Warning: data fetched today was not an integer, so we need to check asafenashville.org manually."
      puts "#{@incorrect_data_warning}"
      Rails.logger.info "#{@incorrect_data_warning}"
    elsif total_cases_today_formatted == total_cases_yesterday
      @same_data_warning = "Warning: Today's total case count is the same as yesterday. Double-check asafenashville.org because something is wrong or the virus is over."
      puts "#{@same_data_warning}"
      Rails.logger.info "#{@same_data_warning}"
      # To-do: Trigger a warning email to double-check this
      # To-do: Trigger a specific kind of subscriber email when this happens
    else
      @new_cases_today = total_cases_today_formatted - total_cases_yesterday
      @new_deaths_today = total_deaths_today_formatted - total_deaths_yesterday
      # Update.create!(county_id: 1, date: Date.today.strftime("%Y-%m-%d"), new_cases: @new_cases_today, new_deaths: @new_deaths_today)

      @update = Update.new(county_id: 1, date: Date.today.strftime("%Y-%m-%d"), new_cases: @new_cases_today, new_deaths: @new_deaths_today)
      @update.save

      if @update.save
        @success_message = "A new update was created by the webscraper on #{Date.today.strftime("%a, %e %b %Y")}"
        puts "#{@success_message}"
        Rails.logger.info "#{@success_message}"
      else
        @success_message = "A new update was created by the webscraper on #{Date.today.strftime("%a, %e %b %Y")}"
        puts "#{@success_message}"
        Rails.logger.info "#{@success_message}"
      end
    end
  end
end
