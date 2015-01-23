# setup as development enviroment unless otherwise specified
RACK_ENV = ENV['RACK_ENV'] ||= 'development'  unless defined?(RACK_ENV)

# Set Application Root
APP_ROOT = File.expand_path('..', __FILE__) unless defined?(APP_ROOT)

# Sets up all of load paths that are searched when requiring code
require 'bundler/setup'

# requires all gems for the current runtime enviroment
Bundler.require(:default, RACK_ENV)

# require the lib directory
Dir[APP_ROOT + '/lib/**/*.rb'].each {|file| require file }

class App < Scorched::Controller
  middleware << proc do
    use Rack::Session::Cookie, secret: 'blah'
    use Rack::Csrf, :raise => true
  end
end

module Scorched
  module RestActions
    def self.included(klass)
      klass.get('/') { invoke_action :index }
      klass.get('/new') { invoke_action :new }
      klass.post('/') { invoke_action :create }
      klass.get('/:id') {|id| invoke_action :show, id }
      klass.get('/:id/edit') { invoke_action :edit }
      klass.route('/:id', method: ['PATCH', 'PUT']) { invoke_action :update }
      klass.delete('/:id') { invoke_action :delete }
    end
    def invoke_action(action, *captures)
      respond_to?(action) ? send(action, *captures) : pass
    end

  end
end

class User
  class Create
    class Form
      def initialize(raw)
        @password = Password.new(raw['password'])
        @email = Email.new(raw['email'])
      end

      def to_hash
        {
          :email => @email,
          :password => @password
        }
      end

      def empty?
        false
      end

      def each
        yield :email, @email
        yield :password, @password
      end
    end
  end

  class Show
    def self.call(id)
      "id times #{id}"
    end
  end
end

class UserController < App
  include Scorched::RestActions
  render_defaults[:dir] << '/user'
  render_defaults[:layout] = :'../application'

  def index
    render :index, :locals => {:bob => 'haddahsd'}
  end

  def new
    # raise RuntimeError
    render :new
  end

  def create
    form = User::Create::Form.new(request.POST['user'])
    ::User::Record.create form
    flash[:success] = 'aloha'
    redirect '/users'
  end

  def show(id)
    User::Show.call(id)
  end

  def users
    ::User::Record.all
  end
  private

  def current_user
    'mike'
  end
end

App.controller '/users', UserController
run App
