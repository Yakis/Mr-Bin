//
//  ItemCellView.swift
//  Mr Bin
//
//  Created by Mugurel Moscaliuc on 26/06/2022.
//

import SwiftUI

struct ItemCellView: View {
    
    var slot: Item
    
    var body: some View {
        HStack {
            VStack {
                Text(slot.startTS.dateTime().components(separatedBy: " ")[0])
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                Text(slot.startTS.dateTime().components(separatedBy: " ")[1])
                    .font(.title3)
                    .fontWeight(.heavy)
                    .foregroundColor(Color(UIColor.lightText))
                Text(slot.startTS.dateTime().components(separatedBy: " ")[2])
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor.lightText))
            }
            .padding(.leading)
            Spacer()
            Text("Due \(slot.startTS.relativeDateTime())")
                .font(.caption)
                .foregroundColor(Color(UIColor.lightText))
            Spacer()
            Text(slot.title)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .padding(.trailing)
        }
        .frame(height: 80)
        .padding(8)
        .background(slot.backgroundColor.hexToColor())
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.white, lineWidth: 1)
        )
        .padding([.leading, .trailing])
        .padding(.bottom, 8)
    }
    
    
}
