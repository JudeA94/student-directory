require 'csv'
@students = []

def print_menu
  puts '1. Input the students'
  puts '2. Show the students'
  puts '3. Save the list to file'
  puts '4. Load the list from a file'
  puts '5. Show students sorted by cohort'
  puts '6. Show students in height order'
  puts '9. Exit'
end

def interactive_menu
  loop do
    print_menu
    process($stdin.gets.chomp)
  end
end

def process(selection)
  case selection
  when '1' then input_students
  when '2' then show_students
  when '3' then save_students
  when '4'
    puts 'What file would you like to load students from?'
    load_students($stdin.gets.chomp)
  when '5' then show_sorted_students(sort_by_cohort)
  when '6' then show_sorted_students(sort_by_height)  
  when '9' then exit
  else puts "I don't know what you meant, try again"
  end
end

def input_students
  puts 'Please enter the names of the students'
  puts 'To finish, just hit return twice'
  input_name
  puts 'Students inputted succesfully.'
end

def input_name
  name = $stdin.gets.chomp
  until name.empty? do
    @students << { name: name, cohort: input_cohort, height: input_height, hobby: input_hobby }
    puts "Now we have #{@students.count} students"
    name = $stdin.gets.chomp
  end
end

def input_cohort
  puts 'Please enter the cohort.'
  cohort = $stdin.gets.chomp.downcase.capitalize
  if cohort == '' then cohort = 'November' end
  cohort.to_sym
end

def input_hobby
  puts 'Please enter the students favourite hobby.'
  $stdin.gets.chomp.downcase.capitalize
end

def input_height
  puts 'Please enter the students height in centimeters.'
  $stdin.gets.chomp.downcase.capitalize
end

def show_students
  if @students.count.positive?
    print_header
    print_student_list
    print_footer
  else
    puts "We don't have any students yet!"
  end
end

def print_header
  puts 'The students of Villains Academy'
  puts '-------------'
end

def print_student_list
  @students.each_with_index do |student, i|
    puts "#{i+1}. #{student[:name]} (#{student[:cohort]} cohort), Height: #{student[:height]}cm, Hobby: #{student[:hobby]}"
  end
end

def print_footer
  if @students.count == 1
    puts "Overall, we have #{@students.count} great student"
  else
    puts "Overall, we have #{@students.count} great students"
  end
end

def save_students
  puts 'What file name would you like, please include .csv at the end.'
  file_name = $stdin.gets.chomp
  CSV.open(file_name, 'w') do |file|
    write_to_file(file)
  end
  puts 'Students saved succesfully'
end

def load_students(filename = 'students.csv')
  CSV.foreach(filename) do |line|
    name, cohort, height, hobby = line
    add_students(name, cohort, height, hobby)
  end
  puts 'Students loaded succesfully'
end

def add_students(name, cohort, height, hobby)
  @students << { name: name, cohort: cohort.to_sym, height: height, hobby: hobby }
end

def try_load_students
  filename = ARGV.first
  if filename.nil?
    load_students
  else
    load_file(filename)
  end
end

def load_file(filename)
  if File.exist?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

def sort_by_cohort
  cohort_hash = {}
  @students.each do |student|
    if cohort_hash[student[:cohort]].nil?
      cohort_hash[student[:cohort]] = student[:name]
    else
      cohort_hash[student[:cohort]] += ", #{student[:name]}"
    end
  end
  cohort_hash
end

def show_sorted_students(sorted_hash)
  sorted_hash.each do |quality, name|
    puts "#{quality}: #{name}"
  end
end

def sort_by_height
  height_order = {}
  sorted_array = @students.sort_by{ |student| student[:height] }
  sorted_array.each do |student|
    height_order[student[:height]] = student[:name]
  end
  height_order
end

try_load_students
interactive_menu
