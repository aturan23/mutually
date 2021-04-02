//
//  NetworkResponse.swift
//  mutually
//
//  Created by Turan Assylkhan on 02.04.2021.
//

import Foundation

struct NetworkResponse<T: Codable>: Codable {
    let success: Bool?
}
