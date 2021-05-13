//
//  ListViewController.swift
//  cgvMovieApp
//
//  Created by soyeon on 2021/05/10.
//

import UIKit
import SnapKit

enum MovieChart: String {
    case movieChart = "무비차트"
    case artHouse = "아트하우스"
    case upcoming = "개봉예정"
}

class ListViewController: UIViewController {
    var movieViewModel = MovieViewModel()
    private var filteredMovieList: [Movie] = []

    @IBOutlet weak var movieListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationController()
        loadPopularMoivesData()
        setMovieList()
    }
    
    private func setUpNavigationController() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    private func loadPopularMoivesData() {
        movieViewModel.fetchPopularMoviesData { [weak self] in
            self?.movieListTableView.delegate = self
            self?.movieListTableView.dataSource = self
            self?.movieListTableView.reloadData()
        }
    }
    
    func filterHeaderView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray6
        
        let popularityButton = UIButton()
        popularityButton.setTitle("- 인기순", for: .normal)
        popularityButton.setTitleColor(UIColor.black, for: .normal)
        popularityButton.addTarget(self, action: #selector(filterTableView(_:)), for: .touchUpInside)
        
        let voteRateButton = UIButton()
        voteRateButton.setTitle("- 투표율 순", for: .normal)
        voteRateButton.setTitleColor(UIColor.darkGray, for: .normal)
        voteRateButton.addTarget(self, action: #selector(filterTableView(_:)), for: .touchUpInside)
        
        view.addSubview(popularityButton)
        view.addSubview(voteRateButton)
        
        popularityButton.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).inset(10)
            make.centerY.equalTo(view.snp.centerY)
        }
        voteRateButton.snp.makeConstraints { make in
            make.leading.equalTo(popularityButton.snp.trailing).inset(-10)
            make.centerY.equalTo(view.snp.centerY)
        }
        
        return view
    }
    
    @objc func filterTableView(_ sender: UIButton) {
        
    }
    
    func setMovieList() {
        GetMovieDataService.shared.getMovieInfo { (response) in
            switch(response)
            {
            case .success(_):
                print("success")
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkErr")
            }
        }
    }
}


extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return filterHeaderView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieViewModel.numberOfRowInsection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListCell", for: indexPath) as! MovieListCell
        let movie = movieViewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(movie)
        
        return cell
    }
}

