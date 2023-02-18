import UIKit
import RealmSwift

class TodoListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    let realm = try! Realm()
    var todos = [Todo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // NOTE:別画面から戻って来た時に配列を一旦空にする(空にしないと無限に配列にTodoが追加され重複するので)
        todos.removeAll()
        for todo in realm.objects(Todo.self) {
            todos.append(todo)
        }
        tableView.reloadData()
    }
    
}

//MARK: Segue
extension TodoListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            guard let sender = sender as? Todo else { fatalError("Sender type is not todo") }
            let destination = segue.destination as! TodoDetailViewController
            destination.todo = sender
        }
        
        if segue.identifier == "toEdit" {
            guard let sender = sender as? Todo else { fatalError("Sender type is not todo") }
            let destination = segue.destination as! EditTodoViewController
            destination.todo = sender
        }
    }
}

//MARK: UITableViewDelegate
extension TodoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTodo = todos[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: selectedTodo)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 編集処理
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [self] (action, view, completionHandler) in
            self.performSegue(withIdentifier: "toEdit", sender: self.todos[indexPath.row])
            completionHandler(true)
        }
        
        // 削除処理
        let deleteAction = UIContextualAction(style: .destructive, title: "Done") { [self] (action, view, completionHandler) in
            try! realm.write { realm.delete(todos[indexPath.row]) }
            self.todos.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
}

//MARK: UITableViewDataSource
extension TodoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        guard let cell else { fatalError("incorrect identifier") }
        
        let deadline = dateFormatter.string(from: todos[indexPath.row].deadline)
        cell.textLabel?.text = todos[indexPath.row].title
        cell.detailTextLabel?.text = "\(todos[indexPath.row].body) \(deadline)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
}
