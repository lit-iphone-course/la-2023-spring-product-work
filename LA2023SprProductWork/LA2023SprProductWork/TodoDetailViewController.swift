//
//  TodoDetailViewController.swift
//  LA2023SprProductWork
//
//  Created by Tomoya Tanaka on 2023/02/18.
//

import UIKit

class TodoDetailViewController: UIViewController {

    var todo: Todo!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bodyLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = todo.title
        bodyLabel.text = todo.body
        dateLabel.text = dateFormatter.string(from: todo.deadline)
    }
    

}
