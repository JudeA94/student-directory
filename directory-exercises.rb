@students = [] # an empty array accessible to all methods

def input_students
  puts 'Please enter the names of the students'
  puts 'To finish, just hit return twice'
  name = $stdin.gets.chomp # get the first name
  until name.empty? # while the name is not empty, repeat this code
    add_students(name, 'november') # add the student hash to the array
    puts "Now we have #{@students.count} students"
    name = $stdin.gets.chomp # get another name from the user
  end
  puts 'Students inputted succesfully'
end

def interactive_menu
  loop do
    print_menu
    process($stdin.gets.chomp)
  end
end

def print_menu
  puts '1. Input the students'
  puts '2. Show the students'
  puts '3. Save the list to file'
  puts '4. Load the list from a file'
  puts '9. Exit' # 9 because we'll be adding more items
end

def show_students
  print_header
  print_student_list
  print_footer
end

def process(selection)
  case selection
  when '1'
    input_students
  when '2'
    show_students
  when '3'
    save_students
  when '4'
    puts 'What file would you like to load students from?'
    load_students($stdin.gets.chomp)
  when '9'
    exit # this will cause the program to terminate
  else
    puts "I don't know what you meant, try again"
  end
end

def print_header
  puts 'The students of Villains Academy'
  puts '-------------'
end

def print_student_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def save_students
  puts 'What file name and extension would you like, e.g. textfile.txt'
  file_name = $stdin.gets.chomp
  File.open(file_name, 'w') do |file| # open the file for writing
    write_to_file(file)
  end
  puts 'Students saved succesfully'
end

def write_to_file(file)
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(',')
    file.puts csv_line
  end
end

def load_students(filename = 'students.csv')
  File.open(filename, 'r') do |file|
    file.readlines.each do |line|
      name, cohort = line.chomp.split(',')
      add_students(name, cohort)
    end
  end
  puts 'Students loaded succesfully'
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  if filename.nil? # load students.csv if no filename given
    load_students
  else
    load_file(filename)
  end
end

def add_students(name, cohort)
  @students << { name: name, cohort: cohort.to_sym }
end

def load_file(filename)
  if File.exist?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

try_load_students
interactive_menu
