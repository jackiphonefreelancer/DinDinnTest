//
//  ArticleListPresenter.swift
//  DInDinnTest
//
//  Created by Teerapat on 6/5/21.
//

import Foundation

class ArticleListPresenter {
    var view: ArticleListPresenterToViewProtocol?
    var interactor: ArticleListPresenterToInteractorProtocol?
    var router: ArticleListPresenterToRouterProtocol?
}

// MARK: - ViewToPresenterProtocol
extension ArticleListPresenter: ArticleListViewToPresenterProtocol {
    func fetchTopHeadlines() {
        interactor?.fetchTopHeadlines()
    }
    
    func fetchNewsBySource(source: String) {
        
    }
    
    func showArticleDetailScreen() {
        router?.showArticleDetailScreen()
    }
}

// MARK: - InteractorToPresenterProtocol
extension ArticleListPresenter: ArticleListInteractorToPresenterProtocol{
    func fetchTopHeadlinesSuccess(result: ArticleListResult) {
        view?.showFetchingTopHeadlinesSuccess(result: result)
    }
    
    func fetchingNewsBySourceSuccess(result: ArticleListResult) {
        view?.showFetchingNewsBySourceSuccess(result: result)
    }
    
    func fetchFailure() {
        view?.showFetchingFailure()
    }
}

// MARK: - Business Logic
extension ArticleListPresenter {
}
