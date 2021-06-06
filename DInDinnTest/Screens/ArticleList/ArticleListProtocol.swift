//
//  ArticleListProtocol.swift
//  DInDinnTest
//
//  Created by Teerapat on 6/5/21.
//

import Foundation

protocol ArticleListViewToPresenterProtocol {
    var view: ArticleListPresenterToViewProtocol? {get set}
    var interactor: ArticleListPresenterToInteractorProtocol? {get set}
    var router: ArticleListPresenterToRouterProtocol? {get set}
    
    func selectCountry(index: Int)
    func showArticleDetailScreen(article: Article)
}

protocol ArticleListPresenterToViewProtocol {
    func showFetchingTopHeadlinesSuccess(result: ArticleListResult)
    func showFetchingFailure()
    func showLoading()
    func hideLoading()
}

protocol ArticleListPresenterToRouterProtocol {
    static func createModule()-> ArticleListViewController
    func showArticleDetailScreen(article: Article)
}

protocol ArticleListPresenterToInteractorProtocol {
    var presenter: ArticleListInteractorToPresenterProtocol? {get set}
    func fetchTopHeadlines(country: String)
}

protocol ArticleListInteractorToPresenterProtocol {
    func fetchTopHeadlinesSuccess(result: ArticleListResult)
    func fetchFailure()
}
