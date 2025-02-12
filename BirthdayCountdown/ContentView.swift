//
//  ContentView.swift
//  BirthdayCountdown
//
//  Created by Thảo Linh Nguyễn on 12/2/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = BirthdayViewModel()
    @State private var showingAddBirthday = false
    var body: some View {
        NavigationView {
            List{
                ForEach(viewModel.birthdays){ birthday in
                    NavigationLink(destination: EditBirthdayView(viewModel: viewModel, birthday: birthday)){
                        VStack(alignment: .leading){
                            Text(birthday.name).font(.headline)
                            Text("Next birthday in \(daysUntilNextBirtday(from:birthday.date)) days 🎂").font(.subheadline)
                            
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteBirthday)
                
            }
            .navigationTitle("Birthdays 🥳")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        showingAddBirthday = true
                    }){
                        Image(systemName: "plus")
                    }
                }
                
            }
            .sheet(isPresented: $showingAddBirthday, content: {
                AddBirthdayView(viewModel: viewModel)
            })
        }
    }
    
    private func daysUntilNextBirtday(from date: Date) -> Int{
        let calendar = Calendar.current
        let now = Date()
        let currentYear = calendar.component(.year, from: now)
        var nextBirthdayComponents = calendar.dateComponents([.day, .month], from: date)
        nextBirthdayComponents.year = currentYear
        
        if let nextBirthdayDate = calendar.date(from: nextBirthdayComponents),
           nextBirthdayDate >= now
        {
            return calendar.dateComponents([.day], from: now, to: nextBirthdayDate).day ?? 0
        }
        else{
            nextBirthdayComponents.year! += 1
            let nextBirthday = calendar.date(from: nextBirthdayComponents)!
            return calendar.dateComponents([.day], from: now, to: nextBirthday).day ?? 0
        }
    }
}

struct AddBirthdayView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: BirthdayViewModel
    @State private var name = ""
    @State private var date = Date()
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                DatePicker("Date", selection: $date, displayedComponents: .date)
            }
            .navigationTitle("Add Birthday")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        viewModel.addBirthday(name: name, date: date)
                        presentationMode.wrappedValue.dismiss() // Dismiss the view after saving
                    }
                }
                ToolbarItem(placement: .cancellationAction, content: {
                    Button("Cancel"){
                        presentationMode.wrappedValue.dismiss()
                    }
                })
            }
            
        }
    }
}

struct EditBirthdayView: View {
    @Environment(
        \.presentationMode
    ) var presentationMode
    @ObservedObject var viewModel: BirthdayViewModel
    @State var birthday: Birthday
    var body: some View{
        Form{
            TextField(
                "Name",
                text: $birthday.name
            )
            DatePicker(
                "Date",
                selection: $birthday.date,
                displayedComponents: .date
            )
            
        }
        .navigationTitle(
            "Edit \(birthday.name)'s Birthday"
        )
        .toolbar{
            ToolbarItem(
                placement: .confirmationAction
            ) {
                Button(
                    "Save"
                ){
                    viewModel
                        .updateBirthday(
                            birthday
                        )
                    presentationMode.wrappedValue
                        .dismiss()
                }
            }            }
    }
}

#Preview {
    ContentView()
}
