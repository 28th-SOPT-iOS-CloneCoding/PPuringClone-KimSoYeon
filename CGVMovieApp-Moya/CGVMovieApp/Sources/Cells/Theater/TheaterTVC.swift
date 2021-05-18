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
    private var towns: [String] = ["등촌", "목동", "고양행신"]
    
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
            townCollectionView.scrollToItem(at: IndexPath(item: indexPath.row, section: 0), at: .centeredHorizontally, animated: true)
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
            } else  {
                cell.isSelected = false
            }
            cell.areaConfigure(area: areas[indexPath.row])
            return cell
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TheaterTownCVC.identifier, for: indexPath) as? TheaterTownCVC else {
            return UICollectionViewCell()
        }
        cell.isSelected = false
        cell.labelConfigure(position: towns[indexPath.row])
        return cell
    }
}

// MARK: - Data
extension TheaterTVC {
    private func setTowns(index: Int) {
        var array: [String] = []
        
        towns.removeAll()
        
        switch index {
        case 0: array = ["강변", "건대입구", "용산아이파크몰", "왕십리", "송파" ,"스타필드시티위례", "성남모란", "야탑"]
        case 1: array = ["강남", "강변", "건대입구", "구로", "대학로", "동대문", "등촌" ,"명동", "명동역 씨네라이브러리", "목동", "미아", "불광", "상봉", "성신여대입구", "송파", "수유", "신촌아트레온", "씨네드쉐프 압구정", "씨네드쉐프 용산", "압구정", "여의도", "영등포", "왕십리", "용산아이파크몰", "중계", "천호", "청담씨네시티", "피카디리1958", "하계", "홍대"]
        case 2: array = ["경기광주", "고양행신", "광교", "광교상현", "구리", "김포", "김포운양", "김포풍무", "김포한강", "동백", "동수원", "동탄", "동탄역", "동탄호수공원", "배곧", "범계", "부천", "부천역", "부천옥길", "북수원", "산본", "서현", "성남모란", "소풍" ,"수원" ,"스타필드시티위례", "시흥", "안산", "안성", "야탑", "양주옥정", "역곡", "오리", "오산", "오산중앙", "용인", "의정부", "의정부태흥", "이천", "일산", "정왕", "죽전", "파주문산", "파주야당", "판교", "평촌", "평택", "평택소사" ,"포천", "하남미사", "화성봉담", "화정"]
        case 3: array = ["계양", "남주안", "부평", "송도타임스페이스", "연수역", "인천" ,"인천공항", "인천논현", "인천연수", "인천학익", "주안역", "청라"]
        case 4: array = ["강릉", "원주", "인제", "춘천"]
        case 5: array = ["대전", "대전가수원", "대전가오", "대전탄방", "대전터미널", "유성노은", "논산", "당진", "보령", "서산", "세종", "천안", "천안터미널", "천안펜타포트", "청주(서문)", "청주성안길", "청주율량", "청주지웰시티", "청주터미널", "충북혁신" ,"충주교현", "홍성"]
        case 6: array = ["대구", "대구수성", "대구스타디움", "대구아카데미", "대구월성", "대구이시아", "대구칠곡", "대구한일", "대구현대"]
        case 7: array = ["남포", "대연", "동래" ,"서면", "서면삼정타워", "센텀시티", "씨네드쉐프 센텀시티", "아시아드", "정관", "하단아트몰링", "해운대", "화명", "울산삼산", "울산신천", "울산진장"]
        case 8: array = ["거제", "경산", "고성", "구미" ,"김천율곡", "김해", "김해율하", "김해장유", "마산", "북포항", "안동", "양산물금", "양산삼호", "진주혁신", "창원", "창원더시티" , "창원상남", "통영", "포항"]
        case 9: array = ["광주금남로", "광주상무", "광주용봉", "광주첨단", "광주충장로", "광주터미널", "광주하남" ,"광양", "광양 엘에프스퀘어", "군산", "나주", "목포", "목포평화광장", "서전주", "순천", "순천신대", "여수웅천", "익산", "제주", "제주노형"]
        default: array = []
        }
        
        towns = array
        areaCollectionView.reloadData()
        areaCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
    }
}
