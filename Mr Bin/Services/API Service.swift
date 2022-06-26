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
    
    
    static func getData(_ start: String, _ end: String) async throws -> [Item] {
        guard let url = URL.collectionDays(start, end) else { throw ServerError.invalidURL }
        let (data, _) = try await URLSession.shared.data(from: url)
        // Parse the JSON data
        let collectionResponse = try JSONDecoder().decode(CollectionResponse.self, from: data)
        return collectionResponse.slots.sorted { $0.startTS < $1.startTS }
    }
    
    
    
}
