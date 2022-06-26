//
//  Mr_BinApp.swift
//  Mr Bin
//
//  Created by Mugurel Moscaliuc on 25/06/2022.
//

import SwiftUI

@main
struct Mr_BinApp: App {
    
    @StateObject var mainVM = MainVM()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(mainVM)
                .background(Color("Container"))
        }
    }
}
