import UIKit
import RealmSwift

class EditTodoViewController: UIViewController {

    let realm = try! Realm()
    var todo: Todo!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var bodyTextField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.text = todo.title
        bodyTextField.text = todo.body
        datePicker.date = todo.deadline
    }

    @IBAction func save() {
        try! realm.write {
            todo.deadline = datePicker.date
            todo.title = titleTextField.text ?? ""
            todo.body = bodyTextField.text ?? ""
        }
        self.navigationController?.popViewController(animated: true)
    }


}
