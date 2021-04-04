//
//  LoadingView.swift
//  mutually
//
//  Created by Turan Assylkhan on 04.04.2021.
//

import UIKit
import Lottie

final class LoadingView: UIView {
    enum Constants {
        static let animationViewSize: CGFloat = 96
        static let backgroundAppearingDuration: Double = 0.3
        static let animationDuration: TimeInterval = 0.25
    }
    
    // MARK: - Properties
    
    var isLoading = false
    
    private let containerView = UIView()
    private let animationView: AnimationView = {
        let view = AnimationView()
        let animation = Animation.named("loading_animation")
        view.animation = animation
        view.contentMode = .scaleAspectFit
        view.animationSpeed = 1.25
        view.backgroundBehavior = .pauseAndRestore
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        alpha = 0
        setupAnimation()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func startLoading() {
        if isLoading { return }
        
        isLoading = true
        animationView.play(
            fromProgress: animationView.currentProgress,
            toProgress: 1,
            loopMode: .loop)
        UIView.animate(withDuration: Constants.animationDuration) { [weak self] in
            self?.alpha = 1
        }
    }
    
    func stopLoading() {
        isLoading = false
        
        UIView.animate(withDuration: Constants.animationDuration, animations: { [weak self] in
            self?.alpha = 0
        }, completion: { [weak self] _ in
            self?.animationView.stop()
        })
    }
    
    // MARK: - Private methods
    
    private func setupAnimation() {
        addSubview(containerView)
        containerView.addSubview(animationView)
        
        containerView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        animationView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(Constants.animationViewSize)
        }
    }
}
