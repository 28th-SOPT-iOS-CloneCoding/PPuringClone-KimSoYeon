//
//  MoreVCs.swift
//  CGVMovieApp
//
//  Created by soyeon on 2021/05/14.
//

import UIKit
import Moya
import SnapKit

class MoreVC: UIViewController {
    private let authProvider = MoyaProvider<MovieServices>()
    private var movieModel: MovieModel?
    private var movieData: [MovieResponse] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieListTVC.self, forCellReuseIdentifier: MovieListTVC.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPopularMovie(page: 1)
        setConstraints()
        setNavigationBar()
    }

}

extension MoreVC {
    func setConstraints() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = "영화"
    }
}

extension MoreVC: UITableViewDelegate {
    
}

extension MoreVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTVC.identifier) as? MovieListTVC else { return UITableViewCell() }
        let movie = movieData[indexPath.row]
        cell.setValue(title: movie.title, poster: movie.posterPath!, release: movie.releaseDate, isAdult: movie.adult, popularity: movie.popularity, voteCount: movie.voteCount, voteAvg: movie.voteAverage)
    
        return cell
    }
}

extension MoreVC {
    private func getPopularMovie(page: Int) {
    
        let param: MovieRequest = MovieRequest.init(GeneralAPI.apiKey, "ko", page)
        print(param)
        
        authProvider.request(.popular(param: param)) { response in
            switch response {
            case .success(let result):
                do {
                    self.movieModel = try result.map(MovieModel.self)
                    self.movieData.append(contentsOf: self.movieModel?.results ?? [])
                    self.movieData = self.movieData.sorted(by: {$0.voteAverage > $1.voteAverage})
                    print("popular movieData 받아옴")
                    self.tableView.reloadData()
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}





