import UIKit

enum Level {
    case easy
    case medium
    case hard
}

struct Exam {
    
    var level: Level
    
    lazy private(set) var questions: [String] = {
        
        sleep(5)
        
        switch level {
        case .easy:
            return ["what is 1+2", "what is 1+2", "what is 2+2"]
        case .medium:
            return ["what is 11+22", "what is 11+22", "what is 32+42"]
        case .hard:
            return ["what is 122+332", "what is 441+255", "what is 266+250"]
        }
    }()
    
}

var exam = Exam(level: .easy)
//print(exam.questions)

var hardExam = exam
hardExam.level = .hard

print(hardExam.questions)
//print("wait for 1 sec")
//sleep(1)
//print(exam.questions)

