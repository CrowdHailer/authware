require 'scorched'

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

class UserController < RestController
  render_defaults[:dir] << '/user'
  def new
    render :new
  end

  def show(id)
    puts id
  end
end

App.controller '/user', UserController
puts App.mappings
run App
