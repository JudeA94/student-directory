#students in an array

def print_header
  puts  "The students of Villains Academy"
  puts  "-------------"
end

def longest_name(students)
  x = 0
  students.each do |student|
    if student[:name].length > x
      x = student[:name].length
    end
  end
  x+18
end

def print(students)
  i = 0
  until i == students.length
    puts " #{students[i][:name]} (#{students[i][:cohort]}) cohort".center(longest_name(students))
    i += 1
  end
end

def print_footer(names)
  if names.count == 1
    puts "Overall, we have #{names.count} great student"
  else
    puts "Overall, we have #{names.count} great students"
  end
end

def input_students
  cohorts = ['Unkown Cohort','January','February','March','April','May','June','July','Aughust','September','October','November','December']
  puts "Please enter the names of the students, followed by the cohort by month. If the cohort is unkown you can leave it blank."
  puts "To finish, just hit return twice"
  #Create an empty array
  students = []
  #get the first name
  name = gets.chomp.capitalize
  cohort = gets.chomp.capitalize
  #While the array is not empty repeat this code
  while !name.empty? do
    if cohort.empty?
      cohort = "Unkown Cohort"
    end
    until cohorts.include?(cohort)
      puts "Please re enter the cohort by month."
      cohort = gets.chomp.capitalize
    end
    students << {name: name, cohort: cohort}
    if students.count == 1
      puts "Now we have #{students.count} student"
    else
      puts "Now we have #{students.count} students"
    end  
    #Get another name from the user
    name = gets.chomp.capitalize
    cohort = gets.chomp.capitalize.to_s
  end
  #Return the array of students
  students
end

def print_by_cohorts(students)
  students_by_cohort = {}
  students.each do |student|
    cohort = student[:cohort]
    if students_by_cohort[cohort] == nil
      students_by_cohort[cohort] = []
    end
    students_by_cohort[cohort].push(student[:name])
  end
  students_by_cohort.each do |cohort,student_array|
    puts cohort
    student_array.each do |name|
      puts name
    end
  end
end

students = input_students
print_header
print(students)
print_footer(students)
puts "--------"
print_by_cohorts(students)
