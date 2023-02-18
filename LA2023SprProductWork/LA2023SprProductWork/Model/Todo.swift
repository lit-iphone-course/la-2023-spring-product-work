import Foundation
import RealmSwift

class Todo: Object {
    @Persisted var title: String = ""
    @Persisted var body: String = ""
    @Persisted var deadline: Date = Date()
}
