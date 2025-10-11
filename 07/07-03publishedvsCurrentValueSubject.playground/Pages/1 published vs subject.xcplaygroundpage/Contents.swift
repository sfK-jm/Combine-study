import UIKit
import Combine

print("====== @published ======")

class PublishedClass {
    @Published var value = 0
}

let publishedClass = PublishedClass()

let publishedSubscription = publishedClass.$value
    .sink { value in
        print("Published value: \(value)")
    }

publishedClass.value = 10
publishedClass.value = 100
publishedClass.value = 1000

print("published value: \(publishedClass.value)")

print("====== subject ======")

class SubjectClass {
    var subject = CurrentValueSubject<Int, Never>(0)
}

let subjectClass = SubjectClass()

let subjectSubscription = subjectClass.subject
    .sink { value in
        print("subject value: \(value)")
    }

subjectClass.subject.send(10)
subjectClass.subject.send(100)
subjectClass.subject.send(1000)

print("subject value: \(subjectClass.subject.value)")

