//
//  HeadlineView.swift
//  DInDinnTest
//
//  Created by Teerapat on 6/5/21.
//

import UIKit

class HeadlineView: UIViewController {
    
    //IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // Properties
    private (set) var pageIndex: Int = 0
    private (set) var headline: Article!
    
    convenience init(pageIndex: Int, headline: Article) {
        self.init(nibName: "HeadlineView", bundle: nil)
        self.pageIndex = pageIndex
        self.headline = headline
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        imageView.downloaded(from: headline.urlToImage)
        titleLabel.text = headline.title
        descriptionLabel.text = headline.description
    }
}
