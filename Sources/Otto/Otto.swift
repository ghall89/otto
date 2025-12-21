import ArgumentParser

@main
struct Otto: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "otto",
        abstract: "A utility for managing hidden macOS preferences.",
        subcommands: [List.self, Read.self, Set.self]
    )
}

extension Otto {
    struct List: ParsableCommand {
        @Argument(help: "Preference domain")
        var domain: String?

        mutating func run() throws {
            try listCmd(domain: domain)
        }
    }

    struct Read: ParsableCommand {
        @Argument(help: "Preference domain")
        var domain: String?

        @Argument(help: "Preference key")
        var key: String?

        mutating func run() throws {
            try readCmd(domain: domain, key: key)
        }
    }

    struct Set: ParsableCommand {
        @Argument(help: "Preference domain")
        var domain: String?

        @Argument(help: "Preference key")
        var key: String?

        @Argument(help: "Preference value")
        var value: String?

        mutating func run() throws {
            try setCmd(domain: domain, key: key, value: value)
        }
    }
}
