//
//  GetMovieDataService.swift
//  cgvMovieApp
//
//  Created by soyeon on 2021/05/10.
//

import Foundation
import Alamofire

struct GetMovieDataService {
    static let shared = GetMovieDataService()
    
    func getMovieInfo(completion : @escaping (NetworkResult<Any>) -> Void)
    {
        let URL = GeneralAPI.baseURL + GeneralAPI.nowPlaying + "?api_key=" + GeneralAPI.apiKey + "&language=ko&page=1"
        let header : HTTPHeaders = ["Content-Type": "application/json"]
        
        let dataRequest = AF.request(URL,
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: header)

        dataRequest.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let statusCode = dataResponse.response?.statusCode else {return}
                
                guard let value = dataResponse.value else {return}
                
                let networkResult = self.judgeStatus(by: statusCode, value)
                
                completion(networkResult)

            case .failure:
                completion(.pathErr)
            }
        }
        
    }
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200:
            return isValidData(data: data)
        case 400:
            return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    private func isValidData(data : Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(MoviesData.self, from: data) else {
            return .pathErr
        }
        
        return .success(decodedData.movies)
    }
}
