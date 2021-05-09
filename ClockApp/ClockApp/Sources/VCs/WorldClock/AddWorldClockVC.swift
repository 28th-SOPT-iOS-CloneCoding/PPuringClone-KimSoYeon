//
//  AddWorldClockVC.swift
//  ClockApp
//
//  Created by soyeon on 2021/04/29.
//

import UIKit

class AddWorldClockVC: UIViewController {

    @IBOutlet weak var countrySearchBar: UISearchBar!
    @IBOutlet weak var countryTableView: UITableView!
    
    var countries: [WorldTime] = []
    var filteredCountries: [WorldTime] = []
    
    var isSearching = false
    var sendCountryData: ((WorldTime) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countrySearchBar.delegate = self
        
        countryTableView.delegate = self
        countryTableView.dataSource = self

        setTimeData()
//        setSearchController()
    }
    
    func setTimeData(){
    countries.append(contentsOf: [
        WorldTime(startWord: "ㄱ", country: "괌", timeDifference: "-10", dayAndNight: "오후", time: "10:48"),
        WorldTime(startWord: "ㅅ", country: "서울", timeDifference: "+0", dayAndNight: "오전", time: "1:48"),
        WorldTime(startWord: "ㅇ", country: "일본", timeDifference: "+0", dayAndNight: "오전", time: "12:48"),
        WorldTime(startWord: "ㅈ", country: "중국", timeDifference: "+0", dayAndNight: "오전", time: "1:48"),
        WorldTime(startWord: "ㅂ", country: "베트남", timeDifference: "-1", dayAndNight: "오전", time: "12:48"),
        WorldTime(startWord: "ㄷ", country: "독일", timeDifference: "-10", dayAndNight: "오후", time: "3:48"),
        WorldTime(startWord: "ㅇ", country: "영국", timeDifference: "-11", dayAndNight: "오후", time: "2:48"),
        WorldTime(startWord: "ㅁ", country: "몽골", timeDifference: "-4", dayAndNight: "오후", time: "11:48"),
        WorldTime(startWord: "ㅋ", country: "케나다", timeDifference: "-4", dayAndNight: "오후", time: "11:48"),
        WorldTime(startWord: "ㅂ", country: "보라카이", timeDifference: "-1", dayAndNight: "오전", time: "12:48")
        ])
    }
    
//    func setSearchController() {
//        let searchController = UISearchController(searchResultsController: nil)
//        searchController.searchBar.placeholder = "검색"
//        searchController.hidesNavigationBarDuringPresentation = false
//        self.navigationItem.searchController = searchController
//        self.navigationItem.title = "Search"
//        self.navigationItem.hidesSearchBarWhenScrolling = false
//    }

    @IBAction func touchUpCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   
}

extension AddWorldClockVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredCountries.count
        } else {
            let character = Array(Set(self.countries.map{ $0.startWord })).sorted()[section]
            return countries.filter{ $0.startWord == character }.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Array(Set(self.countries.map{ $0.startWord })).count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isSearching {
            return ""
        } else {
            let headerLabel = UILabel()
            headerLabel.text = String(Array(Set(self.countries.map{ $0.startWord})).sorted()[section])
            return headerLabel.text
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let character = Array(Set(self.countries.map{ $0.startWord })).sorted()[indexPath.section]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: CountryClockCell.identifier) as? CountryClockCell{
            cell.selectionStyle = .none
            
            // TODO: - Filtered Countries
            if isSearching {
                cell.countryLabel.text = filteredCountries[0].country
                
            } else {
                cell.countryLabel.text = countries.filter{ $0.startWord == character }[indexPath.row].country
            }
            
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor(red: 78/255, green: 78/255, blue: 79/255, alpha: 1.0)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .white
    }
}

extension AddWorldClockVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = Array(Set(self.countries.map{ $0.startWord })).sorted()[indexPath.section]
        let counties = self.countries.filter{ $0.startWord == character }[indexPath.row]
        sendCountryData?(counties)
        dismiss(animated: true, completion: nil)
    }
}

extension AddWorldClockVC : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
        } else {
            isSearching = true
            filteredCountries = countries.filter { $0.country.contains(searchBar.text!) }
            print(filteredCountries)
        }
        countryTableView.reloadData()
    }
}







