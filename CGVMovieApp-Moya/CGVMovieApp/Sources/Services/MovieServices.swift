//
//  MovieServices.swift
//  CGVMovieApp
//
//  Created by soyeon on 2021/05/14.
//

import Foundation
import Moya

enum MovieServices {
    case popular(param: MovieRequest)
    case upComing(param: MovieRequest)
    case nowPlaying(param: MovieRequest)
}

extension MovieServices: TargetType {
    
    // 서버 도메인
    public var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }
    
    // 서버 도메인 뒤에 추가 될 Path
    var path: String {
        switch self {
        case .popular:
            return "/movie/popular"
        case .upComing:
            return "/movie/upcoming"
        case .nowPlaying:
            return "/movie/popular"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .popular,
             .upComing,
             .nowPlaying:
            return .get
        }
    }
    
    // 테스트 용 목업 데이터
    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }
    
    // 리퀘스트에 들어갈 파라미터 설정
    var task: Task {
        switch self {
        case .popular:
            return .requestParameters(parameters: ["api_key": GeneralAPI.apiKey,"language" : "ko"], encoding: URLEncoding.default)
        case .upComing(_):
            return .requestParameters(parameters: ["api_key": GeneralAPI.apiKey,"language" : "ko"], encoding: URLEncoding.default)
        case .nowPlaying(let param):
            return .requestJSONEncodable(param)
        }
    }
    
    
    // 헤더 설정 : 모든 endPoint가 JSON 데이터를 반환하므로 아래와 같이 작성
    var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
}

