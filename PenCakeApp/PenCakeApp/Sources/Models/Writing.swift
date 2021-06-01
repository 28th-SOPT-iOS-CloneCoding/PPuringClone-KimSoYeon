//
//  Writing.swift
//  PenCakeApp
//
//  Created by soyeon on 2021/05/28.
//

import Foundation
import RealmSwift

class Writing: Object {
    @objc dynamic var title: String
    @objc dynamic var date: Date
    @objc dynamic var content: String
    
    let dateFormatter = DateFormatter()

    override init() {
        title = "글 1"
        
        dateFormatter.dateFormat = "MM-dd"
        date = Date()
        
        
        content = "세상에는 수많은 이야기로 넘쳐납니다."
    }
}