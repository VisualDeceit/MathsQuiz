//
//  PageViewController.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 26.12.2021.
//

import UIKit

class PageViewController: UIPageViewController {
    
    private var pages: [UIViewController] = []
    private let initialPage = 0
    
    private let pageControl = UIPageControl()
    
    private var pageControlBottomAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

//MARK: - Setup views
private extension PageViewController {
    func setupViews() {
        setupPageViewController()
        setupPageControl()
    }
    
    func setupPageViewController() {
        dataSource = self
        delegate = self
        
        pageControl.addTarget(self,
                               action: #selector(pageControlTapped),
                               for: .valueChanged)
        let testPage = OnboardingViewController(title: "Maths Quiz",
                                                image: UIImage(named: "onboarding1")!,
                                                describe: "В нашем приложении школьник сможет тренироваться в решении заданий по курсу математики. Maths Quiz призвано не только помочь ученику в освоении учебного материала, но и облегчить переход из начальной школы в основную.")
        let page1 = OnboardingViewController(title: "Активности",
                                             image: UIImage(named: "onboarding1")!,
                                             describe: "Выбирай одну из пяти активностей.")
        let page2 = OnboardingViewController(title: "Уровни",
                                             image: UIImage(named: "onboarding1")!,
                                             describe: "Для каждой активности представлено несколько десятков уровней с различной сложностью.")
        let page3 = OnboardingViewController(title: "Примеры",
                                             image: UIImage(named: "onboarding1")!,
                                             describe: "Каждый раз задание генерируется случайным образом. На решение отводится три попытки.")
        let page4 = LoginViewController()
        
        pages.append(contentsOf: [testPage, page1, page2, page3, page4])
        setViewControllers([pages[initialPage]],
                           direction: .forward,
                           animated: true,
                           completion: nil)
    }
    
    func setupPageControl() {
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
//            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    
//        pageControlBottomAnchor = view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5)
//
        pageControlBottomAnchor = view.bottomAnchor.constraint(equalToSystemSpacingBelow: pageControl.bottomAnchor, multiplier: 2)

        pageControlBottomAnchor?.isActive = true
    }
}


//MARK: - PageViewController extensions
extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex == 0 {
            return pages.last
        } else {
            return pages[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currnetIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currnetIndex < pages.count - 1 {
            return pages[currnetIndex + 1]
        } else {
            return pages.first
        }
    }
}

extension PageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewController = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewController[0]) else { return }
        
        pageControl.currentPage = currentIndex
        animateControlsIfNeeded()
    }
    
    private func animateControlsIfNeeded() {
        let lastPage = pageControl.currentPage == pages.count - 1
        
        if lastPage {
            hideControls()
        } else {
            showControls()
        }
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func hideControls() {
        pageControlBottomAnchor?.constant = -80
    }
    
    private func showControls() {
        pageControlBottomAnchor?.constant = 16
    }
}

//MARK: - Setup actions
extension PageViewController {
    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]],
                           direction: .forward,
                           animated: true,
                           completion: nil)
        animateControlsIfNeeded()
    }
    
    @objc func skipButtonTapped() {
        let lastPageIndex = pages.count - 1
        pageControl.currentPage = lastPageIndex
        
        goToSpecificPage(index: lastPageIndex, ofViewControllers: pages)
        animateControlsIfNeeded()
    }
    
    @objc func nextButtonTapped() {
        pageControl.currentPage += 1
        goToNextPage()
        animateControlsIfNeeded()
    }
}

extension UIPageViewController {
    func goToNextPage(animated: Bool = true,
                      completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }
        
        setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
    }
    
    func goToPreviousPage(animated: Bool = true,
                          completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let previousPage = dataSource?.pageViewController(self, viewControllerBefore: currentPage) else { return }
        
        setViewControllers([previousPage], direction: .forward, animated: animated, completion: completion)
    }
    
    func goToSpecificPage(index: Int, ofViewControllers pages: [UIViewController]) {
        setViewControllers([pages[index]],
                           direction: .forward,
                           animated: true,
                           completion: nil)
    }
}
