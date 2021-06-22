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
    private let titleLabel: UILabel = {
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
    func setConstraint(){
        contentView.addSubview(titleLabel)
        contentView.addSubview(countsLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(10)
        }
        
        countsLabel.snp.makeConstraints { make in
            make.top.trailing.equalTo(10)
        }
    }
    
    func setCellData(title: String, counts: Int) {
        titleLabel.text = title
        countsLabel.text = String(counts)
    }
}
