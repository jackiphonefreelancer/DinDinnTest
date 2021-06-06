//
//  ArticleListInteractor.swift
//  DInDinnTest
//
//  Created by Teerapat on 6/5/21.
//

import Foundation
import Moya
import RxSwift

class ArticleListInteractor {
    var presenter: ArticleListInteractorToPresenterProtocol?
    
    private let disposeBag = DisposeBag()
}

// MARK: - PresenterToInteractorProtocol
extension ArticleListInteractor: ArticleListPresenterToInteractorProtocol {
    func fetchTopHeadlines(country: String) {
        ApiProvider.shared.fetchTopHeadlines(country: country)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                self?.presenter?.fetchTopHeadlinesSuccess(result: result)
            }, onError: { [weak self] _ in
                self?.presenter?.fetchFailure()
            })
            .disposed(by: disposeBag)
    }
}
