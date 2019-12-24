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

import UIKit
import StackableTableView

enum DataSource: Int, CustomStringConvertible, CaseIterable {
    case toggleSlider
    case toggleLoremIpsum
    case toggleTags
    case toggleWeb

    var description: String {
        switch self {
            case .toggleSlider:
                return "Toggle Slider Header View"
            case .toggleLoremIpsum:
                return "Toggle Lorem Ipsum Header View"
            case .toggleTags:
                return "Toggle Tags Footer View"
            case .toggleWeb:
                return "Toggle Web Footer View"
        }
    }
}

class ViewController: UIViewController {
    override func loadView() {
        view = StackableTableView(frame: .zero, style: .grouped)
    }

    var tableView: StackableTableView {
        view as! StackableTableView
    }

    lazy var sliderView = SliderView()
    lazy var loremIpsumView = LoremIpsumView()
    lazy var tagsView = TagsView()
    lazy var webView = WebView()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self

        webView.load(URLRequest(url: URL(string: "https://google.com")!))

        tableView.headerViews = [sliderView, loremIpsumView]
        tableView.footerViews = [tagsView, webView]
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataSource.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        cell.selectionStyle = .none
        cell.textLabel?.text = DataSource.allCases[indexPath.row].description
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = DataSource.init(rawValue: indexPath.row) else { return }

        switch item {
            case .toggleSlider:
                sliderView.isHidden.toggle()
            case .toggleLoremIpsum:
                loremIpsumView.isHidden.toggle()
            case .toggleTags:
                tagsView.isHidden.toggle()
            case .toggleWeb:
                webView.isHidden.toggle()
        }
    }

}
