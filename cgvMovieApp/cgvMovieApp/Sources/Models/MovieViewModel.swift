//
//  MovieViewModel.swift
//  cgvMovieApp
//
//  Created by soyeon on 2021/05/12.
//

import Foundation

class MovieViewModel {
    private var apiService = GetMovieDataService()
    private var popularMovies = [Movie]()
    private var upComingMovies = [Movie]()
    
    func fetchPopularMoviesData(comletion:@escaping () -> ()) {
        apiService.getMovieInfo { (result) in
            switch result {
            case .success(let listOf):
                self.popularMovies = listOf.self as! [Movie]
                self.upComingMovies = listOf.self as! [Movie]
                comletion()
            case .requestErr(_):
                return
            case .pathErr:
                return
            case .serverErr:
                return
            case .networkFail:
                return
            }
        }
    }
    
    func numberOfRowInsection(section: Int) -> Int {
        if popularMovies.count != 0 {
            return popularMovies.count
        }
        return 0
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Movie {
        return popularMovies[indexPath.row]
    }
}
