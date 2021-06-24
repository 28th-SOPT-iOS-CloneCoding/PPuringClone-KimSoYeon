//
//  AddNewAlertVC.swift
//  ReminderApp
//
//  Created by soyeon on 2021/06/24.
//

import UIKit

class NewAlertVC: UIViewController {
    
    // MARK: - UIComponents
    
    private lazy var header = AddHeader(root: self, with: self)
    
    private lazy var newReminderTableView: UITableView = {
        let table = UITableView()
        return table
    }()
    
    // MARK: - Local Variables
    
    var isEdit: Bool = false
    
    // MARK: - LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setTableView()
    }
    
    override func viewWillLayoutSubviews() {
        header.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        newReminderTableView.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
    }
    
}

// MARK: - Custom Methods

extension NewAlertVC {
    func setView() {
        view.backgroundColor = .white
        view.addSubviews([header, newReminderTableView])
        
        self.presentationController?.delegate = self
        isModalInPresentation = true
    }
    
    func setTableView() {
        newReminderTableView.delegate = self
        newReminderTableView.dataSource = self
        
        newReminderTableView.register(NewReminderTVC.self, forCellReuseIdentifier: NewReminderTVC.identifier)
    }
}

// MARK: - Action Methods

extension NewAlertVC {
    @objc
    func saveAction() {
        if header.canSaved {
            header.canSaved = false
            header.addButton.isEnabled = false
        } else {
            header.canSaved = true
            header.addButton.isEnabled = true
        }
    }
}

// MARK: - UITableView Delegate

extension NewAlertVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0, indexPath.item == 1 {
            return 80
        }
        return 40
    }
}

extension NewAlertVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewReminderTVC.identifier) as? NewReminderTVC else {
                return UITableViewCell()
            }
            cell.setCell(idx: indexPath.item)
            cell.textField.becomeFirstResponder()
            return cell
            
        case 1:
            let cell = UITableViewCell()
            cell.textLabel?.text = "세부사항"
            cell.accessoryType = .disclosureIndicator
            
            return cell
        case 2:
            let cell = UITableViewCell()
            cell.textLabel?.text = "목록"
            cell.accessoryType = .disclosureIndicator
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - PresentationController Delegate

// MARK: - FixME: cancel button

extension NewAlertVC: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        if header.canSaved {
            let alert =  UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let dismiss = UIAlertAction(title: "변경 사항 폐기", style: .destructive) { (_) in
                self.resignFirstResponder()
                self.dismiss(animated: true, completion: nil)
            }
            let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alert.addAction(dismiss)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
}


// MARK: - Notification
extension NewAlertVC {
    private func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(saveAction), name: NSNotification.Name("Save"), object: nil)
    }
}
