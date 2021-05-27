//
//  ContainerVC.swift
//  PenCakeApp
//
//  Created by soyeon on 2021/05/27.
//

import UIKit

class ContainerVC: UIPageViewController {
    private lazy var moreButton: UIButton = {
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
    
    var pages: [UIViewController] = [MainVC(), AddStoryVC()]
    private var currPage: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        setPageController()
        setUI()
    }
}

extension ContainerVC {
    private func setPageController() {
        setViewControllers([pages[currPage]], direction: .forward, animated: true, completion: nil)
        dataSource = self
    }
    
    private func setUI() {
        view.addSubview(moreButton)
        
        moreButton.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.bottom.equalTo(view).inset(50)
            make.trailing.equalTo(view).inset(20)
        }
    }
}

extension ContainerVC {
    @objc func touchUpMore(_ : UIButton) {
        print("더보기 버튼")
    }
}

extension ContainerVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        
        if previousIndex < 0 {
            return nil
        } else {
            return pages[previousIndex]
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        
        if nextIndex >= pages.count {
            return nil
        } else {
            return pages[nextIndex]
        }
    }
}
