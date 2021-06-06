//
//  ArticleListEntity.swift
//  DInDinnTest
//
//  Created by Teerapat on 6/5/21.
//

import Foundation
import ObjectMapper

struct ArticleListResult: Mappable {
    var status: String?
    var totalResults: Int?
    var articles: [Article]?

    init?(map: Map){
    }

    mutating func mapping(map: Map) {
        status <- map["status"]
        totalResults <- map["totalResults"]
        articles <- map["articles"]
    }
}

struct Article: Mappable {
    var source: ArticleSource?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
    
    init?(map: Map){
    }

    mutating func mapping(map: Map) {
        source <- map["source"]
        author <- map["author"]
        title <- map["title"]
        description <- map["description"]
        url <- map["url"]
        urlToImage <- map["urlToImage"]
        publishedAt <- map["publishedAt"]
        content <- map["content"]
    }
}

struct ArticleSource: Mappable {
    var id: String?
    var name: String?
    
    init?(map: Map){
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
