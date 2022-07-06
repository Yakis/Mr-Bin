//
//  LargeWidgetView.swift
//  Mr-Bin_Widget_ExtensionExtension
//
//  Created by Mugurel Moscaliuc on 28/06/2022.
//

import SwiftUI

struct LargeWidgetView: View {
    
    var items: [Item]
    var gradient: Gradient
    
    var body: some View {
        GeometryReader { geometry in
            let size = min((geometry.size.height / CGFloat(items.count)) - 24, (geometry.size.height / 2) - 64)
            VStack(alignment: .leading, spacing: 16) {
                ForEach(items, id: \.id) { item in
                    HStack {
                        ItemMainView(item: item, size: size)
                        Text(
                        """
                            rubbish that cannot be recycled
                            wrapped or bagged kitchen
                            food waste to avoid smells
                            nappies wrapped in bags
                        """
                        )
                        .font(.caption2)
                        .fontWeight(.light)
                        .foregroundColor(Color(UIColor.lightText))
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .padding([.leading, .trailing], 16)
        }
    }
    
    
}



struct ItemMainView: View {
    
    var item: Item
    var size: CGFloat
    
    var body: some View {
        VStack(spacing: 5) {
            Text(item.title)
                .font(.caption)
                .fontWeight(.semibold)
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
            .frame(width: size, height: size, alignment: .center)
            .background(item.backgroundColor.hexToColor())
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.white, lineWidth: 1)
                )
            Text("Due \(item.startTS.relativeDateTime())")
                .font(.caption2)
                .fontWeight(.light)
                .foregroundColor(Color(UIColor.lightText))
        }
    }
    
}
