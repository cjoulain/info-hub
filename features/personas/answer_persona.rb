Cucumber::Persona.define("A Question With No Answer") do 
  q = Question.find_or_create_by(title: "Solo Question", body: "No preexisting answer")
  q.update(id: "99999999-9999-9999-9999-999999999999")
end

Cucumber::Persona.define("A Question With One Answer") do 
  q = Question.find_or_create_by!(title: "First question", body: "Quo vadis?")
  q.update(id: "09999999-9999-9999-9999-999999999999")
  a = Answer.create!(body: "The answer you've been waiting for", question_id: q.id)
  a.update(id: "99999999-9999-9999-9999-999999999990")
end

Cucumber::Persona.define("A Question With An Answer To Delete") do 
  q2 = Question.find_or_create_by!(title: "Second question", body: "Filler")
  q2.update(id: "dee0a0c2-e447-4a1e-a638-da53d3d70c60")
  a2 = Answer.create!(body: "An even better answer", question_id: q2.id) 
  a2.update(id: "b96b6139-c9ee-4f8c-b667-c61a5e6daf8e")
end

Cucumber::Persona.define("A Question With Many Answers") do 
  q3 = Question.create!(title: "Another question", body: "Rendering")
  q3.update(id: "0b687481-322e-4276-8cfa-7dced7c3d552")
  a3 = Answer.create!(body: "One answer!", question_id: q3.id)
  a3.update(id: "99999999-9999-9999-9999-999999999999")  
  a4 = Answer.create!(body: "A second answer!", question_id: q3.id)  
end
