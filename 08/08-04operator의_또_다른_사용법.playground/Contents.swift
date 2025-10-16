import Foundation
import Combine

let publisher = [1, 2, 3].publisher

publisher
    .map { $0 * 10 }
    .sink { num in
        print(num)
    }

print("----")


Publishers.Map(upstream: publisher) { number in
    number * 100
}
.sink { num in
    print(num)
}

print("----")

let publisher2 = [4, 5, 6].publisher

Publishers.Merge(publisher, publisher2)
    .sink { num in
        print(num)
    }
