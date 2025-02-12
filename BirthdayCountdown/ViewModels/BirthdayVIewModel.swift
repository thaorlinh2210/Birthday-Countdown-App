//
//  BirthdayVIewModel.swift
//  BirthdayCountdown
//
//  Created by Thảo Linh Nguyễn on 12/2/2025.
//

import SwiftUI

class BirthdayViewModel: ObservableObject {
    @AppStorage("birthday") private var storedBirthdays: [Birthday] = []
    
    @Published var birthdays: [Birthday] = []
    
    init() {
        loadBirthdays()
    }
    
    
    private func loadBirthdays() {
        birthdays = storedBirthdays
    }
    
    private func saveBirthdays() {
        storedBirthdays = birthdays
    }
    
    func addBirthday(name: String, date: Date) {
        let newBirthday = Birthday(name: name, date: date)
        birthdays.append(newBirthday)
        saveBirthdays()
    }
    
    func updateBirthday(_ birthday: Birthday) {
        if let index = birthdays.firstIndex(where: { $0.id == birthday.id}) {
            birthdays[index] = birthday
            saveBirthdays()
        }
    }
    
    func deleteBirthday(at offsets: IndexSet){
        birthdays.remove(atOffsets: offsets)
        saveBirthdays()
    }
}
