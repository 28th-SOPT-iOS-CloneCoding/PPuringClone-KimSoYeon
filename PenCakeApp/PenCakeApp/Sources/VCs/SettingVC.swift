//
//  SettingVC.swift
//  PenCakeApp
//
//  Created by soyeon on 2021/06/02.
//

import UIKit

class SettingVC: UIViewController {
    lazy var exitButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray5.cgColor
        button.tintColor = .systemGray4
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.setPreferredSymbolConfiguration(.init(pointSize: 20,
                                                     weight: .light,
                                                     scale: .large),
                                               forImageIn: .normal)
        button.addTarget(self, action: #selector(touchUpExit), for: .touchUpInside)
        return button
    }()
    
    var isCreateView = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
}

extension SettingVC {
    func setUI() {
        view.addSubview(exitButton)
        
        exitButton.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.bottom.equalTo(view).inset(50)
            make.trailing.equalTo(view).inset(20)
        }
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
