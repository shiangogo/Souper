#!/bin/bash

rails db:create
rails db:migrate
rake db:seed
bundle exec rails s -p 3000 -b '0.0.0.0'