file_path = File.join(Rails.root, 'lib', 'data', 'stop_words.txt')
file = open(file_path, "r")
$stop_words = file.read.split("\n")
