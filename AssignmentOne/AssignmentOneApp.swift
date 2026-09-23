//
//  AssignmentOneApp.swift
//  AssignmentOne
//
//  Created by Siksaka Suriyasat on 9/23/26.
//

import SwiftUI
import SwiftData

@main
struct AssignmentOneApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
