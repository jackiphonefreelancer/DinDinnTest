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
    
    var headerlinesResult: ArticleListResult?
    var presentor: ArticleListViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presentor?.selectCountry(index: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
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
    
    @IBAction func didSegmentChange() {
        presentor?.selectCountry(index: segmentControl.selectedSegmentIndex)
    }
    
    var featuredHeadlinesArtilcles: [Article] {
        guard let articles = headerlinesResult?.articles else {
            return []
        }
        let array = Array(articles.prefix(3))
        return array
    }
    
    var headlinesArtilcles: [Article] {
        guard let articles = headerlinesResult?.articles, articles.count >= 3 else {
            return []
        }
        let array = Array(articles[3..<articles.count])
        return array
    }
    
    func reloadCarousel() {
        pageControl.numberOfPages = featuredHeadlinesArtilcles.count
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
        if featuredHeadlinesArtilcles.count == 0 || index >= featuredHeadlinesArtilcles.count {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        let headline = featuredHeadlinesArtilcles[index]
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
        return headlinesArtilcles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as! ArticleTableViewCell
        let article = headlinesArtilcles[indexPath.item]
        cell.reloadCell(article: article)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = headlinesArtilcles[indexPath.item]
        presentor?.showArticleDetailScreen(article: article)
    }
}

//MARK: - PresenterToViewProtocol
extension ArticleListViewController: ArticleListPresenterToViewProtocol{
    func showFetchingTopHeadlinesSuccess(result: ArticleListResult) {
        headerlinesResult = result
        heightConstraint.constant = ArticleTableViewCell.cellHeight * CGFloat(headlinesArtilcles.count)
        reloadCarousel()
        tableView.reloadData()
    }
    
    func showFetchingFailure() {
        showGeneralError()
    }
    
    func showLoading() {
        showLoadingOverlay()
    }
    
    func hideLoading() {
        hideLoadingOverlay()
    }
}

//MARK: - Storyboard
extension ArticleListViewController {
    static func storyboardInstance() -> ArticleListViewController {
        return UIStoryboard(name: "Article", bundle: nil).instantiateViewController(withIdentifier: "ArticleListViewController")
            as! ArticleListViewController
    }
}
