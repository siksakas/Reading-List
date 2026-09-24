//
//  ContentView.swift
//  AssignmentOne
//
//  Created by Siksaka Suriyasat on 9/23/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            Tab ("Books",systemImage: "book"){
                BookView()
                
            }
            Tab ("Statistics",systemImage: "chart.bar.horizontal.page"){
                
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Book.self, inMemory: true)
}
