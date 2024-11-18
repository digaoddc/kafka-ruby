require 'rdkafka'
require 'yaml'
require 'pry'

topic_config = YAML.load_file('config.yml').fetch('topic')

config = {
  :"bootstrap.servers" => ENV["KAFKA_BROKER_URL"], 
  :"group.id" => "ruby-test-group6" # Assign a valid consumer group
}

admin = Rdkafka::Config.new(config).admin

tr = Thread.new do
  puts "init thread"
  begin
    consumer = Rdkafka::Config.new(config).consumer
    puts consumer.subscribe(topic_config.fetch('name'))
    consumer.each do |message|
      puts "Message received: #{message}"
    end
  recue Exception => e
    puts "Exception inside the thread: #{e.message}"
  end
end


loop do
  listening_topics = [ topic_config.fetch('name') ]
  all_topics = admin.metadata.topics.map { |topic| topic[:topic_name] }.filter {|t| !t.start_with?('__') }
  new_topics = all_topics - listening_topics
  if new_topics.size > 0
    puts "New topics: #{new_topics}"
  end
  sleep 10
end

Signal.trap("INT") do
  puts "Terminating..."
  admin.unsubscribe()
  abort 'Shut down!'
end