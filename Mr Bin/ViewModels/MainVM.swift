//
//  MainVM.swift
//  Mr Bin
//
//  Created by Mugurel Moscaliuc on 25/06/2022.
//

import Foundation

@MainActor
final class MainVM: ObservableObject {
    
    @Published var slots: [Item] = []
    
    
    init() {
        getData()
    }
    
    func getData() {
        Task {
            let start = String(Date().timeIntervalSince1970).components(separatedBy: ".").first
            let end = String(Date().addingTimeInterval(604800).timeIntervalSince1970).components(separatedBy: ".").first
            slots = try await APIService.getData(start!, end!)
        }
    }
    
}
