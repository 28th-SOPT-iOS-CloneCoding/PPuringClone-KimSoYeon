//
//  AlarmLabelViewController.swift
//  ClockApp
//
//  Created by soyeon on 2021/05/03.
//

import UIKit

class AlarmLabelVC: UIViewController {

    @IBOutlet weak var labelTextField: UITextField!
    
    var saveTextFieldData: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationController()
        setLavelTextField()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.isMovingFromParent
        {
            saveTextFieldData?(labelTextField.text ?? "알람")
        }
    }
    
    private func setUpNavigationController() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.backItem?.title = "뒤로"
        self.navigationController?.navigationBar.tintColor = .orange
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 44/255, green: 44/255, blue: 44/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    private func setLavelTextField() {
        labelTextField.delegate = self
        labelTextField.becomeFirstResponder()
    }
}

extension AlarmLabelVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
