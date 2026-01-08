import FileProvider
import Foundation

func getPreferenceList() -> [Domain] {
	var preferenceList = [Domain]()

	let url = getConfigFilePath()

	do {
		let contents = try Data(contentsOf: url)
		preferenceList = try JSONDecoder().decode([Domain].self, from: contents)
		return preferenceList
	} catch {
		fatalError("Failed to decode config: \(error)")
	}
}

private func getConfigFilePath() -> URL {
	let fileManager = FileManager.default
	let configFileName = ".otto.json"

	let configPath = fileManager.homeDirectoryForCurrentUser.appendingPathComponent(configFileName)

	if !fileManager.fileExists(atPath: configPath.path()) {
	  Task {
		  await initConfigFile(fileManager, atPath: configPath)
  	}
	}

	return configPath
}

private func initConfigFile(_ fileManager: FileManager, atPath configPath: URL) async {
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
