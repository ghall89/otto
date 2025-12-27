import ArgumentParser
import Foundation
import Rainbow

extension Otto {
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
            try set(domain: domain, key: key, value: value)
        }

        private func set(domain: String, key: String, value: String) throws {
            let shell = Shell()

            let (domainId, preferenceKey, valueType, resetWhenApplied) =
                try fetchPreferenceMetadata(domain: domain, key: key)

            let checkedValue = try checkValue(value, valueType: valueType)

            let cmd = "write \(domainId) \"\(preferenceKey)\" \(valueType.rawValue) \(checkedValue)"

            let _ = shell.defaults(cmd)

            print(
                "\(domain.bold.underline) \(key.bold.underline) set to \(value.bold.underline)"
                    .green)

            if resetWhenApplied == true {
                print("You will need to log out and back in for your changes to take effect.")
            }

        }

        private func checkValue(_ value: String?, valueType: ValueType) throws -> String {
            if value == nil {
                throw OttoError.runtimeError("No value provided.")
            }

            let BOOL_VALUES = ["yes", "no", "true", "false"]

            switch valueType {
            case .bool:
                if !BOOL_VALUES.contains(value!) {
                    throw OttoError.invalidValue("bool")
                }
            case .int:
                if Int(value!) == nil {
                    throw OttoError.invalidValue("integer")
                }
            case .float:
                if Float(value!) == nil {
                    throw OttoError.invalidValue("float")
                }
            case .string:
                return "\"\(value!)\""
            default:
                throw OttoError.invalidInput
            }

            return value!
        }
    }
}
