struct Preference: Codable {
	var name: String
	var desc: String
	var key: String
	var type: ValueType
	var options: [String]?
}

enum ValueType: String, Codable {
	case string = "-string"
	case data = "-data"
	case int = "-int"
	case float = "-float"
	case bool = "-bool"
	case date = "-date"
	case array = "-array"
	case arrayAdd = "-array-add"
	case dict = "-dict"
	case dictAdd = "-dict-add"
}
