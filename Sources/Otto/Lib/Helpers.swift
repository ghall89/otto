import Foundation

func getPreferenceList() -> [Domain] {
    var preferenceList: [Domain] = []

    do {
        let url = Bundle
            .module
            .url(
                forResource: "SettingsList",
                withExtension: "json"
            )!

        let contents = try Data(contentsOf: url)

        preferenceList = try JSONDecoder().decode([Domain].self, from: contents)
    } catch {
        print(error)
    }

    return preferenceList
}

func runCmd(
    args: [String],
) -> String {
    let task = Process()
    let pipe = Pipe()

    task.standardOutput = pipe
    task.standardError = pipe
    task.arguments = args
    task.launchPath = "/bin/zsh"
    task.standardInput = nil
    task.launch()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)!

    return output
}
