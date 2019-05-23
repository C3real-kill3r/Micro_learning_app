# set the database based on the current environment
configure :production, :test do
    database_name = "microlearning_#{MicrolearningController.environment}"
    db = URI.parse(ENV['DATABASE_URL'] || "postgres://localhost/#{database_name}")
    # connect ActiveRecord with the current database
    ActiveRecord::Base.establish_connection(
    :adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host => db.host,
    :port => db.port,
    :username => db.user,
    :password => db.password,
    :database => "#{database_name}",
    :encoding => 'utf8'
    )
end

configure :production do
 db = URI.parse(ENV['DATABASE_URL'] || "postgres://localhost/d1rd8mgir50ja3")

 ActiveRecord::Base.establish_connection(
   :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
   :host     => db.host,
   :username => db.user,
   :password => db.password,
   :database => db.path[1..-1],
   :encoding => 'utf8'
 )
end
