//
//  StoryDetailCVC.swift
//  PenCakeApp
//
//  Created by soyeon on 2021/06/10.
//

import UIKit

class StoryDetailCVC: UICollectionViewCell {
    static let identifier = "StoryDetailCVC"
    
    private var titleButton : UIButton = {
        let button = UIButton()
        button.setTitle("제목", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .NotoSerif(.light, size: 19)
        return button
    }()
    
    private var contentButton : UIButton = {
        let button = UIButton()
        button.setTitle("내용", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .NotoSerif(.light, size: 15)
        button.titleLabel?.numberOfLines = 0
        return button
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    func setUI() {
        self.addSubviews([titleButton, contentButton])
        self.backgroundColor = .white
        
        titleButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(25)
            make.leading.equalToSuperview().inset(25)
        }
        
        contentButton.snp.makeConstraints { make in
            make.top.equalTo(titleButton.snp.bottom).offset(25)
            make.leading.equalToSuperview().inset(25)
            make.height.lessThanOrEqualTo(self.frame.size.height - 100)
        }
    }
}

