# Use the official Ruby image
FROM ruby:3.2

# Set environment variables
ENV LANG=C.UTF-8 

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libssl-dev \
    libzstd-dev \
    librdkafka-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the application files
COPY . /app

# Install Ruby dependencies
RUN bundle install

# Command to run the application
CMD ["ruby", "app.rb"]
