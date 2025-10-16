import Foundation
import Combine

let outerPublisher = PassthroughSubject<AnyPublisher<Int, Never>, Never>()
let innerPublisher1 = CurrentValueSubject<Int, Never>(1)
let innerPublisher2 = CurrentValueSubject<Int, Never>(100)

let subscription = outerPublisher
    .switchToLatest()
    .sink { num in
        print(num)
    }


outerPublisher.send(innerPublisher1.eraseToAnyPublisher())
innerPublisher1.send(2)

outerPublisher.send(innerPublisher2.eraseToAnyPublisher())

innerPublisher1.send(3)
innerPublisher2.send(200)

innerPublisher1.send(4)
innerPublisher2.send(300)
