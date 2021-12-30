//
//  LevelsViewController.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 19.12.2021.
//

import UIKit

class LevelsViewController: UIViewController, LevelsViewInput {
    
    var presenter: (LevelsPresenterOutput & LevelsViewOutput)?

    var activity: ActivityType
    
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
    
    init(activity: ActivityType) {
        self.activity = activity
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        presenter?.viewDidLoad()
    }
}

// MARK: - Setup views

private extension LevelsViewController {
    func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = MQColor.ubeDefault
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .white
        navigationController?.navigationBar.backItem?.title = "Назад"
        navigationItem.title = activity.rawValue
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
        presenter?.levels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LevelCollectionViewCell.reuseId,
                                                      for: indexPath)
        guard let levelCell = cell as? LevelCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let level = presenter?.levels?[indexPath.row] {
            levelCell.configure(level: level, type: activity)
        }
        return levelCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.1) {
            guard let cell = collectionView.cellForItem(at: indexPath) as? LevelCollectionViewCell else {
                return
            }
            cell.transform = .init(scaleX: 0.95, y: 0.95)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.1) {
            guard let cell = collectionView.cellForItem(at: indexPath) as? LevelCollectionViewCell else {
                return
            }
            cell.transform = .identity
        }
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
    func reloadCollection() {
        levelCollectionView.reloadData()
    }
}
