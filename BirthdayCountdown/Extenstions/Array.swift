//
//  Array.swift
//  BirthdayCountdown
//
//  Created by Thảo Linh Nguyễn on 12/2/2025.
//

import Foundation

extension Array: RawRepresentable where Element: Codable{
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8) else {
            return nil
        }
        
        guard let result = try? JSONDecoder().decode([Element].self, from: data) else {
            return nil
        }
        
        self = result
    }
    
    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self) else {
            return "[]"
        }
        
        return String(data: data, encoding: .utf8) ?? "[]"
    }
}
