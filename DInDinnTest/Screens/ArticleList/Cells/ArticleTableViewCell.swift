//
//  ArticleTableViewCell.swift
//  DInDinnTest
//
//  Created by Teerapat on 6/5/21.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var soruceNameLabel: UILabel!
    @IBOutlet weak var publishedAtLabel: UILabel!
    
    func reloadCell(article: Article) {
        titleLabel.text = article.title
        articleImageView.downloaded(from: article.urlToImage)
        descriptionLabel.text = article.description
        soruceNameLabel.text = article.source?.name
        publishedAtLabel.text = article.publishedAt?.toDate().toString()
    }
    
    static var cellHeight: CGFloat {
        return 175.0
    }
}

extension ArticleTableViewCell: NibInstanceable, Reuseable {
    static let reuseId = "ArticleTableViewCell"
    static func nibName() -> String {
        return "ArticleTableViewCell"
    }
}
