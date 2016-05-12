#!/usr/bin/env ruby

$LOAD_PATH[0, 0] = File.join(File.dirname(__FILE__), '..', 'lib')
require 'pry'
require 'mongo'

# include the mongo namespace
include Mongo

client = Mongo::Client.new("mongodb://localhost:27017/?ssl=true&sslVerify=false")

binding.pry

client

