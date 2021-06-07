//
//  SettingVC.swift
//  PenCakeApp
//
//  Created by soyeon on 2021/06/02.
//

import UIKit

class SettingVC: UIViewController {
    private lazy var exitButton: UIButton = {
        let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 60, height: 60)))
        button.addTarget(self, action: #selector(touchUpExit), for: .touchUpInside)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(scale: .large), forImageIn: .normal)
        button.tintColor = UIColor.systemGray4
        button.backgroundColor = .white
        
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.lightGray.cgColor
        
        return button
    }()
    
    var isCreateView = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.exitButton.transform = CGAffineTransform(rotationAngle: -(.pi/4))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05, execute: {
            UIView.animate(withDuration: 0.3, animations: {
                self.exitButton.transform = .identity
            })
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
}

extension SettingVC {
    func setUI() {
        view.addSubview(exitButton)
        
        exitButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-40)
            make.width.height.equalTo(60)
        }
        
        exitButton.layer.cornerRadius = exitButton.frame.height / 2
        exitButton.layer.masksToBounds = true
    }
}

extension SettingVC {
    @objc func touchUpExit() {
        UIView.animate(withDuration: 0.3, animations: {
            self.exitButton.transform = CGAffineTransform(rotationAngle: -(.pi/4))
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15, execute: {
            self.dismiss(animated: true, completion: nil)
        })
    }
    
}
