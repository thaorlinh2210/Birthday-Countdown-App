//
//  Birthday.swift
//  BirthdayCountdown
//
//  Created by Thảo Linh Nguyễn on 12/2/2025.
//

import Foundation

struct Birthday: Codable, Identifiable {
    var id = UUID()
    var name: String
    var date: Date
}
