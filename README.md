SRTextInputSourceManager
========================

[![Platform macOS](https://img.shields.io/badge/Platform-macOS-blue.svg?style=flat)](https://github.com/seorenn/SRTextInputSourceManager) [![Swift 5](https://img.shields.io/badge/Swift-5.0-orange.svg?style=flat)](https://github.com/seorenn/SRTextInputSourceManager) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

The Text Input Source Manager for macOS. This Framework using Carbon TIS APIs.

<pre>
// Getting Input Source Instance List
let inputSources = SRTextInputSourceManager.shared.inputSources

// Getting Current Activating Input Source Instance
let currentInputSource = SRTextInputSourceManager.shared.activatingInputSource

// Getting Input Source Informations
let inputSource = inputSources[someIndex]
print("Name = \(inputSource.localizedName)")
print("Identifier = \(inputSource.identifier)")

// Activating Input Source
inputSource.activate()
</pre>

# Licensing

SRTextInputSourceManager is licensed under MIT License Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
