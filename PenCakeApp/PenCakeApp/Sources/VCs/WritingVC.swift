//
//  WritingVC.swift
//  PenCakeApp
//
//  Created by soyeon on 2021/05/28.
//

import UIKit
import RealmSwift

class WritingVC: UIViewController {
    private lazy var cancleButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(touchUpCancleButton(_:)))
        button.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.NotoSerif(.light, size: 13), NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
        
        return button
    }()
    
    private lazy var completionButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(touchUpCompletionButton(_:)))
        button.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.NotoSerif(.light, size: 13)], for: .normal)
        
        return button
    }()
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = .NotoSerif(.light, size: 18)
        textField.borderStyle = .none
        textField.backgroundColor = .clear
        textField.attributedPlaceholder = NSAttributedString(string: "제목", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.spellCheckingType = .no
        textField.textContentType = .none
        return textField
    }()
    
    private var bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    private lazy var contentTextView: UITextView = {
        let textView = UITextView()
        textView.font = .NotoSerif(.light, size: 14)
        textView.textColor = .systemGray2
        textView.text = "내용을 입력하세요"
        textView.backgroundColor = .clear
        
        textView.delegate = self
        textView.autocorrectionType = .no
        textView.autocapitalizationType = .none
        textView.spellCheckingType = .no
        textView.textContentType = .none
        return textView
    }()
    
    private var realm: Realm?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        realm = try? Realm()
        
        setUI()
        setNavigationBar()
    }
    
}

// MARK: - Action Methods
extension WritingVC {
    @objc func touchUpCancleButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func touchUpCompletionButton(_ sender: UIBarButtonItem) {
        try! realm?.write {
            realm?.add(inputData(database: Writing()))
        }
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Custom Methods
extension WritingVC {
    func setUI() {
        view.addSubviews([titleTextField, bottomLine, contentTextView])
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(18)
            make.height.equalTo(50)
        }
        
        bottomLine.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(2)
            make.leading.trailing.equalTo(titleTextField)
            make.height.equalTo(1)
        }
        
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(bottomLine.snp.bottom).offset(25)
            make.leading.trailing.equalTo(titleTextField)
            make.height.equalTo(200)
        }
    }
    func setNavigationBar() {
        self.navigationItem.leftBarButtonItem = self.cancleButton
        self.navigationItem.rightBarButtonItem = self.completionButton
    }
    
    private func inputData(database: Writing) -> Writing {
        if let title = titleTextField.text {
            database.title = title
        }
        if let content = contentTextView.text {
            database.content = content
        }
        return database
    }
}

// MARK: - TextViewDelegate
extension WritingVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.systemGray2 {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "내용을 입력하세요"
            textView.textColor = UIColor.systemGray2
        }
    }
}
