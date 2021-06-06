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
    func selectCountry(index: Int) {
        switch index {
        case 0:
            interactor?.fetchTopHeadlines(country: "us")
        case 1:
            interactor?.fetchTopHeadlines(country: "cn")
        default:
            interactor?.fetchTopHeadlines(country: "jp")
        }
        view?.showLoading()
    }
    
    func showArticleDetailScreen(article: Article) {
        router?.showArticleDetailScreen(article: article)
    }
}

// MARK: - InteractorToPresenterProtocol
extension ArticleListPresenter: ArticleListInteractorToPresenterProtocol{
    func fetchTopHeadlinesSuccess(result: ArticleListResult) {
        view?.showFetchingTopHeadlinesSuccess(result: result)
        view?.hideLoading()
    }
    
    func fetchFailure() {
        view?.showFetchingFailure()
        view?.hideLoading()
    }
}

// MARK: - Business Logic
extension ArticleListPresenter {
}
