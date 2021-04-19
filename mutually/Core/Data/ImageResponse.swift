//
//  ImageResponse.swift
//  mutually
//
//  Created by Turan Assylkhan on 19.04.2021.
//

import Foundation

struct ImageResponse: Codable {
    let urlFile: String?
    
    var pathUrl: URL? {
        guard let path = urlFile else { return nil }
        return URL(string: EnvConfigs.baseUrl)?.appendingPathComponent(path)
    }
    
    enum CodingKeys: String, CodingKey {
        case urlFile = "url_file"
    }
}
