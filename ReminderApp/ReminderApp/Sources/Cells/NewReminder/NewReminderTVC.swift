//
//  NewRemiderTVC.swift
//  ReminderApp
//
//  Created by soyeon on 2021/06/25.
//

import UIKit

class NewReminderTVC: UITableViewCell {
    static let identifier = "NewReminderTVC"
    
    // MARK: - UIComponents
    
    var textField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    var textView: UITextView = {
        let textView = UITextView()
        return textView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(textField)
        contentView.addSubview(textView)
        
        setConstraint()
        
        let attributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)
        ]
        
        textView.text = ""
        textView.isHidden = true
        textView.delegate = self
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 16, weight: .light)
        
        setTextView()
        
        textField.attributedPlaceholder = NSAttributedString(string: "제목", attributes: attributes)
        textField.font = UIFont.systemFont(ofSize: 16, weight: .light)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .none
        textField.delegate = self
        textField.resignFirstResponder()
        
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

extension NewReminderTVC {
    func setCell(idx: Int) {
        textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        textField.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true

        if idx == 1 {
            textField.isHidden = true
            textView.isHidden = false

            textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 13).isActive = true
            textView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            textView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            textView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        }
    }

    func setTextView() {
        if textView.text.count == 0 {
            textView.text = "메모"
            textView.textColor = .systemGray3
        } else {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func setConstraint() {
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(18)
            make.height.equalTo(40)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(0)
            make.leading.trailing.equalTo(textField)
            make.height.equalTo(80)
        }
    }
}

extension NewReminderTVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        setTextView()
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.count == 0 {
            setTextView()
        }
    }
}

extension NewReminderTVC: UITextFieldDelegate {}
