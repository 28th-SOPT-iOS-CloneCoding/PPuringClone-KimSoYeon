//
//  ContainerVC.swift
//  PenCakeApp
//
//  Created by soyeon on 2021/05/27.
//

import UIKit
import RealmSwift

class ContainerVC: UIPageViewController {
    lazy var moreButton: UIButton = {
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
        button.addTarget(self, action: #selector(touchUpMore), for: .touchUpInside)
        return button
    }()
    
    static var pages: [UIViewController] = [UINavigationController(rootViewController: MainStoryVC()), AddStoryVC()]
    var completeHandler: ((Int) -> ())?
    var currentIndex = ContainerVC.pages.firstIndex(of: MainStoryVC()) ?? 0
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rappers = realm.objects(Story.self)
        print(Realm.Configuration.defaultConfiguration.fileURL)

        setPageController()
        setUI()
    }
}

extension ContainerVC {
    private func setPageController() {
        setViewControllers([ContainerVC.pages[currentIndex]], direction: .forward, animated: true, completion: nil)
        dataSource = self
    }
    
    private func setUI() {
        view.backgroundColor = .white
        view.addSubview(moreButton)
        
        moreButton.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.bottom.equalTo(view).inset(50)
            make.trailing.equalTo(view).inset(20)
        }
    }
    
    func setViewControllersFromIndex(index: Int) {
        if index < 0 && index >= ContainerVC.pages.count { return }
        self.setViewControllers([ContainerVC.pages[index]], direction: .forward, animated: true, completion: nil)
        completeHandler?(currentIndex)
    }
    
}

extension ContainerVC {
    @objc func touchUpMore() {
        if currentIndex == ContainerVC.pages.count - 1 {
            print("이야기 추가하기 화면에서 더보기 버튼 클릭")
        } else {
            print("이야기 화면에서 더보기 버튼 클릭")
        }
    }
    
}

extension ContainerVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = ContainerVC.pages.firstIndex(of: viewController) else { return nil }
        
        if index - 1 < 0 {
            return nil
        } else {
            return ContainerVC.pages[index - 1]
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = ContainerVC.pages.firstIndex(of: viewController) else { return nil }
        
        if index + 1 >= ContainerVC.pages.count {
            return nil
        } else {
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
