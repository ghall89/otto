enum OttoError: Error {
	case invalidInput
	case invalidValue(String)
	case runtimeError(String)
	case unknown

	private static let logger = Logger()

	private var logMessage: String {
		switch self {
			case .invalidInput: "Invalid input provided."
			case let .invalidValue(type): "Invalid \(type) value."
			case let .runtimeError(message): message
			case .unknown: "An unknown error occurred."
		}
	}

	static func error(_ error: OttoError) -> OttoError {
		logger.error(error.logMessage)
		return error
	}
}
