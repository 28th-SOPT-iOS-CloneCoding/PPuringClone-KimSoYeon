//
//  StoryVC.swift
//  PenCakeApp
//
//  Created by soyeon on 2021/05/23.
//

import UIKit
import RealmSwift

class StoryVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.addSubview(storyTitle)
        view.addSubview(storySubTitle)
        
        storyTitle.snp.makeConstraints { make in
            make.top.equalTo(view).inset(20)
            make.centerX.equalTo(view)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        storySubTitle.snp.makeConstraints { make in
            make.top.equalTo(storyTitle.snp.bottom).offset(30)
            make.centerX.equalTo(storyTitle)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        return view
    }()
    
    private lazy var storyTitle: UILabel = {
        let label = UILabel()
        label.text = "첫번째 이야기"
        label.font = .NotoSerif(.semiBold, size: 20)
        return label
    }()
    private lazy var storySubTitle: UILabel = {
        let label = UILabel()
        label.text = "새로운 이야기 소제목"
        label.font = .NotoSerif(.light, size: 15)
        return label
    }()
    
    private var viewTranslation = CGPoint(x: 0, y: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
    }
}

// MARK: - Setting
extension StoryVC {
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.removeExtraCellLines()
        
        let selectNib = UINib(nibName: "StoryListTVC", bundle: nil)
        tableView.register(selectNib, forCellReuseIdentifier: StoryListTVC.identifier)
    }
}

// MARK: - Action
extension StoryVC {
    @objc func touchUpMore(_ : UIButton) {
        
    }
    
}

extension StoryVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension StoryVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoryListTVC") as? StoryListTVC else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        return cell
    }
}
