//
//  AppExtensions.swift
//  MyTask
//
//  Created by Ganesh Guturi on 04/09/24.
//

import Foundation

extension URLResponse {
    func statusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        if (index >= 0 && index < count) {
            return self[index]
        }
        return nil
    }
}
