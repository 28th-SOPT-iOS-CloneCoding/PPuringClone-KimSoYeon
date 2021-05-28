//
//  AddStorySubTitleVC.swift
//  PenCakeApp
//
//  Created by soyeon on 2021/05/28.
//

import UIKit

class AddStorySubTitleVC: UIViewController {
    private lazy var completionButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(touchUpCompletionButton(_:)))
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = self.completionButton
        
    }
}

extension AddStorySubTitleVC {
    @objc func touchUpCompletionButton(_ sender: UIBarButtonItem) {
        ContainerVC.pages.insert(UINavigationController(rootViewController: MainVC()), at: 0)
        
        self.dismiss(animated: true, completion: nil)
    }
}

