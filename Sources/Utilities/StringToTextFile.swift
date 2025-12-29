import Foundation

func stringToTextFile(_ contents: String, filename: String? = "out", out directory: String? = "")
	throws
{
	let fileManager = FileManager.default
	let dirPath = directory ?? fileManager.currentDirectoryPath
	let filePath = (dirPath as NSString).appendingPathComponent("\(filename ?? "out").txt")
	let outPath = URL(fileURLWithPath: filePath)

	if !fileManager.fileExists(atPath: dirPath) {
		try fileManager
			.createDirectory(atPath: dirPath, withIntermediateDirectories: true)
	}

	do {
		try contents
			.trimmingEmptyLines()
			.data(using: .utf8)?
			.write(to: outPath, options: .atomic)
	} catch {
		throw OttoError.runtimeError(error.localizedDescription)
	}
}
