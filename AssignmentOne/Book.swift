//
//  Book.swift
//  AssignmentOne
//
//  Created by Siksaka Suriyasat on 9/23/26.
//
import Foundation
import SwiftData

@Model
final class Book {
    var title: String
    var releaseDate: Date
    var author: String
    var price: Double
    var status: Status
    
    init(title: String, releaseDate: Date, author: String, price: Double, status: Status) {
        self.title = title
        self.releaseDate = releaseDate
        self.author = author
        self.price = price
        self.status = status
    }
    
    func updateStatus() {
        switch status {
        case .unread:
            status = .reading
        case .reading:
            status = .read
        case .read:
            status = .unread
        }
    }
}

enum Status: String, Codable, CaseIterable {
    case read
    case reading
    case unread
}

extension Date {
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }
}
