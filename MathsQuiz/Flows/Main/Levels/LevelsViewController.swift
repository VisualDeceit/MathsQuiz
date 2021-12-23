//
//  LevelsViewController.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 19.12.2021.
//

import UIKit

class LevelsViewController: UIViewController, LevelsViewInput {
    
    var presenter: (LevelsPresenterOutput & LevelsViewOutput)?

    private var activityType: ActivityType?
    
    private var levelCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(LevelCollectionViewCell.self,
                                forCellWithReuseIdentifier: LevelCollectionViewCell.reuseId)
        collectionView.backgroundColor = MQColor.background
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    convenience init(activityType: ActivityType) {
        self.init()
        self.activityType = activityType
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar() 
    }
}

// MARK: - Setup views

private extension LevelsViewController {
    func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = MQColor.ubeDefault
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        navigationController?.navigationBar.backItem?.title = "Назад"
        navigationItem.title = "Сложение"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupViews() {
        view.backgroundColor = MQColor.background
        
        setupLevelCollectionView()
    }
    
    func setupLevelCollectionView() {
        view.addSubview(levelCollectionView)
        
        levelCollectionView.dataSource = self
        levelCollectionView.delegate = self
        
        NSLayoutConstraint.activate([
            levelCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            levelCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            levelCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            levelCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - CollectionViewDelegate & CollectionViewDataSource
extension LevelsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LevelCollectionViewCell.reuseId,
                                                      for: indexPath)
        guard let levelCell = cell as? LevelCollectionViewCell else { return cell }
//        let data = activities[indexPath.row]
        let data = ActivityType.addition
        levelCell.configure(with: data)
        
        return levelCell
    }
}

// MARK: - CollectionViewDelegateFlowLayout
extension LevelsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = CollectionCellSize.calculateCellSize(itemsPerRow: 3, in: levelCollectionView)
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

// MARK: - LevelsViewInput
extension LevelsViewController {
}
