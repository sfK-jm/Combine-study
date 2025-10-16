import Foundation
import Combine

let publisher1 = PassthroughSubject<Int, Never>()
let publisher2 = PassthroughSubject<String, Never>()

Publishers.Zip(publisher1, publisher2)
    .sink { completion in
        print(completion)
    } receiveValue: { num, string in
        print(num, string)
    }

publisher1.send(1)
publisher2.send("A")
publisher1.send(2)
publisher2.send("B")
publisher2.send("C")
publisher1.send(3)
publisher1.send(completion: .finished)
publisher2.send("D")
