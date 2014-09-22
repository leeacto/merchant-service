# Welcome to Belly Merchant Service

This Rack app is a small service to be used in conjunction with Belly's Check-In code challenge. The primary function is to create and retrieve merchants from a database.

## Requirements
Merchant Service runs on Ruby 2.0.0-p247. Please install with your favorite version manager.

## Installation
* Clone Merchant Service from [here](https://github.com/leeacto/merchant-service)
* Run <code>bundle install</code>
* Run <code>rake db:create; RACK_ENV=test rake db:create</code> to create the database
* Run <code>rake db:migrate; RACK_ENV=test rake db:migrate</code> to create tables
* Run <code>rake db:seed</code> to add sample data to be used by other services

## Usage
Merchant Service provides API endpoints to create and update merchants (resource name: merchants)
The service can be run on port 9394 with <code>shotgun -p 9394</code>
Use <code>rake routes</code> to view the available endpoints

