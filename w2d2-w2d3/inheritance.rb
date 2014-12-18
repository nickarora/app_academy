class Employee

  attr_accessor :name, :title, :salary, :boss

  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss =  boss
  end

  def inspect
    { :name => @name, :title => @title, :salary => @salary }.inspect
  end

  def bonus(multiplier)
    bonus = salary_for_bonus * multiplier
  end

  def salary_for_bonus
    @salary
  end

end

class Manager < Employee

  attr_accessor :employees

  def initialize(name, title, salary, boss, employees)
    @employees = employees
    super name, title, salary, boss
  end

  def inspect
    { :name => @name,
      :title => @title,
      :salary => @salary,
      :employees => @employees }.inspect
  end

  def salary_for_bonus
    employee_salaries = @employees.map {|employee| employee.salary_for_bonus}
    total_salary = employee_salaries.inject(:+)
  end

  def bonus(multiplier)
    bonus = salary_for_bonus * multiplier
  end

end
