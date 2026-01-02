import AppKit
import SwiftUI

@MainActor
final class App {
	let delegate: AppDelegate

	init() {
		delegate = AppDelegate()
	}

	func run() {
		let app = NSApplication.shared
		app.delegate = delegate
		app.setActivationPolicy(.regular)
		app.activate(ignoringOtherApps: true)
		app.run()
	}
}

final class AppDelegate: NSObject, NSApplicationDelegate {
	var window: NSWindow!

	func applicationDidFinishLaunching(_: Notification) {
		let window = NSWindow(
			contentRect: NSRect(x: 0, y: 0, width: 400, height: 300),
			styleMask: [.titled, .closable, .resizable],
			backing: .buffered,
			defer: false,
		)
		window.contentViewController = NSHostingController(
			rootView: ConfigView(),
		)
		window.center()
		window.title = "Otto Config"

		NSApplication.shared.activate(ignoringOtherApps: true)
		window.makeKeyAndOrderFront(nil)

		self.window = window
	}

	func applicationShouldTerminateAfterLastWindowClosed(_: NSApplication) -> Bool {
		true
	}
}
