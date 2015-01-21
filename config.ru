require 'scorched'
class App < Scorched::Controller
  get '/' do
    puts id
    'hello world'
  end

  after do
    puts 'noob'
  end

  error do
    puts 's'
  end

  def id
    request.GET['id']
  end
end
run App
