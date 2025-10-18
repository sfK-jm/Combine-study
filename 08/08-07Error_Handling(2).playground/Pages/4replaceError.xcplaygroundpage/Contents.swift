import Foundation
import Combine

enum MyError: Error {
    case zeroError
}

let failablePublisher = [1, 2, 0, 4, 5].publisher
    .tryMap { number in
        guard number != 0 else {
            throw MyError.zeroError
        }
        return 100 / number
    }

failablePublisher
    .replaceError(with: -1)
    .sink { value in
        print(value)
    }

