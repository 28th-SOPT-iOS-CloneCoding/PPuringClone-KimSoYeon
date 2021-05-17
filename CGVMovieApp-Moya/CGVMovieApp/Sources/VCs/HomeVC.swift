//
//  HomeVC.swift
//  CGVMovieApp
//
//  Created by soyeon on 2021/05/15.
//

import UIKit
import SnapKit

class HomeVC: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var floatingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Floating", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.addTarget(self, action: #selector(presentNowBookingVC), for: .touchUpInside)
        return button
    }()
    
    private lazy var testLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.textAlignment = .center
        return label
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setTitle("More", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(presentMoreMovieVC), for: .touchUpInside)
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(testLabel)
        contentView.addSubview(moreButton)
        contentView.addSubview(floatingButton)
        
        setConstraints()
        setSwipeGesture()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool{
        return true
    }
    
    func setSwipeGesture() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        swipeUp.direction = .down
        self.view.addGestureRecognizer(swipeDown)
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
        
        floatingButton.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(scrollView.frameLayoutGuide).inset(30)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide).multipliedBy(1)
        }
        
        testLabel.snp.makeConstraints { make in
            make.top.centerX.bottom.equalTo(contentView)
            make.width.equalTo(200)
            make.height.equalTo(1500)
        }
        
        moreButton.snp.makeConstraints { make in
            make.bottom.equalTo(contentView).inset(30)
            make.centerX.equalTo(contentView)
        }
    }
}

// MARK: -Action
extension HomeVC {
    @objc func presentNowBookingVC() {
        print("now button touched")
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
    
    @objc func swipeAction(_ sender :UISwipeGestureRecognizer){
        if sender.direction == .left{
            print("Swipe Left")
        }
        if sender.direction == .right{
            print("Swipe Right")
        }
        if sender.direction == .up{
            print("Swipe Up")
        }
        if sender.direction == .down{
            print("Swipe Down")
        }
    }
    
}


