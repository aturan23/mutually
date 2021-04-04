//
//  BaseViewController.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

import UIKit

class BaseViewController: UIViewController {
    
    private enum Constants {
        static let backgroundAppearingDuration: Double = 0.3
    }
    
    private let loadingView: LoadingView = {
        let view = LoadingView()
        view.layer.zPosition = 10
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.alpha = 0.0
        view.frame = view.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingView()
        addKeyboardObserverIfNeeded()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    // MARK: - Public functions
    
    func showLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.loadingView.startLoading()
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.loadingView.stopLoading()
        }
    }
    
    // MARK: - Private functions
    
    private func setupLoadingView() {
        view.addSubview(loadingView)
        
        loadingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - Observers

extension BaseViewController {
    
    
    private func addKeyboardObserverIfNeeded() {
        guard let listening = self as? KeyboardListening else {
            return
        }
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(listening.keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(listening.keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
}
