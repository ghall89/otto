import Foundation
import Rainbow

func setCmd(domain: String?, key: String?, value: String?) throws {
    let shell = Shell()
    let prefs = try getPreferenceList()

    let (domainId, preferenceKey, valueType, resetWhenApplied) = try getPreferenceValues(
        prefs: prefs, domain: domain, key: key)

    let checkedValue = try checkValue(value, valueType: valueType)

    let cmd = "write \(domainId) \"\(preferenceKey)\" \(valueType.rawValue) \(checkedValue)"

    let _ = shell.defaults(cmd)

    if resetWhenApplied == true {
        restartDomain(domainId)
    }

    exit(EXIT_SUCCESS)
}

func checkValue(_ value: String?, valueType: ValueType) throws -> String {
    if value == nil {
        throw OttoError.runtimeError("No value provided.")
    }

    let BOOL_VALUES = ["yes", "no", "true", "false"]

    switch valueType {
    case .bool:
        if !BOOL_VALUES.contains(value!) {
            throw OttoError.runtimeError("Invalid boolean value.".red)
        }
    case .int:
        if Int(value!) == nil {
            throw OttoError.runtimeError("Invalid integer value.".red)
        }
    case .float:
        if Float(value!) == nil {
            throw OttoError.runtimeError("Invalid float value.".red)
        }
    case .string:
        return "\"\(value!)\""
    default:
        print("Unhandled value type.".red)
        exit(EXIT_FAILURE)
    }

    return value!
}
