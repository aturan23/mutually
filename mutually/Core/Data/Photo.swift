//
//  Photo.swift
//  mutually
//
//  Created by Turan Assylkhan on 08.04.2021.
//

import Foundation

struct Photo: Codable {
    let title: String
    let group: PhotoGroup
    let path: String?
    
    var pathUrl: URL? {
        guard let path = path else { return nil }
        return URL(string: EnvConfigs.baseUrl)?.appendingPathComponent(path)
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case group = "image_group"
        case path = "file_path"
    }
}

enum PhotoGroup: String, Codable {
    case documents = "1"
    case auto = "2"
    case other = "3"
    
    var title: String {
        switch self {
        case .documents:
            return "Документы"
        case .auto:
            return "Фото автомобиля"
        case .other:
            return "Прочее"
        }
    }
}
