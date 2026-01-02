import SwiftUI

struct NewDomainView: View {
	@State
	private var name = ""
	@State
	private var domain = ""
	@State
	private var resetRequired = false

	var body: some View {
		VStack {
			Form {
				TextField("Name", text: $name)
				TextField("Bundle ID", text: $domain)
				Toggle("Logout required on change?", isOn: $resetRequired)
					.toggleStyle(.checkbox)
			}
			HStack {
				Button("Cancel", action: {})
				Button("Add", action: {})
					.buttonStyle(.borderedProminent)
			}
			.padding(.top)
		}
		.padding()
	}
}
