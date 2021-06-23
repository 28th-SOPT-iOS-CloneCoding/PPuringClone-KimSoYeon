//
//  MainListTVC.swift
//  ReminderApp
//
//  Created by soyeon on 2021/06/22.
//

import UIKit

class MainListTVC: UITableViewCell {
    static let identifier = "MainListTVC"
    
    // MARK: - UIComponents
    private var icon: UIButton = {
        let button = UIButton()
        button.tintColor = .blue
        button.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        button.setPreferredSymbolConfiguration(.init(pointSize: 10,
                                                    weight: .ultraLight,
                                                    scale: .large),
                                               forImageIn: .normal)
        button.layer.cornerRadius = button.bounds.width / 2
        
        return button
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "새로운 목록"
        return label
    }()
    
    private lazy var countsLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setView()
        setConstraint()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

// MARK: - Custom Methods

extension MainListTVC {
    func setView() {
        contentView.backgroundColor = .white
    }
    
    func setConstraint(){
        contentView.addSubview(icon)
        contentView.addSubview(titleLabel)
        contentView.addSubview(countsLabel)
        
        icon.snp.makeConstraints { make in
            make.top.leading.equalTo(5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(5)
            make.leading.equalTo(icon.snp.trailing).offset(5)
        }
        
        countsLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(10)
        }
    }
    
    func setCellData(title: String, counts: Int) {
        titleLabel.text = title
        countsLabel.text = String(counts)
    }
}
