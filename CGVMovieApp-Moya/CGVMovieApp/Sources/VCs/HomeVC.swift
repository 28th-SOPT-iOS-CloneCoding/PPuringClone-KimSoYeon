//
//  HomeVC.swift
//  CGVMovieApp
//
//  Created by soyeon on 2021/05/15.
//

import UIKit
import SnapKit

class HomeVC: UIViewController {
    private var isScrolled = false
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setTitle("더보기", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(presentMoreMovieVC), for: .touchUpInside)
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(moreButton)
        
        setConstraints()
    }
}

// MARK: -Set Constraints
extension HomeVC {
    func setConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide).multipliedBy(1)
            make.height.equalTo(800)
        }
        
        moreButton.snp.makeConstraints { make in
            make.bottom.equalTo(contentView).inset(30)
            make.centerX.equalTo(contentView)
        }
        
    }
}

// MARK: -Action
extension HomeVC {    
    @objc func presentMoreMovieVC() {
        print("more button touched")
        guard let dvc = self.storyboard?.instantiateViewController(identifier: "MoreVC") as? MoreVC else {
            return
        }
        navigationController?.pushViewController(dvc, animated: true)
    }
}



