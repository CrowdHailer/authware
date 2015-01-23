require 'bundler/setup'
require 'scorched'
require 'typtanic/email'
require 'typtanic/password'
require './lib/password'
require 'awesome_print'
puts require_relative './lib/user'

class App < Scorched::Controller
end

class RestController < App
  def self.inherited(klass)
    klass.get('/') { invoke_action :index }
    klass.get('/new') { invoke_action :new }
    klass.post('/') { invoke_action :create }
    klass.get('/:id') {|*captures| invoke_action :show, *captures }
    klass.get('/:id/edit') { invoke_action :edit }
    klass.route('/:id', method: ['PATCH', 'PUT']) { invoke_action :update }
    klass.delete('/:id') { invoke_action :delete }
  end
  def invoke_action(action, *captures)
    respond_to?(action) ? send(action, *captures) : pass
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
end

class UserController < RestController
  render_defaults[:dir] << '/user'
  render_defaults[:layout] = :'../application'
  def index
    ap request.breadcrumb
    ::User::Record.all.map(&:email).join('<br>')
  end

  def new
    render :new
  end

  def create
    form = User::Create::Form.new(request.POST['user'])
    ::User::Record.create form
    redirect '/users'
  end

  def show(id)
    puts id
  end
end

App.controller '/users', UserController
run App
