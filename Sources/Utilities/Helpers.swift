import Foundation

func getPreferenceList() -> [Domain] {
    var preferenceList: [Domain] = []

    guard
        let url = Bundle
            .module
            .url(forResource: "SettingsList", withExtension: "json")
    else {
        fatalError("SettingsList.json not found in bundle.")
    }

    do {
        let contents = try Data(contentsOf: url)
        preferenceList = try JSONDecoder().decode([Domain].self, from: contents)
        return preferenceList
    } catch {
        fatalError("Failed to decode SettingsList.json: \(error)")
    }
}

func restartDomain(_ domain: String) {
    let shell = Shell()

    let closeCmd = "osascript -e 'quit app id \"\(domain)\"'"
    let _ = shell.run(closeCmd)
}
