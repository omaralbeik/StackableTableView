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

final class SliderView: UIView {

    private var minHeight: Float = 25
    private var maxHeight: Float = 225

    lazy var heightConstraint = label.heightAnchor.constraint(equalToConstant: CGFloat(minHeight))

    private lazy var slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = minHeight
        slider.maximumValue = maxHeight
        slider.addTarget(self, action: #selector(didChangeSliderValue(_:)), for: .valueChanged)
        return slider
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.text = Int(minHeight).description
        return label
    }()

    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [slider, label])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .black

        addSubview(stackView)
        heightConstraint.isActive = true

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var backgroundColor: UIColor? {
        didSet {
            slider.backgroundColor = backgroundColor
        }
    }

    @objc func didChangeSliderValue(_ slider: UISlider) {
        heightConstraint.constant = CGFloat(slider.value)
        label.text = Int(slider.value).description
    }

}
