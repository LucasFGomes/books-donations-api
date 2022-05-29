# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'json'

module BRPopulate
  def self.data
    arquivo = File.open('db/states.json')
    JSON.parse arquivo.read
  end

  def self.capital?(city, json)
    city['name'] == json['capital']
  end

  def self.populate
    data.each do |json|
      state = State.new(state_code: json['acronym'], name: json['name'], code: json['code'])
      state.save

      json['cities'].each do |city|
        c = City.new
        c.name = city['name']
        c.code = city['code']
        c.state_id = state.id
        c.capital = capital?(city, json)
        c.save
      end
    end
  end
end

BRPopulate.populate if City.all.empty?
