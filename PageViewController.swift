//
//  PageViewController.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 26.12.2021.
//

import UIKit
import SwiftUI

class PageViewController: UIPageViewController {
    
    private var pages: [UIViewController] = []
    private let initialPage = 0
    
    private let pageControl = UIPageControl()
    private let skipButton = MQPlainButton(title: "Пропустить")
    private let bottomButton = MQStandardButton(title: "Далее")
    
    private var pageControlBottomAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addTargets()
    }
}

//MARK: - Setup views
private extension PageViewController {
    func setupViews() {
        view.backgroundColor = MQColor.background
        
        setupPageViewController()
        setupPageControl()
        setupPageForm()
    }
    
    func setupPageViewController() {
        dataSource = self
        delegate = self
        
        let page1 = OnboardingViewController(title: "Maths Quiz",
                                             image: UIImage(named: "onboardingLarge")!,
                                             describe: "В нашем приложении школьник сможет тренироваться в решении заданий по курсу математики. Maths Quiz призвано не только помочь ученику в освоении учебного материала, но и облегчить переход из начальной школы в основную.",
                                             isFirstPage: true)
        let page2 = OnboardingViewController(title: "Активности",
                                             image: UIImage(named: "onboarding1")!,
                                             describe: "Выбирай одну из пяти активностей.")
        let page3 = OnboardingViewController(title: "Уровни",
                                             image: UIImage(named: "onboarding1")!,
                                             describe: "Для каждой активности представлено несколько десятков уровней с различной сложностью.")
        let page4 = OnboardingViewController(title: "Примеры",
                                             image: UIImage(named: "onboarding1")!,
                                             describe: "Каждый раз задание генерируется случайным образом. На решение отводится три попытки.")
        
        pages.append(contentsOf: [page1, page2, page3, page4])
        setViewControllers([pages[initialPage]],
                           direction: .forward,
                           animated: true,
                           completion: nil)
    }
    
    func setupPageControl() {
        pageControl.currentPageIndicatorTintColor = MQColor.ubeDefault
        pageControl.pageIndicatorTintColor = MQColor.ubeLight
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
        pageControl.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupPageForm() {
        view.addSubview(skipButton)
        view.addSubview(pageControl)
        view.addSubview(bottomButton)
        
        NSLayoutConstraint.activate([
            skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            bottomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            bottomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
            bottomButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
            bottomButton.heightAnchor.constraint(equalToConstant: 44),
            
            pageControl.bottomAnchor.constraint(equalTo: bottomButton.topAnchor, constant: -10),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
}

//MARK: - Setup targets
private extension PageViewController {
    func addTargets() {
        pageControl.addTarget(self,
                              action: #selector(pageControlTapped),
                              for: .valueChanged)
        skipButton.addTarget(self,
                             action: #selector(skipButtonTapped),
                             for: .touchUpInside)
        bottomButton.addTarget(self,
                               action: #selector(bottomButtonTapped),
                               for: .touchUpInside)
    }
    
    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]],
                           direction: .forward,
                           animated: true,
                           completion: nil)
        setBottomButtonTitle()
    }
    
    @objc func skipButtonTapped() {
        let lastPageIndex = pages.count - 1
        pageControl.currentPage = lastPageIndex
        
        goToSpecificPage(index: lastPageIndex, ofViewControllers: pages)
    }
    
    @objc func bottomButtonTapped(_ sender: UIButton) {
        pageControl.currentPage += 1
        if sender.titleLabel?.text == "Далее" {
            goToNextPage()
        } else if sender.titleLabel?.text == "Начать" {
            print("hello")
        }
    }
}

//MARK: - Setup general functions
private extension PageViewController {
    func goToNextPage(animated: Bool = true,
                      completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }
        
        setBottomButtonTitle()
        
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
        setBottomButtonTitle()
    }
    
    func setBottomButtonTitle() {
        if pageControl.currentPage == 3 {
            bottomButton.changeTitle(to: "Начать")
        } else {
            bottomButton.changeTitle(to: "Далее")
        }
    }
}

//MARK: - PageViewController extensions
extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        setBottomButtonTitle()
        
        if currentIndex == 0 {
            return nil
        } else {
            return pages[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        setBottomButtonTitle()
        
        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]
        } else {
            return nil
        }
    }
}

extension PageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewController = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewController[0]) else { return }
        
        pageControl.currentPage = currentIndex
    }
    
    private func hideControls() {
        pageControlBottomAnchor?.constant = -80
    }
    
    private func showControls() {
        pageControlBottomAnchor?.constant = 16
    }
}
