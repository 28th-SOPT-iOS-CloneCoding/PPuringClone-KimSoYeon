//
//  StoryVC.swift
//  PenCakeApp
//
//  Created by soyeon on 2021/05/31.
//

import UIKit

class DetailStoryVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setNavigation()
    }
}

extension DetailStoryVC {
    func setUI() {
        view.layer.masksToBounds = false
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 8
    }
    
    func setNavigation() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .systemGray4
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}
