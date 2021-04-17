//
//  ImageService.swift
//  mutually
//
//  Created by Turan Assylkhan on 16.04.2021.
//

protocol ImageServiceProtocol {
    func upload(base64: String, type: String, completion: @escaping ResponseCompletion<Void>)
}

final class ImageService: ImageServiceProtocol {

    // MARK: - Properties
    
    private let dataProvider: NetworkDataProvider<ImageTarget>
    
    // MARK: - Init
    
    init(dataProvider: NetworkDataProvider<ImageTarget>) {
        self.dataProvider = dataProvider
    }
    
    // MARK: - InboxServiceProtocol
    
    func upload(base64: String, type: String, completion: @escaping ResponseCompletion<Void>) {
        dataProvider.request(.upload(base64: base64, type: type)) { result in
            switch result {
            case .success: completion(.success(()))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
}
