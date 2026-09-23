//
//  Book.swift
//  AssignmentOne
//
//  Created by Siksaka Suriyasat on 9/23/26.
//
import Foundation

struct Book: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var releaseDate: Date
    var author: String
    var price: Double
    var status: Status
    
    mutating func updateStatus() {
        if (status == Status.unread){
            self.status = Status.reading
        } else if (status == Status.reading){
            self.status = Status.read
        } else {
            self.status = Status.unread
        }
    }
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
