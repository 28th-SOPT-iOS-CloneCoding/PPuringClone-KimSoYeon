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
    
    
    private let areas: [String] = ["추천 CGV", "서울", "경기", "인천", "강원", "대전/충청", "대구", "부산/울산", "경상", "광주/전라/제주"]
    private var towns: [String] = ["건대입구", "왕십리", "청담씨네시티"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        areaCollectionView.delegate =  self
        areaCollectionView.dataSource = self
        
        townCollectionView.delegate = self
        townCollectionView.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension TheaterTVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == areaCollectionView {
            areaCollectionView.scrollToItem(at: IndexPath(item: indexPath.row, section: 0), at: .centeredHorizontally, animated: true)
            setTowns(index: indexPath.row)
        } else if collectionView == townCollectionView {
            townCollectionView.scrollToItem(at: IndexPath(item: indexPath.row, section: 0), at: .centeredVertically, animated: true)
        }
    }
}

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
        if indexPath.row == 0 {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
        } else  {
            cell.isSelected = false
        }
        cell.setTown(town: towns[indexPath.row])
        return cell
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
        areaCollectionView.reloadData()
        areaCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
    }
}

