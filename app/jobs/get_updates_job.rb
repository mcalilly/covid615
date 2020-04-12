class GetUpdatesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Perform Job
    require 'json'

    # Open JSON File
    root = Rails.root.to_s
    file = File.read('#{root}/data.json')


    # Parse Data from File
    data_hash = JSON.parse(file)

    # Do the SAVING and validation HERE...
    test = Sample.new
    test.title = data_hash['title']
    ......
    test.save


  end
end
