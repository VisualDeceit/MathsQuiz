//
//  ExampleViewController.swift
//  MathsQuiz
//
//  Created by Александр Фомин on 02.01.2022.
//

import UIKit

class ExampleViewController: UIViewController, ExampleViewInput {
    
    var presenter: (ExamplePresenterOutput & ExampleViewOutput)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = MQColor.background
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
        presenter?.viewDidLoad()
    }
}

private extension ExampleViewController {
    func setupNavigationBar() {
        title = "Пример"
        navigationController?.navigationBar.tintColor = MQColor.ubeDefault
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        navigationItem.largeTitleDisplayMode = .never
    }
}
