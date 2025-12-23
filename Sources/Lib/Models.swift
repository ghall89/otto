struct Domain: Codable {
    var name: String
    var domain: String
    var preferences: [Preference]
    var reset_when_applied: Bool? = false

    init(name: String, domain: String, preferences: [Preference], reset_when_applied: Bool?) {
        self.name = name
        self.domain = domain
        self.preferences = preferences
        self.reset_when_applied = reset_when_applied
    }
}

struct Preference: Codable {
    var name: String
    var desc: String
    var key: String
    var type: ValueType
    var options: [String]?

    init(name: String, desc: String, key: String, type: ValueType, options: [String]?) {
        self.name = name
        self.desc = desc
        self.key = key
        self.type = type
        self.options = options
    }
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
