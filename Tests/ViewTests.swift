/*
 Copyright (c) 2019 Omar Albeik

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import XCTest
@testable import StackableTableView

final class ViewTests: XCTestCase {
    func testHeaderViews() {
        let view = createTableView()
        XCTAssert(view.headerViews.isEmpty)
        XCTAssertNil(view.tableHeaderView)

        let label = UILabel()
        label.text = "Hello World!"

        view.headerViews = [label]
        XCTAssertEqual(view.headerViews, [label])
        XCTAssertNotNil(view.tableHeaderView)

        let headerStackView = view.tableHeaderView as? UIStackView
        XCTAssertNotNil(headerStackView)
        XCTAssertEqual(headerStackView?.arrangedSubviews, [label])

        view.headerViews = []
        XCTAssert(view.headerViews.isEmpty)
        XCTAssertNil(view.tableHeaderView)

        XCTAssertNil(view.lastPrintedMessage)
    }

    func testFooterViews() {
        let view = createTableView()
        XCTAssert(view.footerViews.isEmpty)
        XCTAssertNil(view.tableFooterView)

        let label = UILabel()
        label.text = "Hello World!"

        view.footerViews = [label]
        XCTAssertEqual(view.footerViews, [label])
        XCTAssertNotNil(view.tableFooterView)

        let footerStackView = view.tableFooterView as? UIStackView
        XCTAssertNotNil(footerStackView)
        XCTAssertEqual(footerStackView?.arrangedSubviews, [label])

        view.footerViews = []
        XCTAssert(view.footerViews.isEmpty)
        XCTAssertNil(view.tableFooterView)

        XCTAssertNil(view.lastPrintedMessage)
    }

    func testHeaderWarningMessage() {
        let view = createTableView()
        XCTAssertNil(view.lastPrintedMessage)
        view.tableHeaderView = UIView()
        XCTAssertEqual(view.lastPrintedMessage, "Warning: Do not set `tableHeaderView` directly, add your view to `headerViews` instead.")
    }

    func testFooterWarningMessage() {
        let view = createTableView()
        XCTAssertNil(view.lastPrintedMessage)
        view.tableFooterView = UIView()
        XCTAssertEqual(view.lastPrintedMessage, "Warning: Do not set `tableFooterView` directly, add your view to `footerViews` instead.")
    }

    func testLayoutSubviews() {
        let view = createTableView()
        view.layoutSubviews()
        XCTAssertNil(view.tableHeaderView)
        XCTAssertNil(view.tableFooterView)

        let headerLabel = UILabel()
        headerLabel.text = "Hello world"
        headerLabel.sizeToFit()

        let footerLabel = UILabel()
        footerLabel.text = "Hello world"
        footerLabel.sizeToFit()

        view.headerViews = [headerLabel]
        view.footerViews = [footerLabel]
        view.layoutSubviews()

        XCTAssertEqual(view.tableHeaderView?.frame.size.height, headerLabel.frame.size.height)
        XCTAssertEqual(view.tableFooterView?.frame.size.height, footerLabel.frame.size.height)
    }

    func testSuperLayoutingStackView() {
        let superview = SuperView()
        let subview = StackableTableView.SuperLayoutingStackView()
        superview.addSubview(subview)
        XCTAssertFalse(superview.didCallSetNeedsLayout)
        subview.layoutSubviews()
        XCTAssert(superview.didCallSetNeedsLayout)
    }
}

private class SuperView: UIView {
    var didCallSetNeedsLayout = false
    override func setNeedsLayout() {
        super.setNeedsLayout()
        didCallSetNeedsLayout = true
    }
}

private extension ViewTests {
    func createTableView() -> StackableTableView {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return StackableTableView(frame: frame)
    }
}
