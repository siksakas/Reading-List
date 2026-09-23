//
//  Book.swift
//  AssignmentOne
//
//  Created by Siksaka Suriyasat on 9/23/26.
//
import Foundation

struct Book: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let releaseDate: Date
    let author: String
    var price: Double
    var status: Status
}

enum Status {
    case read
    case reading
    case unread
}

extension Date {
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }
}
