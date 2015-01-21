require 'scorched'
class App < Scorched::Controller
  get '/' do
    @id = id
    puts render_defaults
    render :welcome
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
