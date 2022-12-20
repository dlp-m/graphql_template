
def create_or_replace_file(file)
  remove_file file
  copy_file file, file
  text = File.read(file)
  new_contents = text.gsub(/ProjectApi/, "#{@app_const_base}")
  File.open(file, "w") {|f| f.puts new_contents }
end

def create_or_replace_folders(files)
  files.each do |file|
    if File.directory?(file)
      create_or_replace_folders(Dir["#{file}/*"])
    else
      file.slice!("#{source_paths.first}/")
      create_or_replace_file(file)
    end
  end
end

def gsub_text(file: , regex: , new_text: )
  text = File.read(file)
  new_contents = text.gsub(regex, new_text)
  puts new_contents
  File.open(file, "w") {|file| file.puts new_contents }
end

def source_paths
  [__dir__]
end

def custom_log(name)
  puts "******************************************************> #{name.upcase} <******************************************************"
end
