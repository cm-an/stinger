//
//  Error.swift
//  stinger
//
//  Created by 안춘모 on 2/19/24.
//

import Foundation

enum IdentificationError: Error {
    case verifyFailedFromKCP
    case verifyFailedFromInsudeal
    case phoneNumberAlreadyExist
    case notFoundPhoneNumber
    case nuknown
}

class ErrorResponse: Codable {
    let code: IntOrString
    let message: String
    
    init(code: IntOrString, message: String) {
        self.code = code
        self.message = message
    }
}

struct CodeFError: Error {
    enum APIName {
        case checkLicense, requestAuthNumber, importCertification
    }
    
    let apiName: APIName
    let result: Any?
    let code: String
    let message: String
}
