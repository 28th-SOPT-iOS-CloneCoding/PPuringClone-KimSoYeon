//
//  DateTVC.swift
//  CGVMovieApp
//
//  Created by soyeon on 2021/05/18.
//

import UIKit

class DateTimeTVC: UITableViewCell {
    static let identifier = "DateTimeTVC"
    
    @IBOutlet weak var dateCollectionView: UICollectionView!
    @IBOutlet weak var timeCollectionView: UICollectionView!
    @IBOutlet weak var searchButton: UIButton!
    
    private var dates: [String] = []
    private var days: [String] = []
    private var times: [String] = ["전체", "오전", "오후", "18시이후", "심야"]
    
    private var dateFormatter = DateFormatter()
    private var isButtonActive = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dateCollectionView.delegate = self
        dateCollectionView.dataSource = self
        
        timeCollectionView.delegate = self
        timeCollectionView.dataSource = self
        
        setUI()
        setFormatter()
        setDate()
        setNotification()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setFormatter() {
        dateFormatter.locale = Locale(identifier:"ko_KR")
        dateFormatter.dateFormat = "yyyy.M.dd (EEEEE)"
    }
    private func setDate() {
        let todayDate = Date()
        let calendar = Calendar.current
        let format = DateFormatter()
        let dayFormat = DateFormatter()
        dayFormat.locale = Locale(identifier: "ko_KR")
        format.dateFormat = "d"
        dayFormat.dateFormat = "EEEEE"
        for i in 0..<14 {
            let day = calendar.date(byAdding: .day, value: i, to: todayDate)!
            if i == 0 {
                days.append("오늘")
            } else if i == 1 {
                days.append("내일")
            } else {
                days.append(dayFormat.string(from: day))
            }
            dates.append(format.string(from: day))
        }
    }
    
}

// MARK: - UI
extension DateTimeTVC {
    func setUI() {
        searchButton.setTitle("조회하기", for: .normal)
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.titleLabel?.font = .boldSystemFont(ofSize: 17)
        searchButton.layer.cornerRadius = 10
        searchButton.backgroundColor = .systemRed
    }
}

// MARK: - CollectionView Delegate
extension DateTimeTVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == dateCollectionView {
            dateCollectionView.scrollToItem(at: IndexPath(item: indexPath.row, section: 0), at: .centeredHorizontally, animated: true)
        } else if collectionView == timeCollectionView {
            timeCollectionView.scrollToItem(at: IndexPath(item: indexPath.row, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}

// MARK: - CollectionView DataSource
extension DateTimeTVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == dateCollectionView {
            return dates.count
        }
        return times.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == dateCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DateCVC.identifier, for: indexPath) as? DateCVC else {
                return UICollectionViewCell()
            }
            if indexPath.item == 0 {
                cell.isSelected = true
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
            } else {
                cell.isSelected = false
            }
            cell.setDate(date: dates[indexPath.row], day: days[indexPath.row])
            return cell
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeCVC.identifier, for: indexPath) as? TimeCVC else {
            return UICollectionViewCell()
        }
        if indexPath.item == 0 {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
        } else {
            cell.isSelected = false
        }
        cell.setTime(time: times[indexPath.item])
        return cell
    }
}

// MARK: - COllectionView DelegateFlowLayout
extension DateTimeTVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        var width: CGFloat = 0
        var height: CGFloat = 0
        
        if collectionView == dateCollectionView {
            label.text = dates[indexPath.row]
            label.sizeToFit()
            width = 50
            height = 60
        } else if collectionView == timeCollectionView {
            label.text = times[indexPath.row]
            label.sizeToFit()
            
            width = label.frame.width + 30
            height = 60
        }
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 5
        }
}

// MARK: - Notification
extension DateTimeTVC {
    private func setNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(buttonInActive), name: NSNotification.Name("buttonInActive"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(buttonActive), name: NSNotification.Name("buttonActive"), object: nil)
    }
    
    @objc
    func buttonInActive() {
//        isButtonActive = false
        searchButton.backgroundColor = .darkGray
    }
    
    @objc
    func buttonActive(_ notification: Notification) {
//        isButtonActive = true
        searchButton.backgroundColor = .systemRed
    }
}
