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
    func fetchTopHeadlines() {
        ApiProvider.shared.fetchTopHeadlines()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                self?.presenter?.fetchTopHeadlinesSuccess(result: result)
                self?.presenter?.fetchingNewsBySourceSuccess(result: result)
            }, onError: { [weak self] _ in
                self?.presenter?.fetchFailure()
            })
            .disposed(by: disposeBag)
    }
}
