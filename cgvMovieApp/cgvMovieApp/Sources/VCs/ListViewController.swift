//
//  ListViewController.swift
//  cgvMovieApp
//
//  Created by soyeon on 2021/05/10.
//

import UIKit

class ListViewController: UIViewController {
    var movieViewModel = MovieViewModel()

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
    
    func setMovieList() {
        GetMovieDataService.shared.getMovieInfo { (response) in
            switch(response)
            {
            case .success(let movieData):
                print("success")
//                dump(movieData)
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

