import RealmSwift

class Todo: Object {
    @Persisted var title: String
    @Persisted var body: String
    @Persisted var date: String
    @Persisted var done: Bool
}
