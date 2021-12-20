//
//  LevelViewController.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 19.12.2021.
//

import UIKit

class LevelViewController: UIViewController {
    
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
}

// MARK: - Setup views

private extension LevelViewController {
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
extension LevelViewController: UICollectionViewDataSource, UICollectionViewDelegate {
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
extension LevelViewController: UICollectionViewDelegateFlowLayout {
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
