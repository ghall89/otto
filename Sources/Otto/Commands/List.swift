func listCmd(domain: String?) throws {
    let prefs = try getPreferenceList()

    if domain != nil {
        if let domain = prefs.first(where: { $0.name == domain }) {
            domain.preferences.forEach { pref in
                print("\(pref.name) <\(pref.type)>")
            }
        } else {
            print("No preferences found...")
        }
    } else {
        prefs.forEach { domain in
            print(domain.name)

            domain.preferences.forEach { pref in
                print("  \(pref.name) <\(pref.type)>")
            }
        }
    }
}
