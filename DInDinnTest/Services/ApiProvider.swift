//
//  ApiProvider.swift
//  DInDinnTest
//
//  Created by Teerapat on 6/5/21.
//

import Moya
import ObjectMapper
import RxSwift

enum AppError: Error {
    case unkknown
    case apiError
}

class ApiProvider {
    static let shared = ApiProvider()

    let disposable = Disposables.create()
    var provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin()])
    
    func fetchTopHeadlines() -> Observable<ArticleListResult> {
        return Observable.create { o -> Disposable in
            self.provider.request(.fetchTopHeadlines) { response in
                switch response {
                case let .success(result):
                    if let jsonString = String(data: result.data, encoding: .utf8),
                       let value = Mapper<ArticleListResult>().map(JSONString: jsonString) {
                        o.onNext(value)
                    } else {
                        o.onError(AppError.apiError)
                    }
                case let .failure(error):
                    o.onError(error)
                }
            }
            return Disposables.create {
                self.disposable.dispose()
            }
        }
        
    }
}
