require "employee"

class Startup
    attr_reader :name, :funding, :salaries, :employees

    def initialize(name, funding, salaries)
        @name = name
        @funding = funding 
        @salaries = salaries 
        @employees = []
    end

    def valid_title?(title)
        @salaries.has_key?(title)
    end

    def >(startup_2)
        @funding > startup_2.funding
    end

    def hire(employee_name, title)
        if !valid_title?(title)
            raise "Invalid title"
        else
            employee = Employee.new(employee_name, title)
            @employees << employee
        end
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        salary = @salaries[employee.title]
        raise "not enough funding" if salary > @funding

        employee.pay(salary)
        @funding -= salary
    end

    def payday
        @employees.each {|employee| pay_employee(employee)}
    end

    def average_salary
        total_salaries = 0
        num_employees = @employees.length
        @employees.each {|employee| total_salaries += @salaries[employee.title]}
        total_salaries / (num_employees * 1.0)
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(startup_2)
        @funding += startup_2.funding 
        startup_2.salaries.each {|title, salary| @salaries[title] = salary if !@salaries.has_key?(title)}
        @employees += startup_2.employees
        startup_2.close
    end
end
