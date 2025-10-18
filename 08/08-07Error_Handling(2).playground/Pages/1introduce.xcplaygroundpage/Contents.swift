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
    .sink { completion in
        switch completion {
        case .finished:
            print("정상 종료")
        case .failure(let error):
            print("에러 \(error)")
        }
    } receiveValue: { num in
        print(num)
    }

