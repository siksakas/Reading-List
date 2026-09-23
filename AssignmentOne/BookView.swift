//
//  BookView.swift
//  AssignmentOne
//
//  Created by Siksaka Suriyasat on 9/23/26.
//
import SwiftUI

struct BookView: View {
    @State var books: [Book] = [
        Book(title: "Book of Siksaka", releaseDate: Date.now, author: "Siksaka", price: 9.99, status: .read),
        Book(title: "Silence", releaseDate: Date.now, author: "Shusaku Endo", price: 9.99, status: .unread)
    ]
    @State var newBook: Book = Book(title:"",releaseDate: Date.now, author: "", price: 0.0, status: .unread)
    @State var showOverlay = true
    
    var body: some View {
        NavigationStack {
            List ($books, editActions: .all) { $book in
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
                .onTapGesture {
                    book.updateStatus()
                }
            }
            .navigationTitle(Text("Reading List"))
        }
        .overlay(alignment:.bottom){
            Button {
                print("blah blah")
                showOverlay = true
            } label: {
                Image(systemName: "plus")
                    .font(.title)
                    .frame(width: 50, height: 50)
                    .background(Circle().fill(Color.white))
            }
            .padding(50)
        }
        .sheet(isPresented: $showOverlay) {
            addBookOverlay(bookToAdd: $newBook,booksArr: $books)
        }
        
        

    }
}

struct addBookOverlay: View {
    @Environment(\.dismiss) var dismiss
    @Binding var bookToAdd: Book
    @Binding var booksArr: [Book]
    
    var body: some View {
        VStack{
            Text("Add Book")
                .font(.title)
            Divider()
            HStack{
                TextField("Enter Title",text: $bookToAdd.title)
                TextField("Author Name",text: $bookToAdd.author)
            }
            HStack{
                DatePicker(selection:$bookToAdd.releaseDate,in:Date.distantPast...Date.now,displayedComponents: .date) {
                    Text("Release Date: ")
                }
            }
            HStack {
                Text("Price: ")
                TextField("Price",value:$bookToAdd.price,format: .currency(code: "USD"))
            }
        }
        .padding(30)
        .overlay(alignment:.topLeading){
            HStack{
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title)
                        .frame(width:50, height: 50)
                        .background(Circle().fill(Color.white))
                }
                Spacer()
                // add check for empty content before submitting
                Button{
                    booksArr.append(bookToAdd)
                    dismiss()
                } label: {
                    Image(systemName:"checkmark")
                        .font(.title)
                        .frame(width:50, height: 50)
                        .background(Circle().fill(Color.white))
                }
            }
            .padding(20)
        }
        
        Spacer()
        
    }
}

#Preview {
//    @Previewable @State var booksArr = [Book(title: "Book of Siksaka", releaseDate: Date.now, author: "Siksaka", price: 9.99, status: .read), Book(title: "Silence", releaseDate: Date.now, author: "Shusaku Endo", price: 9.99, status: .unread)]
//    @Previewable @State var bookToAdd: Book = Book(title:"",releaseDate: Date.now, author: "", price: 0.0, status: .unread)
//    addBookOverlay(bookToAdd: $bookToAdd, booksArr: $booksArr)
    BookView()
}
