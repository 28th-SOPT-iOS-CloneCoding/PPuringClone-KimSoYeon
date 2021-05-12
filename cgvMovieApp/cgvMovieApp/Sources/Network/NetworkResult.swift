//
//  NetWorkResult.swift
//  cgvMovieApp
//
//  Created by soyeon on 2021/05/10.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
