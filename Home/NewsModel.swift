//
//  NewsModel.swift
//  NYReader
//
//  Created by Mohammed Gamal  on 24/01/2022.
//

import Foundation

struct NewsResponse : Decodable {
    let news: [NewsModel]
    
    enum Keys : String ,CodingKey {
        case news = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        news = try container.decode([NewsModel].self, forKey: .news)
    }
}


struct NewsModel : Decodable {
    let headLine : String
    let title : String
    let body : String
    
    enum CodingKeys: String, CodingKey {
        case headLine = "byline"
        case title
        case body = "abstract"
    }
    
    init(title: String, headline: String, body: String) {
        self.title = title
        self.headLine = headline
        self.body = body
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        headLine = try values.decode(String.self, forKey: .headLine)
        title = try values.decode(String.self, forKey: .title)
        body = try values.decode(String.self, forKey: .body)
    }
}
