//
//  CollectionResponse.swift
//  Mr Bin
//
//  Created by Mugurel Moscaliuc on 25/06/2022.
//

import Foundation


struct CollectionResponse: Decodable {
    var slots: [Item]
}

struct Item: Decodable {
    let id = UUID()
    let allDay: Bool
    let backgroundColor: String
    let borderColor: String
    let end: String
    let start: String
    let textColor: String
    let title: String
    
    var startTS: Date {
        return start.tsToDate()
    }
    
    var endTS: Date {
        return end.tsToDate()
    }
    
    
    enum CodingKeys: String, CodingKey {
        case allDay
        case backgroundColor
        case borderColor
        case end
        case start
        case textColor
        case title
    }
    
    
    
}
