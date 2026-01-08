func restartDomain(_ domain: String) {
	let shell = Shell()

	shell.osascript("quit app id \"\(domain)\"")
}
