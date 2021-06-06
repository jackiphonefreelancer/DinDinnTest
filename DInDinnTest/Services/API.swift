//
//  API.swift
//  DInDinnTest
//
//  Created by Teerapat on 6/5/21.
//

import Moya

enum API {
    case fetchTopHeadlines
    case fetchNewsBySource(source: String)
}

extension API: TargetType {
    var sampleData: Data {
        return Data()
    }
    
    var baseURL: URL {
        guard let url = URL(string: APIConfiguration.apiBaseUrl) else {
            fatalError()
        }
        return url
    }
    
    var path: String {
        switch self {
        case .fetchTopHeadlines:
            return "top-headlines"
        case .fetchNewsBySource:
            return "top-headlines"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .fetchTopHeadlines:
            return .requestParameters(parameters: ["apiKey": APIConfiguration.apiKey,
                                                   "country": "us"],
                                      encoding: URLEncoding.queryString)
        case .fetchNewsBySource(let source):
            return .requestParameters(parameters: ["apiKey": APIConfiguration.apiKey,
                                                   "country": "us",
                                                   "source" : source],
                                      encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
