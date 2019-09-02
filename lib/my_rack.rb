require 'rack'

app = Proc.new do |env|
  ['200', {'Content-Type' => 'text/html'}, [' barebones rack app.']]
end
Rack::Handler::WEBrick.run app