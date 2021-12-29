//
//  HomeViewController.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 17.12.2021.
//

import UIKit

class HomeViewController: UIViewController, HomeViewInput {
    
    var presenter: (HomePresenterOutput & HomeViewOutput)?
    
    private let greetingLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = MQFont.boldSystemFont30
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var accountButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = button.frame.width / 2
        button.layer.masksToBounds = true
        button.setImage(UIImage(named: "user_placeholder"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(accountButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HomeCollectionViewCell.self,
                                forCellWithReuseIdentifier: HomeCollectionViewCell.reuseId)
        collectionView.backgroundColor = MQColor.background
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        presenter?.viewDidLoad()
    }
}

// MARK: - Setup views
private extension HomeViewController {
    func setupViews() {
        view.backgroundColor = MQColor.background
        
        setupGreetingForm()
        setupMainCollectionView()
    }
    
    func setupGreetingForm() {
        view.addSubview(greetingLabel)
        view.addSubview(accountButton)
        
        NSLayoutConstraint.activate([
            greetingLabel.centerYAnchor.constraint(equalTo: accountButton.centerYAnchor),
            greetingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            greetingLabel.trailingAnchor.constraint(equalTo: accountButton.leadingAnchor, constant: -16),
            
            accountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            accountButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            accountButton.widthAnchor.constraint(equalToConstant: 56),
            accountButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    func setupMainCollectionView() {
        view.addSubview(mainCollectionView)
        
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        
        NSLayoutConstraint.activate([
            mainCollectionView.topAnchor.constraint(equalTo: accountButton.bottomAnchor, constant: 16),
            mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // Targets
    @objc func accountButtonTapped() {
        presenter?.viewDidAccountButtonTap()
    }
}

// MARK: - CollectionViewDelegate & CollectionViewDataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.activities?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.reuseId,
                                                      for: indexPath)
        guard let mainCell = cell as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let activity = presenter?.activities?[indexPath.row] {
            mainCell.configure(with: activity)
        }
        return mainCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedActivity = presenter?.activities?[indexPath.row] {
            presenter?.viewDidSelectActivity(type: selectedActivity.type)
        }
    }
}

// MARK: - CollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = CollectionCellSize.calculateCellSize(itemsPerRow: 2, in: mainCollectionView)
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 18, bottom: 25, right: 18)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 18
    }
}

// MARK: - HomeViewInput
extension HomeViewController {
    func reloadCollection() {
        mainCollectionView.reloadData()
    }
    
    func setGreeting(message: String) {
        greetingLabel.text = message
    }
}
