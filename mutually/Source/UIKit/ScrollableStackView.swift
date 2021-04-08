//
//  ScrollableStackView.swift
//  mutually
//
//  Created by Turan Assylkhan on 08.04.2021.
//

import UIKit

class ScrollableStackView: UIView {
    
    var scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    required init(alignment: UIStackView.Alignment = .top,
                     axis: NSLayoutConstraint.Axis = .vertical,
                     distribution: UIStackView.Distribution = .equalSpacing,
                     spacing: CGFloat = 12.0)
    {
        super.init(frame: .zero)
        stackView.alignment = alignment
        stackView.axis = axis
        stackView.distribution = distribution
        stackView.spacing = spacing
        stackView.isUserInteractionEnabled = true
        isUserInteractionEnabled = true
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width)
        }
    }
    
    func add(subview: UIView, isHidden: Bool = false) {
        stackView.addArrangedSubview(subview)
        subview.isHidden = isHidden
        subview.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
    }
    
    func adjustSubviews(isHide: Bool, startIndex: Int, endIndex: Int) {
        for (index, subview) in stackView.arrangedSubviews.enumerated() {
            if index >= startIndex && index <= endIndex {
                subview.isHidden = isHide
            }
        }
    }
    
    func removeAllFromStackView() {
        for view in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
    
    func addSeparator(left: CGFloat = 0.0, right: CGFloat = 0.0) {
        let view = UIView()
        view.backgroundColor = UIColor.groupTableViewBackground
        stackView.addArrangedSubview(view)
        view.snp.makeConstraints {
            $0.left.equalTo(left)
            $0.right.equalTo(right)
            $0.height.equalTo(1)
        }
    }
    
    func addSpaceView(with spacing: CGFloat) {
        let spaceView = UIView()
        spaceView.snp.makeConstraints {
            $0.height.equalTo(spacing)
        }
        add(subview: spaceView)
    }
}
