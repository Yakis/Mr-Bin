//
//  SmallWidgetView.swift
//  Mr-Bin_Widget_ExtensionExtension
//
//  Created by Mugurel Moscaliuc on 25/06/2022.
//

import SwiftUI


struct SmallWidgetView: View {
    
    var items: [Item]
    var gradient: Gradient
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if let item = items.first {
                VStack {
                    Text(item.startTS.dateTime().components(separatedBy: " ")[0])
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                    Text(item.startTS.dateTime().components(separatedBy: " ")[1])
                        .font(.title3)
                        .fontWeight(.heavy)
                        .foregroundColor(Color(UIColor.lightText))
                    Text(item.startTS.dateTime().components(separatedBy: " ")[2])
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(Color(UIColor.lightText))
                }
                .frame(width: geometry.size.width / 1.5, height: geometry.size.height / 1.5, alignment: .center)
                .background(item.backgroundColor.hexToColor())
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.white, lineWidth: 1)
                    )
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    
}
