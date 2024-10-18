//
//  MovieDetailViewModel.swift
//  OitechTest
//
//  Created by Manas Salimzhan on 18.10.2024.
//

import UIKit

final class MovieDetailViewModel {
    
    private let apiKey: String = {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError("API Key not found in Info.plist")
        }
        return key
    }()
    
}
