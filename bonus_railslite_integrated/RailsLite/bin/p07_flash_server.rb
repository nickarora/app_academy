require 'webrick'
require_relative '../lib/phase7/controller_base'
require_relative '../lib/phase7/flash'

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
    flash[:errors] = ["!!!MY FLASH MESSAGE!!!"]
    render :index
  end

  def new
    # flash[:errors] = ["WHY ARE THERE SO MANY COOKIES"]
    @dog = $dogs.first
    render :new
  end
end

$dogs = [ Dog.new("Markov", "Ned"), Dog.new("Breakfast", "Ned") ]

router = Phase6::Router.new
router.draw do
  get Regexp.new("^/dogs$"), DogsController, :index
  get Regexp.new("^/dogs/new$"), DogsController, :new
end

server = WEBrick::HTTPServer.new(Port: 3000)
server.mount_proc('/') do |req, res|
  route = router.run(req, res)
end

trap('INT') { server.shutdown }
server.start
