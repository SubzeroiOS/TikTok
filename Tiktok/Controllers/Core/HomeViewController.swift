//
//  ViewController.swift
//  Tiktok
//
//  Created by Bhaskar Rajbongshi on 1/4/21.
//

import UIKit

class HomeViewController: UIViewController {

    private let horizontalScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let segmentedControl: UISegmentedControl = {
       let segmentedControl = UISegmentedControl(items: ["Following", "For You"])
       segmentedControl.selectedSegmentIndex = 1
       segmentedControl.backgroundColor = nil
       segmentedControl.addTarget(self, action: #selector(didChangeSegmentedControl), for: .valueChanged)
       return segmentedControl
    }()
    
    private let followingPagingController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .vertical, options: [:])
    private let forYouPagingController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .vertical, options: [:])
    
    private var followingPosts = mockModels()
    private var forYouPosts = mockModels()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(horizontalScrollView)
        
        setupFeed()
        setupHeaderButtons()
        
        horizontalScrollView.contentOffset = CGPoint(x: view.width, y: 0)
        horizontalScrollView.delegate = self
    }
    
    private func setupHeaderButtons() {
        navigationItem.titleView = segmentedControl
    }
    
    @objc private func didChangeSegmentedControl(_ sender: UISegmentedControl) {
        horizontalScrollView.setContentOffset(CGPoint(x: view.width * CGFloat(sender.selectedSegmentIndex), y: 0), animated: true)
    }

    override func viewDidLayoutSubviews() {
        horizontalScrollView.frame = view.bounds
    }
    
    private func setupFeed() {
        horizontalScrollView.contentSize = CGSize(width: view.width * 2, height: view.height)
        
        
        setupFollowingFeed()
        setupForYouFeed()

        
    }
    
    private func setupFollowingFeed() {
        guard let model = followingPosts.first else {
            return
        }
        
        followingPagingController.setViewControllers([PostsViewController(model: model)], direction: .forward, animated: false, completion: nil)
        followingPagingController.dataSource = self
        
        horizontalScrollView.addSubview(followingPagingController.view)
        followingPagingController.view.frame = CGRect(x: 0, y: 0, width: horizontalScrollView.width, height: horizontalScrollView.height)
        addChild(followingPagingController)
        followingPagingController.didMove(toParent: self)
    }
    
    private func setupForYouFeed() {
        guard let model = forYouPosts.first else {
            return
        }
        
        forYouPagingController.setViewControllers([PostsViewController(model: model)], direction: .forward, animated: false, completion: nil)
        forYouPagingController.dataSource = self
        
        horizontalScrollView.addSubview(forYouPagingController.view)
        forYouPagingController.view.frame = CGRect(x: view.width, y: 0, width: horizontalScrollView.width, height: horizontalScrollView.height)
        addChild(forYouPagingController)
        forYouPagingController.didMove(toParent: self)
    }

}

extension HomeViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let fromPost = (viewController as? PostsViewController)?.model else {
            return nil
        }
        
        guard let currentIndex = currentPosts.firstIndex(where: {
            $0.identifier == fromPost.identifier
        }) else {
            return nil
        }
        
        guard currentIndex > 0 else {
            return nil
        }
        
        return PostsViewController(model: currentPosts[currentIndex-1])
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let fromPost = (viewController as? PostsViewController)?.model else {
            return nil
        }
        
        guard let currentIndex = currentPosts.firstIndex(where: {
            $0.identifier == fromPost.identifier
        }) else {
            return nil
        }
        
        guard currentIndex < currentPosts.count-1 else {
            return nil
        }
        
        return PostsViewController(model: currentPosts[currentIndex+1])
    }
    
    var currentPosts: [PostModel] {
        if horizontalScrollView.contentOffset.x == 0 {
            return followingPosts
        }
        
        return forYouPosts
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x == 0 || scrollView.contentOffset.x <= (view.width/2) {
            segmentedControl.selectedSegmentIndex = 0
        } else if scrollView.contentOffset.x > (view.width/2) {
            segmentedControl.selectedSegmentIndex = 1
        }
    }
}

