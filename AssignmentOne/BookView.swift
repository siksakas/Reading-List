//
//  BookView.swift
//  AssignmentOne
//
//  Created by Siksaka Suriyasat on 9/23/26.
//
import SwiftUI
import SwiftData

struct BookView: View {
//    @State var books: [Book] = [
//        Book(title: "Book of Siksaka", releaseDate: Date.now, author: "Siksaka", price: 9.99, status: .read),
//        Book(title: "Silence", releaseDate: Date.now, author: "Shusaku Endo", price: 9.99, status: .unread)
//    ]
    @Query(sort: \Book.releaseDate) var books: [Book]
    @Environment(\.modelContext) private var modelContext
//    @State var newBook: Book = Book(title:"",releaseDate: Date.now, author: "", price: 0.0, status: .unread)
    @State var showOverlay = false
    
    var body: some View {
        NavigationStack {
            List () {
                ForEach(books){ book in
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
                    .swipeActions(edge: .trailing){
                        Button (role:.destructive){
                            modelContext.delete(book)
                        } label: {
                            Image(systemName: "trash.fill")
                        }
                        Button (role:.confirm){
                            modelContext.delete(book)
                        } label: {
                            Image(systemName: "pencil")
                        }
                    }
                    .onTapGesture {
                        book.updateStatus()
                    }
                }
            }
            .navigationTitle(Text("Reading List"))
        }
        .task {
                if books.isEmpty {
                    modelContext.insert(
                        Book(
                            title: "Book of Siksaka",
                            releaseDate: .now,
                            author: "Siksaka",
                            price: 9.99,
                            status: .read
                        )
                    )

                    modelContext.insert(
                        Book(
                            title: "Silence",
                            releaseDate: .now,
                            author: "Shusaku Endo",
                            price: 9.99,
                            status: .unread
                        )
                    )
                }
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
            addBookOverlay()
        }
        
        

    }
}

struct addBookOverlay: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var releaseDate: Date = Date.now
    @State private var price: Double = 0.0
    
    // update this later with a computed var
    private var readyToSubmit: Bool {
        !title.isEmpty && !author.isEmpty
    }
    
    var body: some View {
        VStack{
            Text("Add Book")
                .font(.title)
                .bold()
            Divider()
            TextField("Enter Title",text: $title)
            TextField("Author Name",text: $author)
            HStack{
                DatePicker(selection:$releaseDate,in:Date.distantPast...Date.now,displayedComponents: .date) {
                    Text("Release Date: ")
                }
            }
            HStack {
                Text("Price: ")
                TextField("Price",value:$price,format: .currency(code: "USD"))
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
                    if readyToSubmit {
                        modelContext.insert(
                            Book(title: title, releaseDate: releaseDate, author: author, price: price, status: .unread)
                        )
                        dismiss()
                    }
                } label: {
                    if readyToSubmit {
                        Image(systemName:"checkmark")
                            .font(.title)
                            .frame(width:50, height: 50)
                            .background(Circle().fill(Color.white))
                    } else {
                        Image(systemName:"checkmark")
                            .font(.title)
                            .frame(width:50, height: 50)
                            .background(Circle().fill(Color.white))
                            .foregroundStyle(Color.gray)
                    }
                    
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
        .modelContainer(for: Book.self, inMemory: true)
}
