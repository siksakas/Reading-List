//
//  ContentView.swift
//  AssignmentOne
//
//  Created by Siksaka Suriyasat on 9/23/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab ("Books",systemImage: "book"){
                Text("Hello, World!")
            }
            Tab ("Statistics",systemImage: "chart.bar.horizontal.page"){
                
            }
        }
    }
}

#Preview {
    ContentView()
}
