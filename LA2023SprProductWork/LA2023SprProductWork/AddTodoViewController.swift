import UIKit
import RealmSwift

class AddTodoViewController: UIViewController {

    let realm = try! Realm()
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        return formatter
    }()
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var bodyTextField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addTodo() {
        let todo = Todo()
        todo.title = titleTextField.text ?? ""
        todo.body = bodyTextField.text ?? ""
        todo.date = dateFormatter.string(from: datePicker.date)
        todo.done = false
        
        try! realm.write {
            realm.add(todo)
        }
        navigationController?.popViewController(animated: true)
    }
}


