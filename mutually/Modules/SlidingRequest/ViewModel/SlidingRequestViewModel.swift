//
//  SlidingRequestViewModel.swift
//  mutually
//
//  Created by Turan Assylkhan on 04/04/2021.
//  Copyright © 2021 mutually. All rights reserved.
//

class SlidingRequestViewModel: SlidingRequestViewOutput {

    // ------------------------------
	// MARK: - Properties
    // ------------------------------

    weak var view: SlidingRequestViewInput?
    var router: SlidingRequestRouterInput?
    weak var moduleOutput: SlidingRequestModuleOutput?
    var inboxService: InboxServiceProtocol?

    // ------------------------------
    // MARK: - SlidingRequestViewOutput methods
    // ------------------------------

    func didLoad() {
        view?.display(viewAdapter: SlidingRequestViewAdapter())
    }
    
    func didTapContinue(summ: String, term: String) {
        view?.startLoading()
        inboxService?.newInbox(summ: summ, term: term, completion: { [weak self] (result) in
            self?.view?.stopLoading()
            switch result {
            case .success:
                print("Success")
            case .failure(let error):
                self?.router?.showAlert(message: error.message)
            }
        })
    }
}

// ------------------------------
// MARK: - SlidingRequestModuleInput methods
// ------------------------------

extension SlidingRequestViewModel: SlidingRequestModuleInput {
    func configure(data: SlidingRequestConfigData) { }
}
