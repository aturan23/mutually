//
//  WebViewController.swift
//  mutually
//
//  Created by Turan Assylkhan on 06.04.2021.
//

import UIKit
import WebKit
import Alamofire

class WebViewController: BaseViewController {
    
    private enum Constants {
        static let webViewEstimatedProgress = "estimatedProgress"
        static let buttonSize = 24
    }
    
    // ------------------------------
    // MARK: - Properties
    // ------------------------------
    
    private var urlLink: URL
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.iconClose.image, for: .normal)
        button.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        return button
    }()
    private let titleLabel = LabelFactory().make(
        withStyle: .headingH5,
        textAlignment: .center)
    private let progressView = UIProgressView()
    private let webView = WKWebView()
    
    // ------------------------------
    // MARK: - Life cycle
    // ------------------------------
    
    init(urlLink: URL) {
        self.urlLink = urlLink
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        let request = URLRequest(url: urlLink)
        let isReachable = NetworkReachabilityManager()?.isReachable ?? true
        if isReachable {
            
            webView.load(request)
        } else {
            
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        webView.removeObserver(self, forKeyPath: Constants.webViewEstimatedProgress, context: nil)
    }
    
    // ------------------------------
    // MARK: - Private methods
    // ------------------------------
    
    @objc private func didTapClose() {
        dismiss(animated: true)
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        webView.addObserver(self, forKeyPath: Constants.webViewEstimatedProgress, options: .new, context: nil)
        
        [closeButton, titleLabel, progressView, webView].forEach(view.addSubview(_:))
        
        closeButton.snp.makeConstraints {
            $0.size.equalTo(Constants.buttonSize)
            $0.right.equalTo(-20)
            $0.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(LayoutGuidance.offset)
            $0.centerX.equalToSuperview()
        }
        
        webView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(LayoutGuidance.offset)
            $0.width.bottom.equalToSuperview()
        }
        progressView.snp.makeConstraints {
            $0.top.equalTo(closeButton.snp.bottom).offset(4)
            $0.width.equalToSuperview()
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard keyPath == Constants.webViewEstimatedProgress else { return }
        let progress = Float(webView.estimatedProgress)
        if progress > 0.9 {
            progressView.isHidden = true
        } else {
            progressView.setProgress(progress, animated: true)
        }
    }
    
}
