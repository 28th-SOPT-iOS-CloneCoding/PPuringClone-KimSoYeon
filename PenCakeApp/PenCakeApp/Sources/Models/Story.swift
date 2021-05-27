//
//  Story.swift
//  PenCakeApp
//
//  Created by soyeon on 2021/05/26.
//

import Foundation
import RealmSwift

class Story: Object{
    @objc dynamic var storyTitle = ""
    @objc dynamic var storySubTitle = ""
    @objc dynamic var title = ""
    @objc dynamic var date = ""
    @objc dynamic var content = ""
}
