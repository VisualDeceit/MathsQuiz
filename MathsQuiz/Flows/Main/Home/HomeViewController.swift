//
//  HomeViewController.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 17.12.2021.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController, HomeViewInput {
    
    var presenter: (HomePresenterOutput & HomeViewOutput)?
    
    private let greetingLabel: UILabel = {
        let label = UILabel()
        label.text = "Привет, Данила"
        label.font = MQFont.boldSystemFont30
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private(set) lazy var accountButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = button.frame.width / 2
        button.layer.masksToBounds = true
        button.setImage(UIImage(named: "user_placeholder"), for: .normal)
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
private extension HomeViewController {
    func setupViews() {
        view.backgroundColor = MQColor.background
        
        setupGreetingForm()
        setupMainCollectionView()
    }
    
    func setupNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationItem.backButtonTitle = ""
    }
    
    func setupGreetingForm() {
        view.addSubview(greetingLabel)
        view.addSubview(accountButton)
        
        greetingLabel.snp.makeConstraints { make in
            make.centerY.equalTo(accountButton.snp.centerY)
            make.leading.equalToSuperview().offset(MQOffset.offset16)
            make.trailing.equalTo(accountButton.snp.leading).inset(MQOffset.offset16)
        }
        
        accountButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(MQOffset.offset16)
            make.trailing.equalToSuperview().inset(MQOffset.offset16)
            make.width.height.equalTo(MQOffset.offset56)
        }
    }
    
    func setupMainCollectionView() {
        view.addSubview(mainCollectionView)
        
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        
        mainCollectionView.snp.makeConstraints { make in
            make.top.equalTo(accountButton.snp.bottom).offset(MQOffset.offset16)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
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
        presenter?.viewDidSelectItemAt(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.1) {
            guard let cell = collectionView.cellForItem(at: indexPath) as? HomeCollectionViewCell else {
                return
            }
            cell.transform = .init(scaleX: 0.95, y: 0.95)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.1) {
            guard let cell = collectionView.cellForItem(at: indexPath) as? HomeCollectionViewCell else {
                return
            }
            cell.transform = .identity
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
