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
    let maskType: MaskType
    
    var pathUrl: URL? {
        guard let path = path else { return nil }
        return URL(string: EnvConfigs.baseUrl)?.appendingPathComponent(path)
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case group = "image_group"
        case path = "file_path"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        group = try container.decode(PhotoGroup.self, forKey: .group)
        path = try container.decodeIfPresent(String.self, forKey: .path)
        maskType = MaskType(rawValue: group == .other ? "Прочее" : title) ?? .none
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

enum MaskType: String, Codable {
    case selfieWithPassport
    case autoPassportFront
    case autoPassportBack
    case rectangle
    case divided
    case none

    
    init?(rawValue: String) {
        switch rawValue {
        case "Селфи с паспортом":
            self = .selfieWithPassport
        case "Водительское удостоверение":
            self = .autoPassportFront
        case "Водительское удостоверение обратная сторона":
            self = .autoPassportBack
        case "СТС", "СТС обратная сторона":
            self = .rectangle
        case "Паспорт регистрация", "ПТС", "ПТС обратная сторона":
            self = .divided
        case "Прочее":
            self = .none
        default:
            self = .divided
        }
    }
}
