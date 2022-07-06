//
//  API Service.swift
//  Mr Bin
//
//  Created by Mugurel Moscaliuc on 25/06/2022.
//

import Foundation

enum ServerError: Error {
    case invalidURL
    case missingData
}




enum APIService {
    
    private static func session() -> URLSession {
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        return URLSession(configuration: config)
    }
    
    
    static func getData() async throws -> [Item] {
        guard let url = URL.collectionDays() else { throw ServerError.invalidURL }
        let (data, _) = try await URLSession.shared.data(from: url)
        // Parse the JSON data
        let items = try JSONDecoder().decode([Item].self, from: data)
        let filtered = items.filter { item in
            (item.title == "Recycling" || item.title == "Black") && item.startTS > Date() && item.startTS < Date().addingTimeInterval(604800)
        }
        return filtered.sorted { $0.startTS < $1.startTS }
    }
    
    
    static func refreshData(_ start: String, _ end: String) async throws {
        guard let url = URL.collectionDays() else { throw ServerError.invalidURL }
        var request = URLRequest(url: url)
        let dict = ["start": start, "end": end]
        let json = try JSONEncoder().encode(dict)
        request.httpBody = json
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let (_, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error while fetching data")
        }
    }
    
    
    
}
