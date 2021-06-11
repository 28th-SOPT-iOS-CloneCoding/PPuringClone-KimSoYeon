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
        button.addTarget(self, action: #selector(touchUpDelete), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var addWritingButton: UIButton = {
        let button = UIButton()
        button.setTitle("글 추가", for: .normal)
        button.titleLabel?.font = UIFont.NotoSerif(.light, size: 20)
        button.setTitleColor(UIColor.black, for: .normal)
        
        return button
    }()
    
    private lazy var settingButton: UIButton = {
        let button = UIButton()
        button.setTitle("앱 설정", for: .normal)
        button.titleLabel?.font = UIFont.NotoSerif(.semiBold, size: 20)
        button.setTitleColor(UIColor.systemTeal, for: .normal)
        
        return button
    }()
    
    var isStoryPage = false
    static var storyNum: Int = 0
    
    // MARK: - LifeCycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        print("🔗 \(SettingVC.storyNum)번째 스토리")
        
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
            settingButton.isHidden = false
            deleteStoryButton.isHidden = true
            addWritingButton.isHidden = true
        } else {
            settingButton.isHidden = true
        }
    }
}

// MARK: - UI Methods
extension SettingVC {
    func setUI() {
        view.backgroundColor = .white
        view.addSubviews([deleteStoryButton, settingButton, addWritingButton, exitButton])

        deleteStoryButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(250)
            make.centerX.equalToSuperview()
        }
        
        settingButton.snp.makeConstraints { make in
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

// MARK: - Action Methods
extension SettingVC {
    @objc func touchUpExit() {
        UIView.animate(withDuration: 0.3, animations: {
            self.exitButton.transform = CGAffineTransform(rotationAngle: -(.pi/4))
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15, execute: {
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    // MARK: - Fix: 이야기 삭제 후 화면 전환
    @objc func touchUpDelete() {
        Database.shared.deleteStory(idx: ContainerVC.currPage) { result in
            if result {
                let deleteStoryVC = ContainerVC.pages[SettingVC.storyNum]
               
                NotificationCenter.default.post(name: Notification.Name.deletedStory, object: deleteStoryVC)
                
                Database.shared.updateStories()
                self.dismiss(animated: true, completion: nil)
            } else {
                print("FAIL TO DELETE")
            }
        }
    }
}
