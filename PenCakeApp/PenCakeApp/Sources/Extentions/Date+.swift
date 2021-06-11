//
//  Date+.swift
//  PenCakeApp
//
//  Created by soyeon on 2021/06/04.
//

import Foundation

extension Date {
    func getStringToDate(format: String = "yyyy-MM-dd", date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .init(identifier: "ko_KR")
        dateFormatter.dateFormat = format
        
        return dateFormatter.date(from: date) ?? Date()
    }
    
    func getDateToString(format: String = "yyyy.MM.dd", date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .init(identifier: "ko_KR")
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: date)
    }
    
    
    func slicingDate(date : Date) -> String {
        var message : String = "" // 최종 결과값 담기위한 변수
        let UTCDate = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 32400)
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let defaultTimeZoneStr = formatter.string(from: UTCDate)
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        format.locale = Locale(identifier: "ko_KR")
        // 한국 시각기준으로 측정합니다.
        
        let krTime = format.date(from: defaultTimeZoneStr)
        let articleDate = format.string(from: date)
        let useTime = Int(krTime!.timeIntervalSince(date))
        
        if useTime < 60 {
            message = "방금 전"
        } else if useTime < 3600 {
            message = String(useTime/60) + "분 전"
        } else if useTime < 86400 {
            message = String(useTime/3600) + "시간 전"
        } else {
            let timeArray = articleDate.components(separatedBy: " ")
            let dateArray = timeArray[0].components(separatedBy: "-")
            
            message = dateArray[1] + "." + dateArray[2]
        }
        
        return message
    }
}
