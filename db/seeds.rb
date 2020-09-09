# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

initial_question = Question.create!(title: "First question", body: "Quo vadis?")

require 'cucumber/persona'
require_relative '../features/personas'

Cucumber::Persona.create_all