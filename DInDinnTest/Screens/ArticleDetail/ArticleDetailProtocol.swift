//
//  ArticleDetailProtocol.swift
//  DInDinnTest
//
//  Created by Teerapat on 6/6/21.
//

import Foundation

protocol ArticleDetailViewToPresenterProtocol {
    var view: ArticleDetailPresenterToViewProtocol? {get set}
    var interactor: ArticleDetailPresenterToInteractorProtocol? {get set}
    var router: ArticleDetailPresenterToRouterProtocol? {get set}
    
    func selectTabInfo(index: Int)
}

protocol ArticleDetailPresenterToViewProtocol {
    func showDescription()
    func showSource()
    func showAuthor()
}

protocol ArticleDetailPresenterToRouterProtocol {
    static func createModule(article: Article)-> ArticleDetailViewController
}

protocol ArticleDetailPresenterToInteractorProtocol {
    var presenter: ArticleDetailInteractorToPresenterProtocol? {get set}
}

protocol ArticleDetailInteractorToPresenterProtocol {
}
