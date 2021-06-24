//
//  AddHeader.swift
//  ReminderApp
//
//  Created by soyeon on 2021/06/25.
//

import UIKit
import SnapKit

class AddHeader: UIView {

    // MARK: - UIComponents
    
    var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.sizeToFit()
        return button
    }()
    
    var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.sizeToFit()
        button.isEnabled = true
        return button
    }()
    
    var titleLable: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    // MARK: - Local Variables
    
    private var viewController: UIViewController?
    private var newAlertVC: NewAlertVC?
    
    var canSaved:Bool = true
    
    // MARK: - LifeCycle Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(root viewController: UIViewController, with newAlertVC: NewAlertVC) {
        super.init(frame: .zero)
        self.viewController = viewController
        self.newAlertVC = newAlertVC
        addSubviews([cancelButton, addButton])
        setButtonAction()
    }
    
    override func layoutSubviews() {
        cancelButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalToSuperview().inset(18)
        }
        
        addButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.trailing.equalToSuperview().inset(18)
        }
    }
    
    // MARK: - Action Methods
    
    // MARK: - FixMe: cancel button
    
    private func setButtonAction() {
        let cancelAction = UIAction { _ in
//            self.viewController?.dismiss(animated: true, completion: nil)
            if self.canSaved {
                let alert =  UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                let dismiss = UIAlertAction(title: "변경 사항 폐기", style: .destructive) { (_) in
                    self.resignFirstResponder()
                    self.viewController?.dismiss(animated: true, completion: nil)
                }
                let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
                alert.addAction(dismiss)
                alert.addAction(cancel)
                self.viewController?.present(alert, animated: true, completion: nil)
            } else {
                self.viewController?.dismiss(animated: true, completion: nil)
            }
        }
        cancelButton.addAction(cancelAction, for: .touchUpInside)
        
        let addAction = UIAction { _ in
            print("👍 add button")
        }
        addButton.addAction(addAction, for: .touchUpInside)
    }
}
