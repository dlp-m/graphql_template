
def create_or_replace_file(file)
  remove_file file
  copy_file file, file
  text = File.read(file)
  new_contents = text.gsub(/ProjectApi/, "#{@app_const_base}")
  File.open(file, "w") {|f| f.puts new_contents }
end

def custom_log(name)
  puts "******************************************************> #{name.upcase} <******************************************************"
end
