//
//  Writing.swift
//  PenCakeApp
//
//  Created by soyeon on 2021/05/28.
//

import Foundation
import RealmSwift

class Writing: Object {
    dynamic var title: String
    dynamic var date: Date
    dynamic var content: String

    override init() {
        title = "글 1"
        date = Date()
        content = "세상에는 수많은 이야기로 넘쳐납니다."
    }
}
