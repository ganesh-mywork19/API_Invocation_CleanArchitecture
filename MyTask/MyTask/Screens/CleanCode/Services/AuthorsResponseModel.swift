//
//  AuthorsResponseModel.swift
//  MyTask
//
//  Created by Ganesh Guturi on 03/09/24.
//

import Foundation

struct AuthorsResponseModel: Codable {
    let entries: [Entries]
    struct Entries: Codable {
        let name: String
        let url: String
        let seedCount: Int
        
        enum CodingKeys: String, CodingKey {
            case name
            case url
            case seedCount = "seed_count"
        }
    }
}


