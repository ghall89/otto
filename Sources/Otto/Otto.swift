import ArgumentParser

@main
struct Otto: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "otto",
        abstract: "A utility for managing hidden macOS preferences.",
        subcommands: [List.self, Get.self, Set.self]
    )
}

extension Otto {
    struct List: ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "List all available preferences."
        )

        @Argument(help: "Preference domain")
        var domain: String?

        mutating func run() throws {
            try listCmd(domain: domain)
        }
    }

    struct Get: ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "Check the current value of a preference."
        )

        @Argument(help: "Preference domain")
        var domain: String

        @Argument(help: "Preference key")
        var key: String

        mutating func run() throws {
            try getCmd(domain: domain, key: key)
        }
    }

    struct Set: ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "Set a new value for a preference."
        )

        @Argument(help: "Preference domain")
        var domain: String

        @Argument(help: "Preference key")
        var key: String

        @Argument(help: "Preference value")
        var value: String

        mutating func run() throws {
            try setCmd(domain: domain, key: key, value: value)
        }
    }
}
