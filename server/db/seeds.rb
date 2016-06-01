# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
lab = Lab.create(name: "Lab 1")
Assignment.create(name: "DigitSum", description: "The Digit Sum assignment from CSCI262", lab: lab)
User.create(multipass_id: "crice")
