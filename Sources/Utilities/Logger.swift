import Rainbow

enum LogLevel {
    case info
    case success
    case error
}

struct Logger: Sendable {
    public func info(_ message: String) {
        log(message, level: .info)
    }

    public func success(_ message: String) {
        log(message, level: .success)
    }

    public func error(_ message: String) {
        log(message, level: .error)
    }

    private func log(_ message: String, level: LogLevel) {
        switch level {
        case .info:
            print(message.blue)
        case .success:
            print(message.green)
        case .error:
            print(message.red)
        }
    }
}
