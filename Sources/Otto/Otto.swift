import ArgumentParser

@main
struct Otto: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "otto",
        abstract: "A utility for managing hidden macOS preferences.",
        subcommands: [List.self, Read.self, Set.self]
    )
}

struct Arguments: ParsableArguments {
    @Argument(help: "Preference domain")
    var domain: String?

    @Argument(help: "Preference key")
    var key: String?
}

extension Otto {
    struct List: ParsableCommand {
        @OptionGroup
        var shared: Arguments

        mutating func run() throws {
            try listCmd(domain: shared.domain)
        }
    }

    struct Read: ParsableCommand {
        @OptionGroup
        var shared: Arguments

        mutating func run() throws {
            try readCmd(domain: shared.domain, key: shared.key)
        }
    }

    struct Set: ParsableCommand {
        @OptionGroup
        var shared: Arguments

        @Argument(help: "Preference value")
        var value: String?

        mutating func run() throws {
            try setCmd(domain: shared.domain, key: shared.key, value: value)
        }
    }
}
