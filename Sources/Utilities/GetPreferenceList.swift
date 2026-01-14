import FileProvider
import Foundation

func getPreferenceList() -> [Domain] {
	var preferenceList = [Domain]()

	let url = getConfigFilePath()

	do {
		let contents = try Data(contentsOf: url)
		preferenceList = try JSONDecoder().decode([Domain].self, from: contents)
		return preferenceList
	} catch let error as NSError where error.domain == NSCocoaErrorDomain && error.code == 260 {
		initConfigFile(FileManager.default, atPath: url)
		return getPreferenceList()
	} catch {
		fatalError("Failed to decode config: \(error)")
	}
}

private func getConfigFilePath() -> URL {
	let fileManager = FileManager.default
	let configFileName = ".otto.json"

	return fileManager.homeDirectoryForCurrentUser.appendingPathComponent(configFileName)
}

private func initConfigFile(_: FileManager, atPath configPath: URL) {
	Logger().info("Creating config file...")

	guard
		let defaultConfig = Bundle
		.module
		.url(forResource: "SettingsList", withExtension: "json")
	else {
		fatalError("SettingsList.json not found in bundle.")
	}

	let data = try! Data(contentsOf: defaultConfig)
	try! data.write(to: configPath)
}
