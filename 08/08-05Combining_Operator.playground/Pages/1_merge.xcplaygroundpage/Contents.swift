import Foundation
import Combine

let publisher1 = PassthroughSubject<Int, Never>()
let publisher2 = PassthroughSubject<Int, Never>()

Publishers.Merge(publisher1, publisher2)
    .sink { completion in
        print(completion)
    } receiveValue: { num in
        print(num)
    }


publisher1.send(1)
publisher2.send(100)
publisher1.send(2)
publisher2.send(200)
publisher1.send(3)
publisher2.send(300)
publisher1.send(completion: .finished)
publisher1.send(4) // completion이 finished되어서 종료되었기 때문에 출력x
publisher2.send(400)
publisher2.send(completion: .finished)
publisher2.send(500)
