//
//  Story.swift
//  PenCakeApp
//
//  Created by soyeon on 2021/05/26.
//

import Foundation
import RealmSwift

class Story: Object {
    @objc dynamic var index: Int
    @objc dynamic var title: String
    @objc dynamic var subTitle: String
    var writings: List<Writing>

    override init() {
        index = 0
        title = "이야기 1"
        subTitle = "여기를 눌러서 제목을 변경하세요"
        writings = List<Writing>()
    }
}
