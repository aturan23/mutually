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
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addKeyboardObserverIfNeeded()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    // MARK: - Public functions
    
    
    // MARK: - Private functions
    
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
