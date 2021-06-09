//
//  DetailStoryVC.swift
//  PenCakeApp
//
//  Created by soyeon on 2021/06/07.
//

import UIKit
import SnapKit

class DetailStoryVC: UIViewController {
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.setPreferredSymbolConfiguration(.init(pointSize: 18,
                                                 weight: .light,
                                                 scale: .large),
                                           forImageIn: .normal)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(touchUpBackButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        
        return view
    }()

    private var detailCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var textCount: CGFloat = 5
    private var currentIndex: CGFloat = 0
    private let flowLayout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setCollectionView()
    }
   
}

// MARK: - UI

extension DetailStoryVC {
    func setUI() {
        view.backgroundColor = .white
        
        view.layer.masksToBounds = false
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 8
        
        view.addSubviews([backButton, lineView, detailCollectionView])
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leading.equalToSuperview().inset(5)
            make.width.height.equalTo(40)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.size.width/textCount)
            make.height.equalTo(1)
        }
        
        detailCollectionView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setCollectionView() {
        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
        
        flowLayout.scrollDirection = .horizontal
        detailCollectionView.collectionViewLayout = flowLayout
        detailCollectionView.isPagingEnabled = true
        
//        let nib = UINib(nibName: "StoryDetailCVC", bundle: nil)
        detailCollectionView.register(StoryDetailCVC.self, forCellWithReuseIdentifier: StoryDetailCVC.identifier)
        
        if textCount == 1 {
            detailCollectionView.isScrollEnabled = false
        }
    }
}

// MARK: - Action

extension DetailStoryVC {
    @objc func touchUpBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension DetailStoryVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(textCount)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryDetailCVC.identifier, for: indexPath) as? StoryDetailCVC else {
            return UICollectionViewCell()
        }
        return cell
    }
}

extension DetailStoryVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
}

extension DetailStoryVC: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let cellWidthIncludingSpacing = UIScreen.main.bounds.size.width
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        var roundedIndex = round(index)
        
        if scrollView.contentOffset.x > targetContentOffset.pointee.x {
            roundedIndex = floor(index)
        } else if scrollView.contentOffset.x < targetContentOffset.pointee.x {
            roundedIndex = ceil(index)
        } else {
            roundedIndex = round(index)
        }
        
        if currentIndex > roundedIndex {
            currentIndex -= 1
            roundedIndex = currentIndex
            moveNegativeDirection()
        } else if currentIndex < roundedIndex {
            currentIndex += 1
            roundedIndex = currentIndex
            movePositiveDirection()
        }
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
    
    func movePositiveDirection() {
        UIView.animate(withDuration: 0.3, animations: {
            self.lineView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.size.width/self.textCount * self.currentIndex, y: 0)
        })
    }
    
    func moveNegativeDirection() {
        UIView.animate(withDuration: 0.3, animations: {
            self.lineView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.size.width - UIScreen.main.bounds.size.width/self.textCount * (self.textCount - self.currentIndex), y: 0)
        })
    }
}
