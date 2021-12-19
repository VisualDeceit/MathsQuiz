//
//  HomeViewController.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 17.12.2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    var presenter: (HomePresenterOutput & HomeViewOutput)?
    
    private var activities: [Activity] = []
    
    private let greetingLabel: UILabel = {
        let label = UILabel()
        label.text = "Привет, Данила!"
        label.font = MQFont.boldSystemFont30
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let userPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "userPhoto")
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var mainCollectionView: UICollectionView = {
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
        presenter?.onViewDidLoad()
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
        view.addSubview(userPhoto)
        
        NSLayoutConstraint.activate([
            greetingLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44),
            greetingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            greetingLabel.trailingAnchor.constraint(equalTo: userPhoto.leadingAnchor, constant: 50),
            
            userPhoto.centerYAnchor.constraint(equalTo: greetingLabel.centerYAnchor, constant: -10),
            userPhoto.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            userPhoto.widthAnchor.constraint(equalToConstant: 56),
            userPhoto.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    func setupMainCollectionView() {
        view.addSubview(mainCollectionView)
        
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        
        NSLayoutConstraint.activate([
            mainCollectionView.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 33),
            mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - CollectionViewDelegate & CollectionViewDataSource

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        activities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.reuseId,
                                                      for: indexPath)
        guard let mainCell = cell as? HomeCollectionViewCell else { return cell }
        let data = activities[indexPath.row]
        mainCell.configure(with: data)
        
        return mainCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.onDidSelectActivity(type: activities[indexPath.row].type)
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

extension HomeViewController: HomeViewInput {
    func reloadCollection(with activities: [Activity]) {
        self.activities = activities
        mainCollectionView.reloadData()
    }
}
