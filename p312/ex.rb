require 'yaml'

all = []
all << "Hello there!"
all << 12345
all << %w[One Two Three]
all << {"This" => "is", "a" => "hash."}

File.open('./p312/data.yaml','w') do |file|
	file.puts all.to_yaml
end

file = File.new('./p312/data.yaml')
arr = YAML.load(file)
file.close
p arr