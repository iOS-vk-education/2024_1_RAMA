struct Group: Decodable {
    let name: String
    let fac: String
    let level: String
    let course: String
}

struct selectedGroup: Decodable {
    var allGroups: [Group]
    var selectedFaculty: String
    var selectedCourse: String
    var selectedLevel: String
    var selectedGroup: String
    var facultyIsSelected: String
}
