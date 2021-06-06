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
    
    func fetchTopHeadlines()
    func fetchNewsBySource(source: String)
    func showArticleDetailScreen()
}

protocol ArticleListPresenterToViewProtocol {
    func showFetchingTopHeadlinesSuccess(result: ArticleListResult)
    func showFetchingNewsBySourceSuccess(result: ArticleListResult)
    func showFetchingFailure()
}

protocol ArticleListPresenterToRouterProtocol {
    static func createModule()-> ArticleListViewController
    func showArticleDetailScreen()
}

protocol ArticleListPresenterToInteractorProtocol {
    var presenter: ArticleListInteractorToPresenterProtocol? {get set}
    func fetchTopHeadlines()
}

protocol ArticleListInteractorToPresenterProtocol {
    func fetchTopHeadlinesSuccess(result: ArticleListResult)
    func fetchingNewsBySourceSuccess(result: ArticleListResult)
    func fetchFailure()
}
