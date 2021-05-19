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
        scrollView.backgroundColor = .systemGray6
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
    
    private lazy var bookingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("", for: .normal)
        button.backgroundColor = UIColor.systemRed.withAlphaComponent(0.8)
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(presentNowBookingVC), for: .touchUpInside)
        return button
    }()
    private lazy var topButton: UIButton = {
        let button = UIButton()
        button.layer.shadowColor  = UIColor.gray.cgColor
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 2
        button.setImage(UIImage(named: "up-arrow-fill"), for: .normal)
        button.setPreferredSymbolConfiguration(.init(pointSize: 20,
                                                     weight: .light,
                                                     scale: .large),
                                               forImageIn: .normal)
        button.addTarget(self, action: #selector(touchUpTop), for: .touchUpInside)
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
        
        contentView.addSubview(bookingButton)
        contentView.addSubview(topButton)
        
        setConstraints()
        setScrollButtons()
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
            make.width.equalTo(200)
            make.height.equalTo(1500)
        }
        
        moreButton.snp.makeConstraints { make in
            make.bottom.equalTo(contentView).inset(30)
            make.centerX.equalTo(contentView)
        }
        
        bookingButton.snp.makeConstraints { make in
            make.width.equalTo(180)
            make.height.equalTo(60)
            make.trailing.equalToSuperview().offset(40)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        topButton.snp.makeConstraints { make in
            make.width.height.equalTo(45)
            make.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().offset(10)
        }
    }
    
    func setScrollButtons() {
        let smallTitleLabel = UILabel()
        let largeTitleLabel = UILabel()
        let imageView = UIImageView()
        
        bookingButton.addSubview(smallTitleLabel)
        bookingButton.addSubview(largeTitleLabel)
        bookingButton.addSubview(imageView)
        
        smallTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(bookingButton.snp.top).offset(13)
            make.leading.equalTo(bookingButton.snp.leading).offset(25)
        }
        largeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(smallTitleLabel.snp.bottom).offset(1)
            make.leading.equalTo(smallTitleLabel.snp.leading)
        }
        imageView.snp.makeConstraints { make in
            make.centerY.equalTo(bookingButton.snp.centerY)
            make.leading.equalTo(largeTitleLabel.snp.trailing).offset(5)
            make.height.equalTo(24)
            make.width.equalTo(35)
        }
        
        smallTitleLabel.text = "빠르고 쉽게"
        smallTitleLabel.font = .boldSystemFont(ofSize: 10)
        smallTitleLabel.textColor = .white
        
        largeTitleLabel.text = "지금예매"
        largeTitleLabel.font = .boldSystemFont(ofSize: 16)
        largeTitleLabel.textColor = .white
        
        imageView.image = UIImage.init(named: "ticket")
        imageView.tintColor = .white
    }
}

// MARK: -Action
extension HomeVC {
    @objc func presentNowBookingVC() {
        guard let dvc = self.storyboard?.instantiateViewController(identifier: "NowBookingVC") as? NowBookingVC else {
            return
        }
        
        dvc.modalTransitionStyle = .coverVertical
        dvc.modalPresentationStyle = .overCurrentContext
        present(dvc, animated: true, completion: nil)
    }
    
    @objc func presentMoreMovieVC() {
        print("more button touched")
        guard let dvc = self.storyboard?.instantiateViewController(identifier: "MoreVC") as? MoreVC else {
            return
        }
        navigationController?.pushViewController(dvc, animated: true)
    }
    
    @objc
    func touchUpTop() {
        
        scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
        self.isScrolled = false
    }
    
}


