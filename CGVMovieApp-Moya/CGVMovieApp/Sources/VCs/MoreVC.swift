//
//  MoreVCs.swift
//  CGVMovieApp
//
//  Created by soyeon on 2021/05/14.
//

import UIKit
import Moya

class MoreVC: UIViewController {
    private let authProvider = MoyaProvider<MovieServices>()
    private var movieModel: MovieModel?
    private var movieData: [MovieResponse] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPopularMovie(page: 1)
//        getUpComingMovie(page: 1)

    }
    
    // MARK: - GET Popular
    private func getPopularMovie(page: Int) {
        let param: MovieRequest = MovieRequest.init(GeneralAPI.apiKey, "ko", 1)
        print("param : \(param)")
        
        authProvider.request(.popular(param: param)) { response in
            switch response {
            
            case .success(let result):
                do {
                    self.movieModel = try result.map(MovieModel.self)
                    self.movieData.append(contentsOf: self.movieModel?.results ?? [])
                    dump(self.movieData)
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
        
    }
    
    // MARK: - GET Popular
    private func getUpComingMovie(page: Int) {
        let param: MovieRequest = MovieRequest.init(GeneralAPI.apiKey, "ko", 1)
        print("param : \(param)")
        
        authProvider.request(.upComing(param: param)) { response in
            switch response {
            case .success(let result):
                do {
                    self.movieModel = try result.map(MovieModel.self)
                    self.movieData.append(contentsOf: self.movieModel?.results ?? [])
                    
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
        
    }

}



