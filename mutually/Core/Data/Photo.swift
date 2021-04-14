//
//  Photo.swift
//  mutually
//
//  Created by Turan Assylkhan on 08.04.2021.
//


struct Photo: Codable {
    let title: String
    let group: PhotoGroup
    
    enum CodingKeys: String, CodingKey {
        case title
        case group = "image_group"
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
