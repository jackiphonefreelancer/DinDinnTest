//
//  ArticleListRouter.swift
//  DInDinnTest
//
//  Created by Teerapat on 6/5/21.
//

import Foundation
import UIKit

class ArticleListRouter {

}

// MARK: - PresenterToRouterProtocol
extension ArticleListRouter: ArticleListPresenterToRouterProtocol {
    static func createModule() -> ArticleListViewController {
        let view = ArticleListViewController.storyboardInstance()
        
        var presenter: ArticleListViewToPresenterProtocol & ArticleListInteractorToPresenterProtocol = ArticleListPresenter()
        var interactor: ArticleListPresenterToInteractorProtocol = ArticleListInteractor()
        let router: ArticleListPresenterToRouterProtocol = ArticleListRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    func showArticleDetailScreen(article: Article) {
        let view = ArticleDetailRouter.createModule(article: article)
        let nav = UINavigationController(rootViewController: view)
        view.modalPresentationStyle = .fullScreen
        UIApplication.shared.keyWindow?.rootViewController?.present(nav, animated: true, completion: nil)
    }
}
