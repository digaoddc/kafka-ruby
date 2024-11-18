require 'rdkafka'
require 'yaml'

topic_config = YAML.load_file('config.yml').fetch('topic')
config = {
  :"bootstrap.servers" => ENV["KAFKA_BROKER_URL"]
}
producer = Rdkafka::Config.new(config).producer
admin = Rdkafka::Config.new(config).admin
admin.create_topic(topic_config.fetch('name'), topic_config.fetch('partitions'), 1)


delivery_handles = []

2.times do |i|
  puts "Producing message #{i}"
  delivery_handles << producer.produce(
      topic:   topic_config.fetch('name'),
      payload: { name: "payload {i}", time: Time.now.to_s }.to_json,
      key: 'user' # order messages in the same partition
  )
end

delivery_handles.each(&:wait)
puts 'finish producer'