//
//  PageViewController.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 26.12.2021.
//

import UIKit

class OnboardingViewController: UIPageViewController, OnboardingViewInput {
    
    var presenter: (OnboardingPresenterOutput & OnboardingViewOutput)?
    
    private var onboardingContent = [OnboardingContent]()
    private let pageControl = UIPageControl()
    private let skipButton = MQPlainButton(title: "Начать")
    private let bottomButton = MQStandardButton(title: "Далее")
    private var pageControlBottomAnchor: NSLayoutConstraint?
    
    convenience init(transitionStyle style: UIPageViewController.TransitionStyle) {
        self.init(transitionStyle: style, navigationOrientation: .horizontal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addTargets()
    }
}

// MARK: - Setup views
private extension OnboardingViewController {
    func setupViews() {
        view.backgroundColor = MQColor.background
        
        fetchOnboardingContent()
        setupPageViewController()
        setupPageControl()
        setupPageForm()
    }
    
    func fetchOnboardingContent() {
        if let path = Bundle.main.path(forResource: "onboarding", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                onboardingContent.append(contentsOf: try JSONDecoder().decode([OnboardingContent].self, from: data))
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        }
    }
    
    func getViewController(at index: Int) -> UIViewController? {
        guard index >= 0, index < onboardingContent.count   else {
            return nil
        }
        let image = UIImage(named: onboardingContent[index].image) ?? UIImage()
        let vc = OnboardingTemplateViewController(title: onboardingContent[index].title,
                                                  image: image,
                                                  describe: onboardingContent[index].describe,
                                                  index: index)
        return vc
    }
    
    func updateButtons(with index: Int) {
        if index >= onboardingContent.count - 1 {
            bottomButton.changeTitle(to: "Начать")
            skipButton.isHidden = true
        } else {
            bottomButton.changeTitle(to: "Далее")
            skipButton.isHidden = false
        }
    }
    
    func setupPageViewController() {
        dataSource = self
        delegate = self
        
        if let startVC = getViewController(at: 0) {
            setViewControllers([startVC], direction: .forward, animated: true)
            
            pageControl.currentPage = 0
            pageControl.numberOfPages = onboardingContent.count
        }
    }
    
    func setupPageControl() {
        pageControl.currentPageIndicatorTintColor = MQColor.ubeDefault
        pageControl.pageIndicatorTintColor = MQColor.ubeLight
        pageControl.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupPageForm() {
        view.addSubview(skipButton)
        view.addSubview(pageControl)
        view.addSubview(bottomButton)
        
        NSLayoutConstraint.activate([
            skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: MQOffset.offset4),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -MQOffset.offset8),
            
            bottomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -MQOffset.offset8),
            bottomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: MQOffset.offset64),
            bottomButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -MQOffset.offset64),
            bottomButton.heightAnchor.constraint(equalToConstant: MQOffset.offset44),
            
            pageControl.bottomAnchor.constraint(equalTo: bottomButton.topAnchor, constant: -MQOffset.offset8),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
}

// MARK: - Setup targets
private extension OnboardingViewController {
    func addTargets() {
        skipButton.addTarget(self,
                             action: #selector(skipButtonTapped),
                             for: .touchUpInside)
        bottomButton.addTarget(self,
                               action: #selector(bottomButtonTapped),
                               for: .touchUpInside)
    }
    
    @objc func skipButtonTapped() {
        presenter?.viewDidBeginButtonTap()
    }
    
    @objc func bottomButtonTapped(_ sender: UIButton) {
        if let index = (viewControllers?.first as? OnboardingTemplateViewController)?.index,
           let vc = getViewController(at: index + 1) {
            setViewControllers([vc],
                               direction: .forward,
                               animated: true) { [weak self] _ in
                self?.pageControl.currentPage = index + 1
                self?.updateButtons(with: index + 1)
            }
        } else {
            presenter?.viewDidBeginButtonTap()
        }
    }
}

// MARK: - PageViewController extensions
extension OnboardingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if var index = (viewController as? OnboardingTemplateViewController)?.index {
            index -= 1
            return getViewController(at: index)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if var index = (viewController as? OnboardingTemplateViewController)?.index {
            index += 1
            return getViewController(at: index)
        }
        return nil
    }
}

extension OnboardingViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let index = (pageViewController.viewControllers?.first as? OnboardingTemplateViewController)?.index {
                pageControl.currentPage = index
                updateButtons(with: index)
            }
        }
    }
}
