# Kafka Playground

This project was created to be a playground to test Kafka using a ruby library.


## Usage

Build the docker image.

```bash
docker compose up
```


On a shell, start a produce container:
```bash
docker compose exec app bash
ruby producer.rb
```

On the other shell, start a consumer:

```bash
ruby consumer.rb
```

## Links

Dillinger uses a number of open source projects to work properly:

- [kafka-image](https://hub.docker.com/r/confluentinc/cp-kafka) - Link to the docker image
- [Ruby Gem](https://github.com/karafka/rdkafka-ruby) - Link to the ruby gem