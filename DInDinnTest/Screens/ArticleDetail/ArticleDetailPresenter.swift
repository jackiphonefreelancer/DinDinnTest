//
//  ArticleDetailPresenter.swift
//  DInDinnTest
//
//  Created by Teerapat on 6/6/21.
//

import Foundation

class ArticleDetailPresenter {
    var view: ArticleDetailPresenterToViewProtocol?
    var interactor: ArticleDetailPresenterToInteractorProtocol?
    var router: ArticleDetailPresenterToRouterProtocol?
}

// MARK: - ViewToPresenterProtocol
extension ArticleDetailPresenter: ArticleDetailViewToPresenterProtocol {
    func selectTabInfo(index: Int) {
        switch index {
        case 0:
            view?.showDescription()
        case 1:
            view?.showSource()
        default:
            view?.showAuthor()
        }
    }
}

// MARK: - InteractorToPresenterProtocol
extension ArticleDetailPresenter: ArticleDetailInteractorToPresenterProtocol{
}

// MARK: - Business Logic
extension ArticleDetailPresenter {
}
