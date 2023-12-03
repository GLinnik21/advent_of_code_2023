# Advent of Code by [@GLinnik21](https://github.com/GLinnik21)

[![Language](https://img.shields.io/badge/language-Swift-red.svg)](https://swift.org)

Solutions for daily programming puzzles at [[Advent of Code 2023](https://adventofcode.com/2023)], by [Eric Wastl](http://was.tl/). This project showcases completed Swift solutions for the challenges.

## Usage

Swift is available with Xcode, or it can be [installed](https://www.swift.org/install/) on macOS, Linux, or Windows platforms.

For Xcode users, open this project via File / Open and select the parent directory. For command line users, run the test suite with `swift test` and execute the solutions with `swift run`.

If you're editing with Visual Studio Code, consider these Swift extensions:
- [Swift](https://marketplace.visualstudio.com/items?itemName=sswg.swift-lang): Provides core language edit/debug/test features.
- [apple-swift-format](https://marketplace.visualstudio.com/items?itemName=vknabel.vscode-apple-swift-format): Supports the [swift-format](https://github.com/apple/swift-format) package.

## Challenges

This project provides ready-to-run solutions for the Advent of Code challenges. Each day's challenge is structured as follows:
- `Data/Day00.txt`: Input data for the challenge.
- `Sources/Day00.swift`: Completed solution code.
- `Tests/Day00.swift`: Unit tests for the challenge.

To explore a specific day's challenge, navigate to the corresponding files. The `AdventOfCode.swift` file allows for easy execution of any day's solution with `swift run`.

To run a specific challenge with command line arguments, use `swift run AdventOfCode`. For benchmarking, use `swift run -c release AdventOfCode --benchmark [day number]`.

## Linting and Formatting

Source code is maintained with `swift-format` for consistency.

Lint the source code:

```shell
$ swift package lint-source-code
```

Format the source code:

```shell
$ swift package format-source-code
Plugin ‘Format Source Code’ wants permission to write to the package directory.
Stated reason: “This command formats the Swift source files”.
Allow this plugin to write to the package directory? (yes/no)
```

For non-interactive formatting, use `--allow-writing-to-package-directory`:

```shell
$ swift package format-source-code --allow-writing-to-package-directory
```

swift-format uses the built-in default style for linting and formatting. A `.swift-format` configuration file can be used for custom styles, as detailed in [Configuration](https://github.com/apple/swift-format/blob/main/Documentation/Configuration.md).
