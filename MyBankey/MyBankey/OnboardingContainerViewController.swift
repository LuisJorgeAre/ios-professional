//
//  OnboardingContainerViewController.swift
//  MyBankey
//
//  Created by Luis Lagos on 09/04/22.
//


import UIKit

class OnboardingContainerViewController: UIViewController {

    let pageViewController: UIPageViewController    // create an object to instantiate UIPageViewController
    var pages = [UIViewController]()                // the array of pages
    var currentVC: UIViewController {
        didSet {
        }
    }
    
    // initialization
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        //// instantiate UIPageViewController
        self.pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                       navigationOrientation: .horizontal,
                                                       options: nil)
        
        // create the pages
        let page1 = OnboardingViewController(heroImageName: "delorean",
                                             titleText: "Bankey is faster, pg1")
        let page2 = OnboardingViewController(heroImageName: "world",
                                             titleText: "Move your moner, pg2")
        let page3 = OnboardingViewController(heroImageName: "thumbs",
                                             titleText: "Learn more, pg3")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        currentVC = pages.first!
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPurple
        
        // How to add child view controllers. Always 3 steps to
        
        addChild(pageViewController)                    // add the object
        view.addSubview(pageViewController.view)        // add the child to the View
        pageViewController.didMove(toParent: self)      // hooks up all the UI VCs eventing
        
        pageViewController.dataSource = self            // protocol delegate
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        // constraints, pin the PageViewController to the edges of the parent view
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
        ])
        
        // set the 1st page
        pageViewController.setViewControllers([pages.first!], direction: .forward,
                                              animated: false, completion: nil)
        // store the page in currentVC
        currentVC = pages.first!
    }
}



// MARK: - UIPageViewControllerDataSource

extension OnboardingContainerViewController: UIPageViewControllerDataSource {

    // Before
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }

    // After
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }

    // get Previous
    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        currentVC = pages[index - 1]
        return pages[index - 1]
    }

    // get Next
    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
        currentVC = pages[index + 1]
        return pages[index + 1]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        // return the 1st occurrance, or return 0 if it's nil
        return pages.firstIndex(of: self.currentVC) ?? 0
    }
}


