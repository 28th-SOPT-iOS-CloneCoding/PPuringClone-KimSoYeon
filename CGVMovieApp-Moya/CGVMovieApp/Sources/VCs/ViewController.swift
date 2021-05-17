//
//  ViewController.swift
//  CGVMovieApp
//
//  Created by soyeon on 2021/05/11.
//

import UIKit

class ViewController: UIViewController {
    let floatingButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Floating", for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(floatingButton)
    }
    
    @IBAction func moreButtonClicked(_ sender: Any) {
        guard let dvc = self.storyboard?.instantiateViewController(identifier: "MoreVC") as? MoreVC else {
            return
        }
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    
}

