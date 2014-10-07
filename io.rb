def save_list(str,file_name)
	File.open(file_name, "w") do |f|
		f <<str
	end
	puts "Saved #{file_name}"
end