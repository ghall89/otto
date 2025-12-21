import ArgumentParser

@main
struct Otto: ParsableCommand {
    var prefs = getPreferenceList()

    @Flag(name: .shortAndLong, help: "List available preferences.")
    var list: Bool = false

    @Flag(name: .shortAndLong, help: "Read current preference value.")
    var read: Bool = false

    @Flag(name: .shortAndLong, help: "Set new preference value.")
    var set: Bool = false

    @Argument(help: "Preference domain")
    var domain: String?

    @Argument(help: "Preference key")
    var key: String?

    mutating func run() throws {
        if list == true {
            listCmd(prefs: prefs, domain: domain)
        }

        if read == true {
            print("WIP - Coming soon")
        }

        if set == true {
            print("WIP - Coming soon")
        }
    }
}
