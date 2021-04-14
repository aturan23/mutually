//
//  InboxService.swift
//  mutually
//
//  Created by Turan Assylkhan on 14.04.2021.
//

final class InboxService: InboxServiceProtocol {

    // MARK: - Properties
    
    private let dataProvider: NetworkDataProvider<InboxTarget>
    private var dataService: DataServiceProtocol?
    private var authService: AuthorizationServiceProtocol?
    
    // MARK: - Init
    
    init(dataProvider: NetworkDataProvider<InboxTarget>,
         dataService: DataServiceProtocol?,
         authService: AuthorizationServiceProtocol?) {
        self.dataProvider = dataProvider
        self.dataService = dataService
        self.authService = authService
    }
    
    // MARK: - InboxServiceProtocol
    
    func newInbox(summ: String, term: String, completion: @escaping ResponseCompletion<FirstScreenResponse>) {
        dataProvider.request(.inbox(summ: summ, term: term)) { [weak self] (result) in
            switch result {
            case .success(let response):
                if response.result {
                    self?.authService?.getFirstScreen(completion: completion)
                    return
                }
                completion(.failure(.unknownError))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
}
