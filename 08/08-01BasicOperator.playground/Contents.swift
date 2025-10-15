import Foundation
import Combine

let publisher = [1, 2, 3, 4].publisher

//1. map
print("=== map ===")
publisher
    .map { $0 * 4 }
    .sink { number in
        print(number)
    }

//2. filter
print("=== filter ===")
publisher
    .filter { $0 >= 2 }
    .sink { num in
        print(num)
    }

//3. reduce
print("=== reduce ===")
publisher
    .reduce(0) { accumulator, number in
        print("accumulator: \(accumulator)")
        print("number: \(number)")
        return accumulator + number
    }
    .sink { num in
        print(num)
    }

//4. scan
print("=== scan ===")
publisher
    .scan(0) { $0 + $1 }
    .sink { num in
        print(num)
    }

//5. compactMap
print("=== compactMap ===")

let publisher2 = [1, 2, nil, 4].publisher

publisher2
    .compactMap { $0 }
    .sink { num in
        print(num)
    }

//6. replaceNil
print("=== replaceNil ===")
publisher2
    .replaceNil(with: 100)
    .compactMap { $0 }
    .sink { num in
        print(num)
    }
