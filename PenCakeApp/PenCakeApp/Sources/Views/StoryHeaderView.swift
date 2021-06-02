//
//  StoryHeaderView.swift
//  PenCakeApp
//
//  Created by soyeon on 2021/06/01.
//

import UIKit
import RealmSwift

class StoryHeaderView: UIView {
    private var titleButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .NotoSerif(.semiBold, size: 15)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private var subTitleButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .NotoSerif(.light, size: 12)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private var bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    private var realm: Realm?
    private var lists: Results<Story>?
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setData()
        addSubviews([titleButton, subTitleButton, bottomLine])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String, subTitle: String) {
        super.init(frame: .zero)
        titleButton.setTitle(title, for: .normal)
        subTitleButton.setTitle(subTitle, for: .normal)
        addSubviews([titleButton, subTitleButton, bottomLine])
    }
    
    // MARK: - layout
    override func layoutSubviews() {
        titleButton.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(45)
            make.leading.equalTo(self.snp.leading).inset(15)
            make.trailing.equalTo(self.snp.trailing).inset(15)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        subTitleButton.snp.makeConstraints { make in
            make.top.equalTo(titleButton.snp.bottom).offset(25)
            make.leading.equalTo(titleButton.snp.leading)
            make.trailing.equalTo(titleButton.snp.trailing)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        bottomLine.snp.makeConstraints { make in
            make.top.equalTo(titleButton.snp.bottom).offset(85)
            make.bottom.equalTo(self.snp.bottom)
            make.leading.equalTo(titleButton.snp.leading)
            make.trailing.equalTo(titleButton.snp.trailing)
            make.height.equalTo(1)
        }
    }
    
    func setData() {
        realm = try? Realm()
        lists = realm?.objects(Story.self)
        
        //        let vc = ContainerVC()
        //        let index = vc.currentIndex
        //
        //        switch index {
        //        case 0:
        //            titleButton.setTitle(lists![0].title, for: .normal)
        //            subTitleButton.setTitle(lists![0].subTitle, for: .normal)
        //        default:
        //            titleButton.setTitle("제목", for: .normal)
        //            subTitleButton.setTitle("소제목", for: .normal)
        //        }
        
        titleButton.setTitle(lists![0].title, for: .normal)
        subTitleButton.setTitle(lists![0].subTitle, for: .normal)
    }
    
    func updateHeaderLayout(offset: CGFloat) {
        if offset > 44 {
            titleButton.transform = CGAffineTransform(translationX: 0, y: -44)
        } else {
            titleButton.transform = CGAffineTransform(translationX: 0, y: -offset)
            titleButton.titleLabel?.font = .NotoSerif(.light, size: 15 - offset/20)
            
            subTitleButton.transform = CGAffineTransform(translationX: 0, y: -offset)
            subTitleButton.titleLabel?.font = .NotoSerif(.light, size: 12 - offset/20)
        }
        
        if offset > 35 {
            bottomLine.transform = CGAffineTransform(translationX: 0, y: -115)
        } else {
            bottomLine.transform = CGAffineTransform(translationX: 0, y: -offset*2.6)
        }
        
        if offset > 30 {
            subTitleButton.isHidden = true
        } else {
            subTitleButton.isHidden = false
        }
    }
    
    func backToOriginalHeaderLayout() {
        titleButton.transform = .identity
        bottomLine.transform = .identity
        subTitleButton.transform = .identity
    }
    
    
}
