//
//  NewsFeed.swift
//  NewsFeedApp
//
//  Created by APLKLAT279106 on 05/03/21.
//

import Foundation

//--------------------------------------------------------------------------
// MARK: - NewsFeedModel Struct
//--------------------------------------------------------------------------

struct NewsFeedModel: Codable {
    let status: String
    let news: [News]
    let page: Int
}

//--------------------------------------------------------------------------
// MARK: - News Struct
//--------------------------------------------------------------------------

struct News: Codable {
    let id, title, newsDescription: String
    let url: String
    let author: String
    let image: String
    let language: String
    let category: [String]
    let published: String
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case newsDescription = "description"
        case url, author, image, language, category, published
    }
}

