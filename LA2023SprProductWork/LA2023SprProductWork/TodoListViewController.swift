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

extension TodoListViewController: UITableViewDelegate {
}

extension TodoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        guard let cell else { fatalError("incorrect identifier") }
        cell.textLabel?.text = todos[indexPath.row].title
        cell.detailTextLabel?.text = "\(todos[indexPath.row].body) \(todos[indexPath.row].date)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
}
