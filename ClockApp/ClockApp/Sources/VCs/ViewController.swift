//
//  ViewController.swift
//  ClockApp
//
//  Created by soyeon on 2021/04/13.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension UITableView {
    func removeExtraCellLines() {
        tableFooterView = UIView(frame: .zero)
    }
}
