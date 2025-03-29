# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# note
docker compose build  
docker compose run app rails new . --force --database=postgresql --skip-javascript  
docker compose up -d app  
docker compose exec app rails db:create  
docker compose exec app rails db:migrate  
docker compose exec app rails console  
