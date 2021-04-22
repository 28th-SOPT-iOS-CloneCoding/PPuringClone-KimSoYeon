//
//  TimerMusicVC.swift
//  ClockApp
//
//  Created by soyeon on 2021/04/17.
//

import UIKit

protocol sendBackDelegate {
    func dataReceived(data: String)
}

class TimerMusicVC: UIViewController {

    @IBOutlet weak var musicTableView: UITableView!
    
    var musics: [String] = ["전파 탐지기", "공상음", "공지음", "녹차", "놀이 시간", "느린 상승", "도입음", "물결", "반짝반짝", "발산", "밤부엉이", "별자리", "상승음", "순환음", "신호", "신호음", "실크", "우주", "일루미네이트", "절정", "정점", "차임벨", "크리스탈", "파장", "프레스토", "해변가", "희망", "클래식", "실행 중단"]
    
    var selectedMusic: String?
    var delegate: sendBackDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        musicTableView.delegate = self
        musicTableView.dataSource = self
    }
    
    @IBAction func touchUpCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpSet(_ sender: Any) {
        delegate?.dataReceived(data: selectedMusic ?? " ")
        dismiss(animated: true, completion: nil)
    }
}

extension TimerMusicVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMusic = musics[indexPath.row]
    }
}

extension TimerMusicVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MusicCell.identifier) as? MusicCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.musicLabel.text = musics[indexPath.row]
        
//        if musics[indexPath.row] == "없음" {
//            cell.backgroundColor = .black
//            cell.musicLabel.textColor = .black
//        }
        
        return cell
    }
}

