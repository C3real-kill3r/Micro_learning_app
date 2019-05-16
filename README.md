# Micro_learning_app
A web responsive application that sends you one page result with snippets and links to pages about something you want to learn. You select a category you'd like to get more materials from and the application fetches the results from the available sources provided by the [NewsAPI](https://newsapi.org/).

## Installation
- Clone this repository to have the app on your machine with ```git clone https://github.com/C3real-kill3r/Micro_learning_app.git```
- Change directory to the app's root with ```cd Micro-learning-app```
- Then run ```bundle install```  to install the dependencies.
- Run ```rake db:create``` to create the development server.
- Run ```rake db:migrate``` to migrate database tables.
- Run ```rake db:seed``` to update the categories table.
- Start the server with ```ruby app.rb```
- Then visit ```http://localhost:4567``` to view the app.


## Installed gems
- sinatra
- activerecord
- sinatra-activerecord
- pg
- bcrypt
- sinatra-flash
- news-api
- sinatra-formhelpers-ng

## Technologies Used
* [Ruby](https://www.ruby-lang.org/en/)
* [Sinatra](http://sinatrarb.com//)
* [Erb](https://en.wikipedia.org/wiki/ERuby)
* [PostgreSQL](https://www.postgresql.org/)
* [NewsAPI](https://newsapi.org/)


### Author
* Brian Ryb
