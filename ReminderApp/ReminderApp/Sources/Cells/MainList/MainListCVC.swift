//
//  MainListCVC.swift
//  ReminderApp
//
//  Created by soyeon on 2021/06/24.
//

import UIKit

class MainListCVC: UICollectionViewCell {
    static let identifier = "MainListCVC"
    
    // MARK: - UIComponents
    
    let icon: UIButton = {
        let button = UIButton()
        button.tintColor = .orange
        button.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        button.setPreferredSymbolConfiguration(.init(pointSize: 18,
                                                    weight: .ultraLight,
                                                    scale: .large),
                                               forImageIn: .normal)
        button.layer.cornerRadius = button.bounds.width / 2
        return button
    }()
    
    let countsLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "예정"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .systemGray
        return label
    }()

    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
        setConstraint()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Custom Methods

extension MainListCVC {
    
    func setCellData(title: String) {
        titleLabel.text = title
    }
    
    func setView() {
        contentView.backgroundColor = .white
    }
    
    func setConstraint(){
        contentView.addSubview(icon)
        contentView.addSubview(countsLabel)
        contentView.addSubview(titleLabel)
        
        icon.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(icon.snp.bottom).offset(5)
            make.leading.equalTo(icon.snp.centerX)
        }
        
        countsLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(10)
        }
    }
}
