require 'rubygems'
require 'active_support/all'
require 'pp'
require 'hpricot'
require 'open-uri'
require 'fileutils'

ROOT_PATH = File.expand_path('../../', __FILE__)

Dir.glob(File.join(ROOT_PATH, 'lib', '**', '*.rb')).each do |path|
   require path 
end