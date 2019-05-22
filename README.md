# Micro_learning_app
A responsive web application that sends you one page result with 20 snippets and links to pages relevant to the selected subject(s) you want to materials on. You select a category you'd like to get more materials from and the application fetches the results from the available sources provided by the [NewsAPI](https://newsapi.org/).

## Installation
- Clone this repository to have the app on your machine with ```git clone https://github.com/C3real-kill3r/Micro_learning_app.git```
- Change directory to the app's root with ```cd Micro-learning-app```
- Then run ```bundle install```  to install the dependencies.
- Run ```rake db:create``` to create the development database.
- Run ```rake db:migrate``` to migrate database tables.
- Run ```rake db:seed``` to update the categories table.
- Start the server with ```ruby app.rb```
- Then visit ```http://localhost:4567``` to view the app.


## Installed gems
- sinatra - a DSL for quickly creating web applications in Ruby with minimal effort:
- activerecord -  provide an interface and binding between the tables in a relational database and the Ruby program code that manipulates database records. 
- sinatra-activerecord - extends Sinatra with extension methods and Rake tasks for dealing with an SQL database using the ActiveRecord ORM.
- pg - a module that allows Ruby programs to interact with the PostgreSQL database engine.
- bcrypt - a hashing function that allows us to build a password security platform that can scale with computation power.
- sinatra-flash - a gem that allows us to pop up little messages alerting your users of important things.
- news-api - a simple HTTP REST API for searching and retrieving live articles from all over the web.
- sinatra-formhelpers-ng - a suite of helper methods built to make building forms in Sinatra an easy task.

## Technologies Used
* [Ruby](https://www.ruby-lang.org/en/)
* [Sinatra](http://sinatrarb.com//)
* [Erb](https://en.wikipedia.org/wiki/ERuby)
* [PostgreSQL](https://www.postgresql.org/)
* [NewsAPI](https://newsapi.org/)


### Author
* Brian Ryb
