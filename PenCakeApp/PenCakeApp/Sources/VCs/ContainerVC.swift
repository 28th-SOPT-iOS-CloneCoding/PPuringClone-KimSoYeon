//
//  ContainerVC.swift
//  PenCakeApp
//
//  Created by soyeon on 2021/05/27.
//


import RealmSwift
import UIKit

class ContainerVC: UIPageViewController {
    // MARK: - UIComponents
    
    private lazy var moreButton: UIButton = {
        let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 60, height: 60)))
        button.addTarget(self, action: #selector(touchUpMoreButton(_:)), for: .touchUpInside)
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(scale: .large), forImageIn: .normal)
        button.tintColor = UIColor.systemGray4
        button.backgroundColor = .white
        
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.lightGray.cgColor
        
        return button
        
        
    }()
    
    // MARK: - Local Variables
    
    static var pages: [UIViewController] = [AddStoryVC()]
    private var currPage: Int = 0
    
    // MARK: - local variables
    
    let realm = try! Realm()
    
    // MARK: - LifeCycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // current index 설정 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRealm()
        setConstraint()
        setPageController()
        setNotification()
    }
}

// MARK: - Action Methods

extension ContainerVC {
    @objc func touchUpMoreButton(_ sender: UIButton) {
        print("현재 페이지: \(currPage)")
        if currPage == 0 {
            
        } else {
            let dvc = SettingVC()
            dvc.modalTransitionStyle = .crossDissolve
            dvc.modalPresentationStyle = .fullScreen
            self.present(dvc, animated: true, completion: nil)
        }
    }
    
    @objc func changeCurrPage(_ sender: Notification) {
        guard let newStoryVC = sender.object as? StoryVC else { return }
        guard let idx = ContainerVC.pages.firstIndex(of: newStoryVC) else { return }
        
        setViewControllers([ContainerVC.pages[idx]], direction: .forward, animated: false, completion: nil)
    }
}

// MARK: - Custom Methods

extension ContainerVC {
    private func setRealm() {
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        let stories = realm.objects(Story.self)
        
        if stories.isEmpty {
            let mainStory = Story()
            mainStory.index = 1
            mainStory.title = "이야기1"
            mainStory.subTitle = "여기를 눌러서 제목을 변경하세요"
            
            mainStory.writings.append(Writing())
            mainStory.writings.append(Writing())
            
            try! realm.write {
                realm.add(mainStory)
            }
        } else {
            for idx in 1 ... stories.count {
                guard let story = stories.filter("index == \(idx)").first else { return }
                
                let storyVC = StoryVC(viewModel: StoryViewModel())
                storyVC.viewModel.storyDelegate = storyVC
                storyVC.viewModel.story = story
                
                ContainerVC.pages.append(storyVC)
            }
        }
    }
    
    private func setPageController() {
        setViewControllers([ContainerVC.pages[ContainerVC.pages.count - currPage - 1]], direction: .forward, animated: true, completion: nil)
        
        dataSource = self
        delegate = self
    }
    
    private func setConstraint() {
        view.addSubviews([moreButton])
        
        moreButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-40)
            make.width.height.equalTo(60)
        }
        
        moreButton.layer.cornerRadius = moreButton.frame.height / 2
        moreButton.layer.masksToBounds = true
    }
    
    private func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(changeCurrPage(_:)), name: Notification.Name.savedNewStory, object: nil)
    }
}

// MARK: - UIPageViewControllerDelegate

extension ContainerVC: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let currVC = viewControllers?.first {
                guard let idx = ContainerVC.pages.firstIndex(of: currVC) else { return }
                currPage = idx
            }
        }
    }
}

// MARK: - UIPageViewControllerDataSource

extension ContainerVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let idx = ContainerVC.pages.firstIndex(of: viewController) else { return nil }
        
        return idx + 1 >= ContainerVC.pages.count ? nil : ContainerVC.pages[idx + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let idx = ContainerVC.pages.firstIndex(of: viewController) else { return nil }
        
        return idx - 1 < 0 ? nil : ContainerVC.pages[idx - 1]
    }
}
