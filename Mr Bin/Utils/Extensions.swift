//
//  Extensions.swift
//  Mr Bin
//
//  Created by Mugurel Moscaliuc on 25/06/2022.
//

import UIKit
import SwiftUI

extension String {
    
    
    func hexToColor() -> Color {
        var cString:String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.count) != 6) {
            return Color(UIColor.gray)
        }
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        return Color(
            UIColor(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0)
            )
        )
    }
    
    
    func match(_ regex: String) -> [[String]] {
        let nsString = self as NSString
        return (try? NSRegularExpression(pattern: regex, options: []))?.matches(in: self, options: [], range: NSMakeRange(0, nsString.length)).map { match in
            (0..<match.numberOfRanges).map { match.range(at: $0).location == NSNotFound ? "" : nsString.substring(with: match.range(at: $0)) }
        } ?? []
    }
    
    
    func tsToDate() -> Date {
        let regex = "[0-9]+"
        let tms = self.match(regex).first?.first
        let intu = Int(Double(tms!)! / 1000.0)
        let date = Date(timeIntervalSince1970: TimeInterval(intu))
        return date
    }
    
    
}



extension Date {
    
    func dateTime() -> String {
        let dateFormatter = DateFormatter.standardFormatter
        dateFormatter.dateFormat = "E d MMM"
        dateFormatter.locale = .current
        return dateFormatter.string(from: self)
    }
    
    func relativeDateTime() -> String {
        let dateFormatter = DateFormatter.relativeFormatter
        return dateFormatter.localizedString(for: self, relativeTo: Date())
    }
    
}


extension DateFormatter {
    
    // This gains a lot of performance, as you don't create it every time, just reuse it, and DateFormatter is expensive!!!
    static let isoDateFormatter: ISO8601DateFormatter = {
        let isoFormater = ISO8601DateFormatter()
        isoFormater.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return isoFormater
    }()
    
    
    static let relativeFormatter: RelativeDateTimeFormatter = {
        let dateFormatter = RelativeDateTimeFormatter()
        dateFormatter.unitsStyle = .full
        return dateFormatter
    }()
    
    static let standardFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter
    }()
    
    
}



extension URL {
    
    static let base = "https://www.doncaster.gov.uk/Compass/PremiseDetail/GetCollectionsForCalendar?UPRN=100050699177"
    
    //MARK: Static resources
    static func collectionDays(_ start: String, _ end: String) -> URL? {
        let percentEncodedStart = start.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? start
        let percentEncodedEnd = end.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? end
        let current = String(Date().timeIntervalSince1970)
        let percentEncodedCurrent = current.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? current
        return URL(string: "\(base)&Start=\(percentEncodedStart)&End=\(percentEncodedEnd)&_=\(percentEncodedCurrent)")
    }
}
