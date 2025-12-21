import Foundation

struct Shell {
    private let zsh = "/bin/zsh"

    func run(_ cmd: String) -> String {
        let task = Process()
        let pipe = Pipe()

        task.standardOutput = pipe
        task.standardError = pipe
        task.arguments = ["-c", cmd]
        task.launchPath = zsh
        task.standardInput = nil
        task.launch()
        task.waitUntilExit()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        guard let output = String(data: data, encoding: .utf8) else {
            return ""
        }

        return output
    }

    func defaults(_ cmd: String) -> String {
        return self.run("/usr/bin/defaults \(cmd)")
    }
}
