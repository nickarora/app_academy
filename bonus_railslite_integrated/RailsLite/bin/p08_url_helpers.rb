require 'webrick'
require_relative '../lib/phase8/controller_base'

class Dog
  attr_reader :name, :owner

  def initialize(name, owner)
    @name = name
    @owner = owner
  end

end

class DogsController < Phase8::ControllerBase
  include Phase7

  def index
    render :index
  end

  def new
    @dog = $dogs.first
    render :new
  end

  def create
    flash[:errors] = ["DOG CREATED"]
    redirect_to '/dogs'
  end
end

$dogs = [ Dog.new("Markov", "Ned"), Dog.new("Breakfast", "Ned") ]

router = Phase6::Router.new
router.draw do
  post Regexp.new("^/dogs$"), DogsController, :create
  get Regexp.new("^/dogs$"), DogsController, :index
  get Regexp.new("^/dogs/new$"), DogsController, :new
end

server = WEBrick::HTTPServer.new(Port: 3000)
server.mount_proc('/') do |req, res|
  route = router.run(req, res)
end

trap('INT') { server.shutdown }
server.start
