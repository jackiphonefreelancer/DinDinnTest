//
//  ArticleListViewController.swift
//  DInDinnTest
//
//  Created by Teerapat on 6/5/21.
//

import UIKit

class ArticleListViewController: UIViewController {
    
    @IBOutlet weak var carouselView: UIView!
    @IBOutlet weak var pageControl: AppPageControl!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    // Carousel
    private var pageViewController : UIPageViewController?
    private var currentPage = 0
    
    var source: String = ""
    var headerlinesResult: ArticleListResult?
    var newsBySourceResult: ArticleListResult?
    
    var presentor: ArticleListViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        showLoading()
        presentor?.fetchTopHeadlines()
    }
    
    func setupView() {
        // Configure Carousel
        configureCarousel()
        
        // Configure Segment Control
        configureSegmentControl()

        // Configure TableView
        tableView.registerCell(ArticleTableViewCell.self)
        tableView.rowHeight = ArticleTableViewCell.cellHeight
    }
    
    func configureCarousel() {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController!.dataSource = self
        pageViewController!.delegate = self
        pageViewController!.view.frame = CGRect(x: 0, y: 0, width: carouselView.frame.size.width, height: carouselView.frame.size.height);
        addChild(pageViewController!)
        carouselView.addSubview(pageViewController!.view)
        pageViewController!.didMove(toParent: self)
    }
    
    func configureSegmentControl() {
        segmentControl.applyDefaultStyle()
    }
    
    var headlinesArtilcles: [Article] {
        return headerlinesResult?.articles ?? []
    }
    
    var newsArticles: [Article] {
        return newsBySourceResult?.articles ?? []
    }
    
    var sources: [String: String] {
        return ["us": "US",
            "sg": "Singapore",
            "jp": "Japan"]
    }
    
    func reloadCarousel() {
        pageControl.numberOfPages = headlinesArtilcles.count
        pageControl.currentPage = 0
        carouselView.bringSubviewToFront(pageControl)
        if let currentContentView = viewControllerAtIndex(index: 0) {
            let viewControllers = [currentContentView]
            pageViewController!.setViewControllers(viewControllers , direction: .forward, animated: false, completion: nil)
        }
    }
}

//MARK: - UIPageViewController DataSource & Delegate
extension ArticleListViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? HeadlineView else {
            return nil
        }
        var index = viewController.pageIndex
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        index -= 1
        return viewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? HeadlineView else {
            return nil
        }
        var index = viewController.pageIndex
        if index == NSNotFound {
            return nil
        }
        index += 1
        if (index == headlinesArtilcles.count) {
            return nil
        }
        return viewControllerAtIndex(index: index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return headlinesArtilcles.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pageControl.currentPage
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let pageContentViewController = pageViewController.viewControllers?.first {
            let index = (pageContentViewController as! HeadlineView).pageIndex
            setCurrentPage(currentPage: index)
        }
    }
    
    func setCurrentPage(currentPage: Int) {
        self.currentPage = currentPage
        self.pageControl.currentPage = currentPage
    }
    
    func viewControllerAtIndex(index: Int) -> HeadlineView? {
        if headlinesArtilcles.count == 0 || index >= headlinesArtilcles.count {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        let headline = headlinesArtilcles[index]
        let contentView = HeadlineView(pageIndex: index, headline: headline)
        return contentView
    }
}

//MARK: - UITableViewDelegate & DataSource
extension ArticleListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as! ArticleTableViewCell
        let article = newsArticles[indexPath.item]
        cell.reloadCell(article: article)
        return cell
    }
}

//MARK: - PresenterToViewProtocol
extension ArticleListViewController: ArticleListPresenterToViewProtocol{
    func showFetchingTopHeadlinesSuccess(result: ArticleListResult) {
        headerlinesResult = result
        hideLoading()
        reloadCarousel()
    }
    
    func showFetchingNewsBySourceSuccess(result: ArticleListResult) {
        newsBySourceResult = result
        hideLoading()
        heightConstraint.constant = ArticleTableViewCell.cellHeight * CGFloat(newsArticles.count)
        tableView.reloadData()
    }
    
    func showFetchingFailure() {
        hideLoading()
        showGeneralError()
    }
}

//MARK: - Storyboard
extension ArticleListViewController {
    static func storyboardInstance() -> ArticleListViewController {
        return UIStoryboard(name: "Article", bundle: nil).instantiateViewController(withIdentifier: "ArticleListViewController")
            as! ArticleListViewController
    }
}
