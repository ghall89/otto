enum OttoError: Error {
    case invalidInput
    case invalidValue(String)
    case runtimeError(String)
    case unknown

    private static let logger = Logger()

    static func error(_ error: OttoError) -> OttoError {
        logger.error(error.logMessage)
        return error
    }

    private var logMessage: String {
        switch self {
        case .invalidInput: return "Invalid input provided."
        case .invalidValue(let type): return "Invalid \(type) value."
        case .runtimeError(let message): return message
        case .unknown: return "An unknown error occurred."
        }
    }
}
