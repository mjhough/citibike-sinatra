require 'rubygems'
require 'bundler'
require "sinatra/reloader"

Bundler.require

Dir.glob('./lib/*.rb') do |model|
  require model
end

module Citibike
	class App < Sinatra::Application
    configure :development do
      register Sinatra::Reloader
    end

    before do
      json = File.open("data/citibikenyc.json").read
      @data = MultiJson.load(json)
    end

    get '/' do
      erb :home
    end

    get "/form" do
      erb :form
    end

    post "/form" do
      "You chose #{params["start"]} and #{params["end"]}"
    end

    post "/map" do
      @start = params["start"]
      @end = params["end"]

      @start_lat = @start.split(",")[0].gsub(/[^\d.-]/, "").to_f
      @start_lng = @start.split(",")[1].gsub(/[^\d.-]/, "").to_f

      @end_lat = @end.split(",")[0].gsub(/[^\d.-]/, "").to_f
      @end_lng = @end.split(",")[1].gsub(/[^\d.-]/, "").to_f

      erb :map
    end

  end
end