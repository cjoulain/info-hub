Cucumber::Persona.define("First") do 
  q = Question.create!(title: "First question", body: "Quo vadis?")
end

Cucumber::Persona.define("Second") do 
  q2 = Question.create!(title: "Second question", body: "Filler")
end