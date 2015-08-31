ActiveRecord::Base.connection.execute(IO.read("db/tacocopter.sql"))

Answer.destroy_all
Question.destroy_all

q = Question.create!({
  question: "All rows and columns from the <code>cities</code> table"
})
q.answers.create!(answer: 
  "SELECT * 
   FROM cities;")


