import UIKit

/*class User {
    var name: String
    var isFullTime: Bool
    
    init(name: String, isFullTime: Bool) {
        self.name = name
        self.isFullTime = isFullTime
    }
}

class Staff: User {
    
}

class Teacher: User {
    var courses: [String]
    
    init(name: String, cources: [String], isFullTime: Bool) {
        self.courses = courses
        super.init(name: name, isFullTime: isFullTime)
    }
}

class Student: User {
    
}*/

struct Student {
    let name: String
    let courses: [String]
    let isFullTime: Bool
}

struct Teacher {
    let name: String
    let courses: [String]
    let isFullTime: Bool
}

struct Staff {
    let name: String
    let isFullTime: Bool
}

struct International {
    let name: String
    let isFullTime: Bool
    let courses: [String]
    let countryOfOrigin: String
}

enum User {
    case student(Student)
    case teacher(Teacher)
    case staff(Staff)
    case international(International)
}


func updateProfile(user: User) {
    switch user {
    case .student(let student):
        print(student)
    case .teacher(let teacher):
        print(teacher)
    case .staff(let staff):
        print(staff)
    case .international(let international):
        print(international)
    }
}

updateProfile(user: User.student(Student(name:"Toshko", courses: ["Math", "IT"], isFullTime: true)))
