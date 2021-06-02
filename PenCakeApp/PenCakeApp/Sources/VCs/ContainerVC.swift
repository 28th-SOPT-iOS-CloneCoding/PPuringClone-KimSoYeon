//
//  ContainerVC.swift
//  PenCakeApp
//
//  Created by soyeon on 2021/05/27.
//

import UIKit
import RealmSwift

class ContainerVC: UIPageViewController {
    lazy var settingButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray5.cgColor
        button.tintColor = .systemGray4
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.setPreferredSymbolConfiguration(.init(pointSize: 20,
                                                     weight: .light,
                                                     scale: .large),
                                               forImageIn: .normal)
        button.addTarget(self, action: #selector(touchUpSetting), for: .touchUpInside)
        return button
    }()
    
    static var pages: [UIViewController] = [UINavigationController(rootViewController: MainStoryVC()), AddStoryVC()]
    var completeHandler: ((Int) -> ())?
    var currentIndex = ContainerVC.pages.firstIndex(of: MainStoryVC()) ?? 0
    
    private var canReload = true
    private var currentPage = 0
    
    let realm = try! Realm()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rappers = realm.objects(Story.self)
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        setUI()
        setPageController()
    }
}

extension ContainerVC {
    private func setPageController() {
        dataSource = self
        delegate = self
        
        if let firstVC = ContainerVC.pages.first {
            self.setViewControllers([firstVC],
                                    direction: .forward,
                                    animated: true,
                                    completion: nil)
        }
    }
    
    private func setUI() {
        view.backgroundColor = .white
        view.addSubview(settingButton)
        
        settingButton.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.bottom.equalTo(view).inset(50)
            make.trailing.equalTo(view).inset(20)
        }
    }
    
    func makeNewViewController(title: String, subTitle: String) {
        let newVC = MainStoryVC()
        
        guard let embedVC = newVC.children.first as? MainStoryVC else { return }
        embedVC.headerView = StoryHeaderView(title: title, subTitle: subTitle)
        ContainerVC.pages.insert(newVC, at: 0)
        
        canReload = true
        currentPage = 0
    }
    
}

extension ContainerVC {
    @objc func touchUpSetting() {
        let vc = SettingVC()
        if self.currentIndex == ContainerVC.pages.count - 1 {
            vc.isCreateView = true
        }
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}

extension ContainerVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = ContainerVC.pages.firstIndex(of: viewController) else { return nil }
        
        if index - 1 < 0 {
            return nil
        } else {
            currentIndex -= 1
            return ContainerVC.pages[index - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = ContainerVC.pages.firstIndex(of: viewController) else { return nil }
        
        if index + 1 >= ContainerVC.pages.count {
            return nil
        } else {
            currentIndex += 1
            return ContainerVC.pages[index + 1]
        }
        
    }
}

extension ContainerVC: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            completeHandler?(currentIndex)
        }
    }
}
