//
//  DetailWritingVC.swift
//  PenCakeApp
//
//  Created by soyeon on 2021/06/11.
//

import UIKit
import SnapKit

class DetailWritingVC: UIViewController {
    // MARK: - UIComponents
    
    private var navigationView: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 44)))
        view.backgroundColor = .white
        return view
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(touchUpBackButton(_:)), for: .touchUpInside)
        return button
    }()

    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(touchUpMoreButton(_:)), for: .touchUpInside)
        return button
    }()

    private var separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray4
        return view
    }()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "안녕하세요"
        label.font = UIFont.NotoSerif(.semiBold, size: 18)
        return label
    }()

    private var dateLabel: UILabel = {
        let label = UILabel()
        label.text = Date().getDateToString(date: Date())
        label.font = UIFont.NotoSerif(.light, size: 15)
        label.textColor = UIColor.lightGray
        return label
    }()

    private var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "내용을 적어주세요."
        label.font = UIFont.NotoSerif(.light, size: 16)
        label.numberOfLines = 0
        return label
    }()

    var viewModel: WritingViewModel
    var writing: Writing?

    init(viewModel: WritingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setNavigationBar()
        setViewModel()
    }
}

// MARK: - Action

extension DetailWritingVC {
    @objc func touchUpBackButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    @objc func touchUpMoreButton(_ sender: UIButton) {
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let deleteAction = UIAlertAction(title: "글 삭제", style: .destructive, handler: didSelectedDeleteButton(_:))
        let editAction = UIAlertAction(title: "글 수정", style: .default, handler: didSelectedEditButton(_:))

        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        optionMenu.addAction(editAction)
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(cancelAction)

        present(optionMenu, animated: true, completion: nil)
    }

    @objc func didSelectedDeleteButton(_ sender: UIAlertAction) {
        Database.shared.deleteWriting(idx: ContainerVC.currPage, writing: self.writing!) { result in
            if result {
                Database.shared.updateStory(idx: ContainerVC.currPage)
                self.navigationController?.popViewController(animated: true)
            } else {
                print("FAIL TO DELETE")
            }
        }
    }
    
    @objc func didSelectedEditButton(_ sender: UIAlertAction) {
        let writingVC = WritingVC()
        writingVC.writing = writing

        let navigationController = UINavigationController(rootViewController: writingVC)
        navigationController.modalPresentationStyle = .overFullScreen

        present(navigationController, animated: true, completion: nil)
    }
}

// MARK: - Custom Method

extension DetailWritingVC {
    func setUI() {
        view.backgroundColor = .white

        if let writing = self.writing {
            titleLabel.text = writing.title
            contentLabel.text = writing.content
            dateLabel.text = Date().getDateToString(format: "yyyy년 M월 d일 E a h:mm", date: writing.date)
        }
        
        view.addSubviews([navigationView, backButton, moreButton, separator, titleLabel, dateLabel, contentLabel])
        
        navigationView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(44)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }

        backButton.snp.makeConstraints { make in
            make.leading.equalTo(navigationView.snp.leading)
            make.centerY.equalTo(navigationView.snp.centerY)
            make.width.height.equalTo(navigationView.snp.height)
        }

        moreButton.snp.makeConstraints { make in
            make.trailing.equalTo(navigationView.snp.trailing)
            make.centerY.equalTo(navigationView.snp.centerY)
            make.width.height.equalTo(navigationView.snp.height)
        }

        separator.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom)
            make.leading.trailing.equalTo(navigationView)
            make.height.equalTo(1)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationView).offset(80)
            make.leading.trailing.equalToSuperview().inset(30)
        }

        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
        }

        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(40)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
        }
    }
    
    func setNavigationBar() {
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }

    func setViewModel() {
        viewModel.writingDelegate = self
    }
}

// MARK: - ViewModelDelegate

extension DetailWritingVC: writingViewModelDelegate {
    func changedWriting(writing: Writing) {
        titleLabel.text = writing.title
        contentLabel.text = writing.content
        dateLabel.text = Date().getDateToString(format: "yyyy년 M월 d일 E a h:mm", date: writing.date)
    }
}
