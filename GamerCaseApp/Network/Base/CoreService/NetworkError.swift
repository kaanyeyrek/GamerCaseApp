//
//  NetworkError.swift
//  GamerCaseApp
//
//  Created by Kaan Yeyrek on 2/9/23.
//

import Foundation

enum NetworkError: String, Error {
    case badData
    case badResponse
    case badURL
    case unauthorized
    case unexpectedStatusCode
    case decoding
}
