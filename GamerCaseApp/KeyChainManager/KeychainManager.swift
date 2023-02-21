//
//  KeychainManager.swift
//  GamerCaseApp
//
//  Created by Kaan Yeyrek on 2/21/23.
//

import Foundation
import Security

final class KeychainManager {
    
    func saveApiKey(apiKey: String, serviceName: String, accountName: String) -> Bool {
          guard let keychainData = apiKey.data(using: .utf8) else {
              return false
          }
          
          let query = [
              kSecClass as String: kSecClassGenericPassword as String,
              kSecAttrService as String: serviceName,
              kSecAttrAccount as String: accountName,
              kSecValueData as String: keychainData
          ] as CFDictionary
          
          SecItemDelete(query)
          let status = SecItemAdd(query, nil)
          return status == errSecSuccess
      }
    func loadApiKey(serviceName: String, accountName: String) -> String? {
          let query = [
              kSecClass as String: kSecClassGenericPassword as String,
              kSecAttrService as String: serviceName,
              kSecAttrAccount as String: accountName,
              kSecMatchLimit as String: kSecMatchLimitOne,
              kSecReturnAttributes as String: false,
              kSecReturnData as String: true
          ] as CFDictionary
          
          var dataTypeRef: AnyObject?
          let status = SecItemCopyMatching(query, &dataTypeRef)
          
          guard status == errSecSuccess,
                let retrievedData = dataTypeRef as? Data,
                let apiKey = String(data: retrievedData, encoding: .utf8) else {
              return nil
          }
          
          return apiKey
      }
}
