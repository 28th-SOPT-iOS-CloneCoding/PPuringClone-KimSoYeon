//
//  ViewController.swift
//  CGVMovieApp
//
//  Created by soyeon on 2021/05/11.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func moreButtonClicked(_ sender: Any) {
        guard let dvc = self.storyboard?.instantiateViewController(identifier: "MoreVC") as? MoreVC else {
            return
        }
        dvc.title = ""
        let backBarButtonItem = UIBarButtonItem(title: "영화", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButtonItem
        self.navigationController?.pushViewController(dvc, animated: true)
    }
}

