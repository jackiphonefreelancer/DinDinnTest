//
//  ArticleDetailViewController.swift
//  DInDinnTest
//
//  Created by Teerapat on 6/6/21.
//

import UIKit

class ArticleDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var infoLabel: UILabel!
    
    var article: Article!
    var presentor: ArticleDetailViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presentor?.selectTabInfo(index: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setupView() {
        // Configure Segment Control
        segmentControl.applyDefaultStyle()
        
        // Setup Image
        imageView.downloaded(from: article.urlToImage)
    }
    
    @IBAction func didSegmentChange() {
        presentor?.selectTabInfo(index: segmentControl.selectedSegmentIndex)
    }
}

//MARK: - PresenterToViewProtocol
extension ArticleDetailViewController: ArticleDetailPresenterToViewProtocol{
    func showDescription() {
        infoLabel.text = article.content
    }
    
    func showSource() {
        infoLabel.text = article.source?.name
    }
    
    func showAuthor() {
        infoLabel.text = article.author
    }
}

//MARK: - Storyboard
extension ArticleDetailViewController {
    static func storyboardInstance() -> ArticleDetailViewController {
        return UIStoryboard(name: "Article", bundle: nil).instantiateViewController(withIdentifier: "ArticleDetailViewController")
            as! ArticleDetailViewController
    }
}
