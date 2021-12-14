//
//  ToDoListProtocols.swift
//  ToDoList
//
//  Created by administrator on 13/12/2021.
//

import Foundation


protocol AddNewItemDelegate{
    func addNewItem(title: String, note: String, date: Date)
}

protocol UpdateItemDelegate {
    func updateItem(title: String, note: String, date: Date, index: Int)
}

protocol GetToDoItem {
    func getToDoItem(at index: Int) -> ToDoItem
}
