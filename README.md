# Otto

Manage hidden macOS preferences from the command line.

__This tool changes hidden preferences not intended to be modified, and you may experience unexpected behavior or issues. You assume any risk from using this tool.__

## Build From Source

Ensure you have the latest version of [Xcode](https://developer.apple.com/xcode/) installed. [Task](https://github.com/go-task/task) is only required if you'd like to use the included Taskfile.

After building, your executable will be located at `.build/apple/Products/Release/otto`

### Building With Task

`task build`

### Building With the Swift CLI

`swift build -c release --arch arm64 --arch x86_64`
