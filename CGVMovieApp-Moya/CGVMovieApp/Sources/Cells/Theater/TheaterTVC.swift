//
//  TheaterTVC.swift
//  CGVMovieApp
//
//  Created by soyeon on 2021/05/18.
//

import UIKit

class TheaterTVC: UITableViewCell {
    static let identifier = "TheaterTVC"
    
    @IBOutlet weak var areaCollectionView: UICollectionView!
    @IBOutlet weak var townCollectionView: UICollectionView!
    
    private var expandButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = .gray
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        return button
    }()
    
    private let areas: [String] = ["추천 CGV", "서울", "경기", "인천", "강원", "대전/충청", "대구", "부산/울산", "경상", "광주/전라/제주"]
    private var towns: [String] = ["건대입구", "왕십리", "청담씨네시티"]
    private var foldButtonTouched = false
    private var isFirst = true
    
    private let flowLayout = UICollectionViewFlowLayout()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        areaCollectionView.delegate =  self
        areaCollectionView.dataSource = self
        
        townCollectionView.delegate = self
        townCollectionView.dataSource = self
        
        self.addSubview(expandButton)
        expandButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(5)
            make.top.equalTo(areaCollectionView.snp.top).offset(50)
            make.width.height.equalTo(30)
        }
        expandButton.addTarget(self,
                               action: #selector(foldList),
                               for: .touchUpInside)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc
    func foldList() {
        if !foldButtonTouched {
            expandButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
            foldButtonTouched = true
            flowLayout.scrollDirection = .vertical
            townCollectionView.collectionViewLayout = flowLayout
            townCollectionView.isScrollEnabled = false
            NotificationCenter.default.post(name: NSNotification.Name("increaseCell"), object: towns.count)
        } else {
            expandButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            foldButtonTouched = false
            flowLayout.scrollDirection = .horizontal
            townCollectionView.collectionViewLayout = flowLayout
            townCollectionView.isScrollEnabled = true
            NotificationCenter.default.post(name: NSNotification.Name("decreaseCell"), object: nil)
        }
    }
}

// MARK: - CollectionView Delegate
extension TheaterTVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == areaCollectionView {
            areaCollectionView.scrollToItem(at: IndexPath(item: indexPath.row, section: 0), at: .centeredHorizontally, animated: true)
            setTowns(index: indexPath.row)
            NotificationCenter.default.post(name: NSNotification.Name("buttonInActive"), object: nil)
            if foldButtonTouched {
                NotificationCenter.default.post(name: NSNotification.Name("increaseCell"), object: towns.count)
            }
        } else if collectionView == townCollectionView {
            townCollectionView.scrollToItem(at: IndexPath(item: indexPath.row, section: 0), at: .centeredHorizontally, animated: true)
            NotificationCenter.default.post(name: NSNotification.Name("buttonActive"), object: towns[indexPath.item])
        }
    }
}

// MARK: - CollectionView DataSource
extension TheaterTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == areaCollectionView {
            return areas.count
        }
        return towns.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == areaCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TheaterAreaCVC.identifier, for: indexPath) as? TheaterAreaCVC else {
                return UICollectionViewCell()
            }
            if indexPath.row == 0 {
                cell.isSelected = true
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
            } else  {
                cell.isSelected = false
            }
            cell.setArea(area: areas[indexPath.row])
            return cell
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TheaterTownCVC.identifier, for: indexPath) as? TheaterTownCVC else {
            return UICollectionViewCell()
        }
        if indexPath.row == 0 && isFirst {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
            isFirst = false
        } else  {
            cell.isSelected = false
        }
        cell.setTown(town: towns[indexPath.row])
        return cell
    }
}

// MARK: - COllectionView DelegateFlowLayout
extension TheaterTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        var width: CGFloat = 0
        var height: CGFloat = 0
        
        if collectionView == areaCollectionView {
            label.text = areas[indexPath.row]
            label.sizeToFit()
            
            width = label.frame.width
            height = 30
        } else if collectionView == townCollectionView {
            label.text = towns[indexPath.row]
            label.sizeToFit()
            
            if label.text?.count ?? 0 < 3 {
                width = label.frame.width + 50
            } else if label.text?.count ?? 0 <= 4 {
                width = label.frame.width + 40
            } else if label.text?.count ?? 0 <= 5 {
                width = label.frame.width + 30
            } else {
                width = label.frame.width + 20
            }
            height = 65
        }
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == areaCollectionView {
            return 10
        }
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == areaCollectionView {
            return UIEdgeInsets(top: 13, left: 15, bottom: 5, right: 15)
        }
        return UIEdgeInsets(top: 10, left: 15, bottom: 15, right: 15)
    }
    
}

// MARK: - Data
extension TheaterTVC {
    private func setTowns(index: Int) {
        var townArr: [String] = []
        towns.removeAll()
        
        switch index {
        case 0: townArr = ["등촌", "목동", "고양행신"]
        case 1: townArr = ["강남", "강변", "건대입구", "구로", "대학로", "동대문", "등촌" ,"명동"]
        case 2: townArr = ["경기광주", "고양행신", "광교", "광교상현", "구리", "김포", "김포운양", "김포풍무", "김포한강"]
        case 3: townArr = ["계양", "남주안", "부평", "송도타임스페이스", "연수역", "인천" ,"인천공항"]
        case 4: townArr = ["강릉", "원주", "인제", "춘천"]
        case 5: townArr = ["대전", "대전가수원", "대전가오", "대전탄방", "대전터미널", "유성노은", "논산"]
        case 6: townArr = ["대구", "대구수성", "대구스타디움", "대구아카데미", "대구월성", "대구이시아", "대구칠곡", "대구한일", "대구현대"]
        case 7: townArr = ["남포", "대연", "동래" ,"서면", "서면삼정타워", "센텀시티", "씨네드쉐프 센텀시티"]
        case 8: townArr = ["거제", "경산", "고성", "구미" ,"김천율곡", "김해", "김해율하"]
        case 9: townArr = ["광주금남로", "광주상무", "광주용봉", "광주첨단", "광주충장로", "광주터미널", "광주하남" ,"광양"]
        default: townArr = []
        }
        
        towns = townArr
        townCollectionView.reloadData()
        townCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
    }
}

