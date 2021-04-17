//
//  ImageTarget.swift
//  mutually
//
//  Created by Turan Assylkhan on 16.04.2021.
//

import Moya

enum ImageTarget {
    case upload(data: Data, type: String)
}

extension ImageTarget: BaseTargetType {
    var task: Task {
        switch self {
        case let .upload(data, _):
            let model = Model(userFile: data)
            return .requestJSONEncodable(model)
        }
    }
}

struct Model: Codable {
    var action: String = "upload_photo"
    var type: String = "3"
    var userFile: Data
}

func multipartFormData(_ image: String, _ name: String) -> MultipartFormData{
    let formData = MultipartFormData(provider: .data(image.data(using: .utf8)!), name: name, mimeType: "image/png")
    return formData
}

extension Encodable {
    /// Converts Codable-conformant class or struct instance into swift dictionary, if possible
    func toDict() -> [String: Any] {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(self)
            let dict: [String: Any] = try JSONSerialization.jsonObject(
                with: data, options: .mutableLeaves)
                as? [String: Any] ?? [String: Any]()
            return dict
        } catch {
            return [String: Any]()
        }
    }
}
