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
