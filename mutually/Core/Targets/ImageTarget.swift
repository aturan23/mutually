//
//  ImageTarget.swift
//  mutually
//
//  Created by Turan Assylkhan on 16.04.2021.
//

import Moya

enum ImageTarget {
    case upload(data: Data, type: String, token: String)
    case uploaded
}

extension ImageTarget: BaseTargetType {
    var task: Task {
        switch self {
        case let .upload(data, type, token):
            let image = MultipartFormData(provider: .data(data), name: "userFile", fileName: "СТС.png", mimeType: "image/png")
            let type = MultipartFormData(provider: .data(type.data(using: .utf8)!), name: "type")
            let action = MultipartFormData(provider: .data("upload_photo".data(using: .utf8)!), name: "action")
            let token = MultipartFormData(provider: .data(token.data(using: .utf8)!), name: "token")
            let platform = MultipartFormData(provider: .data("iOS".data(using: .utf8)!), name: "platform")
            let multipartData = [action, image, type, token, platform]
            
            return .uploadMultipart(multipartData)
        case .uploaded:
            return .requestParameters(
                parameters: [JSONRequestParameter.action.key: "documents_uploaded"],
                encoding: URLEncoding.default)
        }
    }
}
