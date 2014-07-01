require 'pstore'

db = PStore.new('./p309/test.db')
db.transaction do
	db["params"] = {"name" => "Lloyd", "age" => 31, "salary" => 50000}
end

db.transaction { puts db["params"]}