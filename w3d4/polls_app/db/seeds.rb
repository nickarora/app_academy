# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


  ned = User.create!(
    :user_name  => "ned"
  )

  jon = User.create!(
    :user_name  => "jon"
  )

  kush = User.create!(
  :user_name  => "kush"
  )

  jeff = User.create!(
  :user_name  => "jeff"
  )

  mark = User.create!(
  :user_name  => "mark"
  )

  first_poll = ned.authored_polls.create!(
    :title => "App Academy Poll"
  )

  second_poll = jon.authored_polls.create!(
  :title => "Jon's Poll"
  )

  question1 = first_poll.questions.create!(
    :text => "What's your favorite beer?"
  )

  question2 = first_poll.questions.create!(
    :text => "What's your favorite color?"
  )

  question3 = second_poll.questions.create!(
  :text => "What's your favorite car?"
  )

  question4 = second_poll.questions.create!(
  :text => "What's your favorite neighborhood?"
  )

  answer_choice1 =  question1.answer_choices.create!(
    :text => "Racer 5"
  )

  answer_choice2 =  question1.answer_choices.create!(
    :text => "Corona"
  )

  answer_choice3 =  question2.answer_choices.create!(
    :text => "Red"
  )

  answer_choice4 =  question2.answer_choices.create!(
    :text => "Blue"
  )

  answer_choice5 =  question1.answer_choices.create!(
  :text => "Bud Light"
  )

  answer_choice6 =  question3.answer_choices.create!(
  :text => "Yugo"
  )

  answer_choice7 =  question3.answer_choices.create!(
  :text => "Daihatsu"
  )

  answer_choice8 =  question4.answer_choices.create!(
  :text => "Mission"
  )

  answer_choice9 =  question4.answer_choices.create!(
  :text => "Tenderloin"
  )

  response1 = mark.responses.create!(
    :answer_choice_id => answer_choice1.id #racer 5
  )

  response2 = jon.responses.create!(
    :answer_choice_id => answer_choice2.id #corona
  )

  response3 = jon.responses.create!(
    :answer_choice_id => answer_choice3.id #red
  )

  response4 = jeff.responses.create!(
  :answer_choice_id => answer_choice1.id #racer 5
  )

  response5 = kush.responses.create!(
  :answer_choice_id => answer_choice1.id #racer 5
  )
