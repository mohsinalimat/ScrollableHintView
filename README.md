# ScrollableHintView
Long press on UIView to show hint with scrolling.

<img src="https://github.com/DhruvinThumar/ScrollableHintView/blob/master/ScrollableHintView.gif" width="300" height="650"/>

# Requires Xcode 8 and Swift 3.
Simply add 'ScrollableHintView.swift' file to your Xcode project.

# Usage

Initialize 'ScrollableHintView' in viewDidAppear.

let stepperView = ScrollableHintView.init(viewForLabelToShow: steperView, withWidth: 150, setDownToView:false)
stepperView.hintText = "This is a Hint View, easy to use."
self.view.addSubview(stepperView)


# License
Apache License 2.0

