require 'webrick'
require_relative '../lib/final/railslite_controllerbase.rb'

# A Dummy "Model" of a Dog Object
class Dog
  attr_reader :name, :owner

  def initialize(name, owner)
    @name = name
    @owner = owner
  end
end
$dogs = [ Dog.new("Markov", "Ned"), Dog.new("Breakfast", "Ned") ]

# Controller
# Designed to work in a manner similar to Ruby on Rails
class DogsController < RailsLite::ControllerBase

  def index
    render :index
  end

  def new
    @dog = $dogs.first
    render :new
  end

  def create
    flash[:errors] = ["DOG CREATED"] # Just to show that flash works
    redirect_to '/dogs'
  end

end

# Router
# Designed to work in a manner similar to 
# Ruby on Rails' 'config/routes.rb'
router = RailsLite::Router.new
router.draw do
  post Regexp.new("^/dogs$"), DogsController, :create
  get Regexp.new("^/dogs$"), DogsController, :index
  get Regexp.new("^/dogs/new$"), DogsController, :new
end

# The Server
# Comparable to running "rails s" from the command line
server = WEBrick::HTTPServer.new(Port: 3000)
server.mount_proc('/') do |req, res|
  route = router.run(req, res)
end
trap('INT') { server.shutdown }
server.start
