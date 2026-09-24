//
//  StatsView.swift
//  AssignmentOne
//
//  Created by Siksaka Suriyasat on 9/23/26.
//
import SwiftUI
import SwiftData

struct StatsView: View {
    @Query var books: [Book]
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        
    }
}

#Preview {
    StatsView()
}
