//
//  OptionSoundHapticVC.swift
//  ClockApp
//
//  Created by soyeon on 2021/05/06.
//

import UIKit

class OptionSoundHapticVC: UIViewController {
    
    @IBOutlet weak var soundTableView: UITableView!
    
    var saveSoundHaptic: (([String]) -> Void)?
    
    private var sound: [String] = ["진동", "이른 기상", "여명", "헬리오스", "궤도", "새소리", "물방울", "밝은 햇살", "한사리", "반짝이는 눈"]
    private var saveSound: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setData()
        setUpNavigationController()
        
        soundTableView.delegate = self
        soundTableView.dataSource = self
        soundTableView.separatorColor = .darkGray
        soundTableView.layer.cornerRadius = 15
    }
    
    private func setData() {
        saveSound.removeAll()
    }

    private func setUpNavigationController() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.backItem?.title = "다음 기상만"
        self.navigationController?.navigationBar.tintColor = .orange
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }

}

extension OptionSoundHapticVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sound.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SoundCell.identifier) as? SoundCell else {
            return UITableViewCell()
        }
        cell.setSoundLabel(song: sound[indexPath.row])
        return cell
    }
}

extension OptionSoundHapticVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        saveSound.append(sound[indexPath.row])
        saveSoundHaptic?(saveSound)
        self.navigationController?.popViewController(animated: true)
    }
}

