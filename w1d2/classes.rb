class Student
  attr_reader :courses

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
    @courses = []
  end

  def name
    @first_name + @last_name
  end

  def has_conflict?(course)
    courses.each do |enrolled_course|
      return true if enrolled_course.conflicts_with? (course)
    end

    false
  end

  def enroll(course)
    if !courses.include? course and !has_conflict?(course)
      courses << course
      course.add_student(self)
    else
      puts "COURSE CONFLICT FOUND!"
    end
  end

  def course_load
    results = Hash.new(0)
    courses.each do |course|
      results[course.dept] += course.credits
    end

    results
  end

end

class Course

  attr_reader :dept, :credits, :days, :block

  def initialize(course_name, dept, credits, days, block)
    @course_name = course_name
    @dept = dept
    @credits = credits
    @days = days
    @block = block
    @enrolled = []
  end

  def students
    @enrolled
  end

  def add_student(student)
    @enrolled << student unless @enrolled.include? student
  end

  def conflicts_with?(course2)
    days.each do |course1_day|
      course2.days.each do |course2_day|
        if course1_day == course2_day && block == course2.block
           return true # Conflict found
        end
      end
    end
    false
  end

end

if __FILE__ == $0

  student1 = Student.new("Billy", "Bob")
  student2 = Student.new("Barack", "Obama")

  mwf = [:mon, :wed, :fri]
  tt = [:tues, :thurs]

  econ = Course.new("econ", "finance", 10, mwf, 1)
  math = Course.new("math", "mathematics", 20, tt, 1)
  accounting = Course.new("accounting", "finance", 30, mwf, 1)

  # student1.enroll(math)
  # student1.enroll(econ)

  student2.enroll(econ)
  student2.enroll(accounting)

  # p econ.conflicts_with?(math)
  # p econ.conflicts_with?(accounting)

end
