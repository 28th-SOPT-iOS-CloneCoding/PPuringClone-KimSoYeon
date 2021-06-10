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
    
    private lazy var deleteStoryButton: UIButton = {
        let button = UIButton()
        button.setTitle("이야기 제거", for: .normal)
        button.titleLabel?.font = UIFont.NotoSerif(.light, size: 20)
        button.setTitleColor(UIColor.systemPink, for: .normal)
        
        return button
    }()
    
    private lazy var addWritingButton: UIButton = {
        let button = UIButton()
        button.setTitle("글 추가", for: .normal)
        button.titleLabel?.font = UIFont.NotoSerif(.light, size: 20)
        button.setTitleColor(UIColor.black, for: .normal)
        
        return button
    }()
    
    var isStoryPage = false
    
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
        
        if !isStoryPage {
            print("🙀 plus화면에서 이동")
        } else {
            print("😽 story화면에서 이동")
        }
    }
}

extension SettingVC {
    func setUI() {
        view.backgroundColor = .white
        view.addSubviews([deleteStoryButton, addWritingButton, exitButton])

        deleteStoryButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(250)
            make.centerX.equalToSuperview()
        }
        
        addWritingButton.snp.makeConstraints { make in
            make.top.equalTo(deleteStoryButton.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
        }
        
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
