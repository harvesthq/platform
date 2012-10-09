require 'rubygems'
require 'rack'

use Rack::Static, 
  :urls => %w(/vendor /javascripts /stylesheets /images),
  :root => "example"

run lambda { |env|
  [
    200, 
    {
      'Content-Type'  => 'text/html', 
      'Cache-Control' => 'public, max-age=86400' 
    },
    File.open('example/index.html', File::RDONLY)
  ]
}