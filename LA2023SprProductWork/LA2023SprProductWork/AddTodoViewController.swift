import UIKit
import RealmSwift

class AddTodoViewController: UIViewController {

    let realm = try! Realm()
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
        todo.deadline = datePicker.date
        
        try! realm.write {
            realm.add(todo)
        }
        navigationController?.popViewController(animated: true)
    }
}


