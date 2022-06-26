//
//  ContentView.swift
//  Mr Bin
//
//  Created by Mugurel Moscaliuc on 25/06/2022.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @EnvironmentObject var mainVM: MainVM
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(mainVM.slots, id: \.id) { slot in
                        ItemCellView(slot: slot)
                    }
                }
            }
//            .padding(.top)
            .navigationTitle("Upcoming")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Help") {
                        print("Help tapped!")
                    }
                }
            }
        }.navigationViewStyle(.stack)
    }
    
    
}


// Custom corners
struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
