class County < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  after_save :fetch_data

  belongs_to :state
  has_many :updates

  validates :fips, uniqueness: true

  private

    def fetch_data
      url           = "https://www.mississippicovid.com/api/v1/chronological/counties?state=#{self.state.name}&county=#{self.name}"
      response      = HTTParty.get(url, :headers =>{'Content-Type' => 'application/json'} )
      response_json = response.to_json
      response_hash = JSON.parse(response_json)
      results = response_hash["chronological"]["results"]
      results.each do |result|
        puts "Date: #{result["date"]} and Cases: #{result["cases"]}"
      end
    end
end
