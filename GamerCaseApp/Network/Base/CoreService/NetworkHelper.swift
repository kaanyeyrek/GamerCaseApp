//
//  NetworkHelper.swift
//  GamerCaseApp
//
//  Created by Kaan Yeyrek on 2/9/23.
//

import Foundation

enum NetworkHelper {
    static let apiKey = APIManager().loadApiKey()
}
final class APIManager {
    let keychainManager = KeychainManager()
    let serviceName = "My_App"
    let accountName = "kaanyeyrek@icloud.com"
    
    func saveApiKey(apiKey: String) -> Bool {
           return keychainManager.saveApiKey(apiKey: apiKey, serviceName: serviceName, accountName: accountName)
       }
    func loadApiKey() -> String? {
           return keychainManager.loadApiKey(serviceName: serviceName, accountName: accountName)
       }
}

