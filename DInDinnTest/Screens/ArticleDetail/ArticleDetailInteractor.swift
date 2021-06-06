//
//  ArticleDetailInteractor.swift
//  DInDinnTest
//
//  Created by Teerapat on 6/6/21.
//

import Foundation

class ArticleDetailInteractor {
    var presenter: ArticleDetailInteractorToPresenterProtocol?
}

// MARK: - PresenterToInteractorProtocol
extension ArticleDetailInteractor: ArticleDetailPresenterToInteractorProtocol {
}
