struct Domain: Codable {
    var name: String
    var domain: String
    var preferences: [Preference]

    init(name: String, domain: String, preferences: [Preference]) {
        self.name = name
        self.domain = domain
        self.preferences = preferences
    }
}

struct Preference: Codable {
    var name: String
    var key: String
    var type: ValueType

    init(name: String, key: String, type: ValueType) {
        self.name = name
        self.key = key
        self.type = type
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
