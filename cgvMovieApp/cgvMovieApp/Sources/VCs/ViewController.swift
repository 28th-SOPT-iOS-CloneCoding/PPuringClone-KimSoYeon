//
//  ViewController.swift
//  cgvMovieApp
//
//  Created by soyeon on 2021/05/09.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func moreButtonClicked(_ sender: Any) {
        guard let dvc = self.storyboard?.instantiateViewController(identifier: "ListViewController") as? ListViewController else {
            return
        }
        dvc.title = ""
        let backBarButtonItem = UIBarButtonItem(title: "영화", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButtonItem
        self.navigationController?.pushViewController(dvc, animated: true)
    }
    

}

