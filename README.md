# Ruby kafka

This project was created to be a playground to test Kafka using a ruby library.


## Usage

Build the docker image.

```bash
docker compose up
```


On a shell, start a produce container:
```
docker compose exec app bash
ruby producer.rb
```

On the other shell, start a consumer:

```
ruby consumer.rb
```