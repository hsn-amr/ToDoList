//
//  SaveItemViewController.swift
//  ToDoList
//
//  Created by administrator on 13/12/2021.
//

import UIKit

class SaveItemViewController: UIViewController {

    @IBOutlet weak var toDoTitleTextField: UITextField!
    
    @IBOutlet weak var toDoNoteTextView: UITextView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var addDelegate: AddNewItemDelegate?
    var editDelegate: UpdateItemDelegate?
    var getToDoItem: GetToDoItem?
    var mode: SavingModes?
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if mode == .editing {
            guard let item = getToDoItem?.getToDoItem(at: index!) else {return}
            toDoTitleTextField.text = item.title
            toDoNoteTextView.text = item.note
            datePicker.date = item.date!
        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func saveItemButtonClicked(_ sender: UIButton) {
       saveItem()
    }
    
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func saveItem(){
        let date = datePicker.date
        if let title = toDoTitleTextField.text, let note = toDoNoteTextView.text {
            if !title.isEmpty && !note.isEmpty{
                if mode == .adding {
                    addDelegate?.addNewItem(title: title, note: note, date: date)
                }else if mode == .editing {
                    editDelegate?.updateItem(title: title, note: note, date: date, index: index!)
                }
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
