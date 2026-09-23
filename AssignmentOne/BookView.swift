//
//  BookView.swift
//  AssignmentOne
//
//  Created by Siksaka Suriyasat on 9/23/26.
//
import SwiftUI

struct BookView: View {
    let books: [Book] = [
        Book(title: "Book of Siksaka", releaseDate: Date.now, author: "Siksaka", price: 9.99, status: .read),
        Book(title: "The East Village", releaseDate: Date.now, author: "Kopiko", price: 9.99, status: .unread)
    ]
    var body: some View {
        NavigationView {
            List (books,id: \.self) { book in
                VStack{
                    HStack() {
                        switch book.status {
                            case .read:
                                Image(systemName: "book.closed.fill")
                                .foregroundStyle(Color.green)
                            case .unread:
                                Image(systemName: "book.closed.fill")
                                .foregroundStyle(Color.blue)
                            case .reading:
                                Image(systemName: "book.closed.fill")
                                .foregroundStyle(Color.yellow)
                        }
                        
                        Text("\(book.title) (\(book.releaseDate,format:.dateTime.year()))")
                            .bold()
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .init(horizontal: .leading, vertical: .center))
                    HStack {
                        Text("By: \(book.author)")
                        Spacer()
                        Text("$\(book.price, specifier: "%.2f")")
                    }
                }
            }
            .navigationTitle(Text("Reading List"))
        }

    }
}

#Preview {
    BookView()
}
