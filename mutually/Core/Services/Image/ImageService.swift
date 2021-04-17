//
//  ImageService.swift
//  mutually
//
//  Created by Turan Assylkhan on 16.04.2021.
//

import Foundation

protocol ImageServiceProtocol {
    func upload(data: Data, type: String, completion: @escaping ResponseCompletion<Void>)
    func done(completion: @escaping ResponseCompletion<Void>)
}

final class ImageService: ImageServiceProtocol {

    // MARK: - Properties
    
    private let dataProvider: NetworkDataProvider<ImageTarget>
    
    // MARK: - Init
    
    init(dataProvider: NetworkDataProvider<ImageTarget>) {
        self.dataProvider = dataProvider
    }
    
    // MARK: - InboxServiceProtocol
    
    func upload(data: Data, type: String, completion: @escaping ResponseCompletion<Void>) {
        dataProvider.request(.upload(data: data, type: type)) { result in
            switch result {
            case .success: completion(.success(()))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
    
    func done(completion: @escaping ResponseCompletion<Void>) {
        dataProvider.request(.uploaded) { result in
            switch result {
            case .success: completion(.success(()))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
}
