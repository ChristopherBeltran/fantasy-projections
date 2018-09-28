require 'pry'
require 'bundler'
Bundler.require
require 'nokogiri'
require 'open-uri'

require_relative "version"
require_relative 'cli'
require_relative 'scraper'
require_relative 'player'
