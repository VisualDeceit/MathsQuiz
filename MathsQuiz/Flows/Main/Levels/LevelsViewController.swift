//
//  LevelsViewController.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 19.12.2021.
//

import UIKit
import SnapKit

class LevelsViewController: UIViewController, LevelsViewInput {
    
    var presenter: (LevelsPresenterOutput & LevelsViewOutput)?
    
    private var levelCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(LevelCollectionViewCell.self,
                                forCellWithReuseIdentifier: LevelCollectionViewCell.reuseId)
        collectionView.backgroundColor = MQColor.background
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()

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
        title = presenter?.activity.rawValue
        navigationController?.navigationBar.tintColor = MQColor.ubeDefault
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.backButtonTitle = ""
    }
    
    func setupViews() {
        view.backgroundColor = MQColor.background
        
        setupLevelCollectionView()
    }
    
    func setupLevelCollectionView() {
        view.addSubview(levelCollectionView)
        
        levelCollectionView.dataSource = self
        levelCollectionView.delegate = self
        
        levelCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - CollectionViewDelegate & CollectionViewDataSource
extension LevelsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.levels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LevelCollectionViewCell.reuseId, for: indexPath)
        guard let levelCell = cell as? LevelCollectionViewCell,
              let activity = presenter?.activity,
              let levels = presenter?.levels else {
            return UICollectionViewCell()
        }
        
        levelCell.configure(level: levels[indexPath.row], type: activity)

        return levelCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.viewDidSelectItemAt(indexPath)
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
