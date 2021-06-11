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
        button.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.NotoSerif(.light, size: 17), NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
        return button
    }()

    private lazy var completionButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(touchUpCompletionButton(_:)))
        button.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.NotoSerif(.light, size: 17)], for: .normal)
        return button
    }()

    private let titleTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "제목"
        textfield.font = UIFont.NotoSerif(.semiBold, size: 20)
        return textfield
    }()

    private let contentTextView: UITextView = {
        let textview = UITextView()
        textview.font = UIFont.NotoSerif(.light, size: 15)
        return textview
    }()

    private lazy var naviTitleButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.NotoSerif(.light, size: 17)
        return button
    }()

    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray5
        return view
    }()
    
    var writing: Writing?

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
        setUI()
        setTextField()
        setNavigationBar()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.titleTextField.endEditing(true)
    }
}

// MARK: - Action

extension WritingVC {
    @objc func touchUpCancleButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func touchUpCompletionButton(_ sender: UIBarButtonItem) {
        saveNewWriting()
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UI

extension WritingVC {
    func setView() {
        view.backgroundColor = .white
        
        if let writing = self.writing {
            self.titleTextField.text = writing.title
            self.contentTextView.text = writing.content
        }
    }
    
    func setUI() {
        view.addSubviews([self.titleTextField, self.contentTextView, self.separator])

        self.titleTextField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview().inset(20)
        }

        self.contentTextView.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview()
        }

        self.separator.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
    }

    func setNavigationBar() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.shadowImage = UIImage()

        self.navigationItem.leftBarButtonItem = self.cancleButton
        self.navigationItem.rightBarButtonItem = self.completionButton

        self.navigationItem.titleView = .none
        self.navigationItem.titleView?.alpha = 0
    }

    func setTextField() {
        self.titleTextField.delegate = self
        self.titleTextField.becomeFirstResponder()
    }

    func registerNavigationTitleButton() {
        guard let title = self.titleTextField.text else { return }
        self.naviTitleButton.setTitle(title, for: .normal)

        UIView.animate(withDuration: 0.4) {
            self.navigationItem.titleView = self.naviTitleButton
            self.navigationItem.titleView?.alpha = 1

            self.titleTextField.snp.updateConstraints { make in
                make.height.equalTo(0)
            }
        }
    }
}

// MARK: - TextField

extension WritingVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.registerNavigationTitleButton()
        self.titleTextField.resignFirstResponder()

        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        self.titleTextField.resignFirstResponder()
        self.registerNavigationTitleButton()
    }
}

// MARK: - DB

extension WritingVC {
    func saveNewWriting() {
        guard let title = self.titleTextField.text,
              let content = self.contentTextView.text else { return }
        
        let writing = Writing()
        writing.title = title
        writing.content = content
        
        if let existingWriting = self.writing {
            writing.id = existingWriting.id
            writing.date = existingWriting.date
        }
        
        Database.shared.updateWriting(idx: ContainerVC.currPage, writing: writing) { result in
            if result {
                Database.shared.updateStory(idx: ContainerVC.currPage)
                
                if let presentingVC = self.presentingViewController as? UINavigationController,
                   let detailVC = presentingVC.topViewController as? DetailWritingVC
                {
                    detailVC.viewModel.writing =
                        writing
                }
                
                self.dismiss(animated: true, completion: nil)
            } else {
                print("FAIL TO SAVE")
            }
        }
        
    }
}
