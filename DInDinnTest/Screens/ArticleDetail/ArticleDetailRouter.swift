//
//  ArticleDetailRouter.swift
//  DInDinnTest
//
//  Created by Teerapat on 6/6/21.
//

import Foundation

class ArticleDetailRouter {
    
}

// MARK: - PresenterToRouterProtocol
extension ArticleDetailRouter: ArticleDetailPresenterToRouterProtocol {
    static func createModule(article: Article) -> ArticleDetailViewController {
        let view = ArticleDetailViewController.storyboardInstance()
        view.article = article
        
        var presenter: ArticleDetailViewToPresenterProtocol & ArticleDetailInteractorToPresenterProtocol = ArticleDetailPresenter()
        var interactor: ArticleDetailPresenterToInteractorProtocol = ArticleDetailInteractor()
        let router: ArticleDetailPresenterToRouterProtocol = ArticleDetailRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
}
