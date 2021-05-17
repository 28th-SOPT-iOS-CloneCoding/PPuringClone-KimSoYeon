//
//  NowBookingVC.swift
//  CGVMovieApp
//
//  Created by soyeon on 2021/05/15.
//

import UIKit

class NowBookingVC: UIViewController {

    private lazy var bookingView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemYellow
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(bookingView)
        
        bookingView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(view)
        }
    }
    
}
