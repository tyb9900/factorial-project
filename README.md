# Factorial Project

# Getting started

This project runs with Docker version 20.10.12

To install Docker please check https://docs.docker.com/get-docker/

# First Time Setup

* Run the following command to setup databse, frontend and backend applications 
```docker-compose run backend bin/rails db:create db:migrate db:seed```

* Run the following command to run the application 
```docker-compose up```


## .ENV file setup

* Make and ```.env``` file exactly same as ```.env.example``` file and put your values.


## Backend Application

* Access Backend application with ```http://localhost:5000/```. Here ```5000``` will be the port you provided in ```.env``` file for ```BACKEND_PORT```.

## Frontend Application

* Access Frontend application with ```http://localhost:3000/```. Here ```3000``` will be the port you provided in ```.env``` file for ```FRONTEND_PORT```.

# Technical Details
    
## Backend Application
    Backend application run with Ruby 3.0.2 and Rails 6.1.6

### Tests

To run the test suite type in the command line ```docker-compose run backend bundle exec rspec```. It will return the number of examples and the failures: ```9 examples, 0 failures```

## Frontend Application
    Backend application run with React version 18.1.0
