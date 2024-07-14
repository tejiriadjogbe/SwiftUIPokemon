//
//  ErrorResponse.swift
//  Pokemon
//
//  Created by Adjogbe  Tejiri on 14/07/2024.
//

struct ErrorResponse: Error {
    let httpStatusCode: Int
    let message: String
    
    init(httpStatusCode: Int = 0, message: String) {
        self.httpStatusCode = httpStatusCode
        self.message = message
    }
}

