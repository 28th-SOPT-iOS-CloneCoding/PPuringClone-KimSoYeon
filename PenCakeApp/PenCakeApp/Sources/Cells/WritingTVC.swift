//
//  WritingTVC.swift
//  PenCakeApp
//
//  Created by soyeon on 2021/06/04.
//

import UIKit

class WritingTVC: UITableViewCell {
    static let identifier = "WritingTVC"

    // MARK: - UIComponents

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.NotoSerif(.semiBold, size: 18)
        label.text = "글"
        label.textColor = UIColor.darkGray

        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.NotoSerif(.light, size: 13)
        label.text = "05.27"
        label.textColor = UIColor.lightGray

        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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

extension WritingTVC {
    func setConstraint() {
        contentView.addSubviews([titleLabel, dateLabel])

        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }

        dateLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
        }
    }

    func setCellData(writing: Writing) {
        titleLabel.text = writing.title
        dateLabel.text = Date().slicingDate(date: writing.date)
    }
}

