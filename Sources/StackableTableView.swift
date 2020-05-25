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

/// A `UITableView` subclass that enables setting an array of views for both headers and footers utilizing `UIStackView`
///
///  **Warning**: Do not set `tableHeaderView` or `tableFooterView` directly, use `headerViews` or `footerViews`.
///
open class StackableTableView: UITableView {
    /// Array of views to set as table view headers.
    public var headerViews: [UIView] = [] {
        didSet(oldViews) {
            headerViews.isEmpty ? removeStackView(for: .header) : attachStackView(for: .header)
            updateArrangedViews(remove: oldViews, add: headerViews, in: headerStackView)
        }
    }

    /// Array of views to set as table view footers.
    public var footerViews: [UIView] = [] {
        didSet(oldViews) {
            footerViews.isEmpty ? removeStackView(for: .footer) : attachStackView(for: .footer)
            updateArrangedViews(remove: oldViews, add: footerViews, in: footerStackView)
        }
    }

    /// **Warning**: Do not set `tableHeaderView` directly, add your view to `headerViews` instead.
    public override var tableHeaderView: UIView? {
        didSet {
            if !isTableHeaderViewUsedInternally {
                print("Warning: Do not set `tableHeaderView` directly, add your view to `headerViews` instead.")
            }
        }
    }

    /// **Warning**: Do not set `tableFooterView` directly, add your view to `footerViews` instead.
    public override var tableFooterView: UIView? {
        didSet {
            if !isTableFooterViewUsedInternally {
                print("Warning: Do not set `tableFooterView` directly, add your view to `footerViews` instead.")
            }
        }
    }

    /// The default implementation uses any constraints you have set to determine the size and position of any subviews.
    open override func layoutSubviews() {
        super.layoutSubviews()

        if let view = tableHeaderView {
            layoutView(view, position: .header)
        }

        if let view = tableFooterView {
            layoutView(view, position: .footer)
        }
    }

    // MARK: - Private

    private var isTableHeaderViewUsedInternally = false
    private lazy var headerStackView = createStackView()

    private var isTableFooterViewUsedInternally = false
    private lazy var footerStackView = createStackView()

    internal var lastPrintedMessage: String?
}

// MARK: - Private Helpers

private extension StackableTableView {

    /// Used to differentiate between setting header and footer views.
    enum Position {
        case header
        case footer
    }

    /// Removes view for a position.
    /// - Parameter position: position.
    func removeStackView(for position: Position) {
        switch position {
        case .header:
            isTableHeaderViewUsedInternally = true
            tableHeaderView = nil
            isTableHeaderViewUsedInternally = false
        case .footer:
            isTableFooterViewUsedInternally = true
            tableFooterView = nil
            isTableFooterViewUsedInternally = false
        }
    }

    /// Attaches a view for a position.
    /// - Parameter position: position.
    func attachStackView(for position: Position) {
        switch position {
        case .header:
            isTableHeaderViewUsedInternally = true
            tableHeaderView = headerStackView
            isTableHeaderViewUsedInternally = false
        case .footer:
            isTableFooterViewUsedInternally = true
            tableFooterView = footerStackView
            isTableFooterViewUsedInternally = false
        }
    }

    /// Layout a view based on its position.
    /// - Parameters:
    ///   - view: view to layout.
    ///   - position: position.
    func layoutView(_ view: UIView, position: Position) {
        let height = view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var viewFrame = view.frame

        if height != viewFrame.size.height {
            viewFrame.size.height = height
            view.frame = viewFrame
            switch position {
            case .header:
                isTableHeaderViewUsedInternally = true
                tableHeaderView = view
                isTableHeaderViewUsedInternally = false
            case .footer:
                isTableFooterViewUsedInternally = true
                tableFooterView = view
                isTableFooterViewUsedInternally = false
            }
        }
    }

    /// Creates a plain `UIStackView`.
    func createStackView() -> UIStackView {
        let view = SuperLayoutingStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        return view
    }

    /// Update views in a `UIStackView`.
    /// - Parameters:
    ///   - viewsToRemove: views to be removed from the stack view.
    ///   - viewsToAdd: new views to be added to the stack view.
    ///   - stackView: `UIStackView`.
    func updateArrangedViews(remove viewsToRemove: [UIView], add viewsToAdd: [UIView], in stackView: UIStackView) {
        removeArrangedSubviews(viewsToRemove, from: stackView)
        addArrangedSubviews(viewsToAdd, to: stackView)
    }

    /// Remove an array of views -if they exist- from a `UIStackView`.
    /// - Parameters:
    ///   - views: view to remove.
    ///   - stackView: `UIStackView`.
    func removeArrangedSubviews(_ views: [UIView], from stackView: UIStackView) {
        stackView.arrangedSubviews.forEach { view in
            guard views.contains(view) else { return }
            view.removeFromSuperview()
            stackView.removeArrangedSubview(view)
        }
    }

    /// Add an array of views to a `UIStackView`.
    /// - Parameters:
    ///   - views: views to add.
    ///   - stackView: `UIStackView`.
    func addArrangedSubviews(_ views: [UIView], to stackView: UIStackView) {
        views.forEach { view in
            if stackView.arrangedSubviews.contains(view) { return }
            stackView.addArrangedSubview(view)
        }
    }

    /// Prints a message to console.
    /// - Parameter message: message.
    private func print(_ message: String) {
        Swift.print(message)
        lastPrintedMessage = message
    }
}

// MARK: - Private Subclasses

internal extension StackableTableView {
    /// A subclass of `UIStackView` that calls its superview's `setNeedsLayout` when layouted.
    final class SuperLayoutingStackView: UIStackView {
        override func layoutSubviews() {
            super.layoutSubviews()
            superview?.setNeedsLayout()
        }
    }
}
