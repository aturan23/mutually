//
//  ImageService.swift
//  mutually
//
//  Created by Turan Assylkhan on 16.04.2021.
//

import Moya

protocol ImageServiceProtocol {
    func upload(data: Data, type: String, completion: @escaping ResponseCompletion<ImageResponse>)
    func done(completion: @escaping ResponseCompletion<Void>)
}

final class ImageService: ImageServiceProtocol {

    // MARK: - Properties
    
    private let dataProvider: NetworkDataProvider<ImageTarget>
    private let registeredUserHandler: RegisteredUserHandlerProtocol?
    
    // MARK: - Init
    
    init(dataProvider: NetworkDataProvider<ImageTarget>,
         registeredUserHandler: RegisteredUserHandlerProtocol?) {
        self.dataProvider = dataProvider
        self.registeredUserHandler = registeredUserHandler
    }
    
    // MARK: - InboxServiceProtocol
    
    func upload(data: Data, type: String, completion: @escaping ResponseCompletion<ImageResponse>) {
        guard let token = registeredUserHandler?.currentUser?.token else {
            completion(.failure(.unknownError))
            return
        }
        dataProvider.request(.upload(data: data, type: type, token: token)) { (result: ResponseResult<ImageResponse>) in
            switch result {
            case .success(let response): completion(.success(response))
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
