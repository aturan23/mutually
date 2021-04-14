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
    
    // MARK: - Init
    
    init(dataProvider: NetworkDataProvider<InboxTarget>,
         dataService: DataServiceProtocol?) {
        self.dataProvider = dataProvider
        self.dataService = dataService
    }
    
    // MARK: - InboxServiceProtocol
    
    func newInbox(summ: Double, term: Int, completion: @escaping ResponseCompletion<Void>) {
        dataProvider.request(.inbox(summ: summ, term: term)) { (result) in
            switch result {
            case .success(let response):
                if response.result {
                    completion(.success(()))
                    return
                }
                completion(.failure(.unknownError))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
}
