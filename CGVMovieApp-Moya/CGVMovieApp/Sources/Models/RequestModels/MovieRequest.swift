//
//  RequestModels.swift
//  CGVMovieApp
//
//  Created by soyeon on 2021/05/14.
//

import Foundation

struct MovieRequest: Codable {
    var api_key: String
    var language: String
    var page: Int
    
    init(_ api_key: String,_ language: String, _ page: Int = 1) {
        self.api_key = api_key
        self.language = language
        self.page = page
    }
}
