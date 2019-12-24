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

final class StackableTableViewTests: XCTestCase {

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
    }

}

private extension StackableTableViewTests {

    func createTableView() -> StackableTableView {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return StackableTableView(frame: frame)
    }

}
