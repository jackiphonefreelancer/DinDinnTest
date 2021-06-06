//
//  API.swift
//  DInDinnTest
//
//  Created by Teerapat on 6/5/21.
//

import Moya

enum API {
    case fetchTopHeadlines(country: String)
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
        }
    }
    
    var method: Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .fetchTopHeadlines(let country):
            return .requestParameters(parameters: ["apiKey": APIConfiguration.apiKey,
                                                   "country": country],
                                      encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
