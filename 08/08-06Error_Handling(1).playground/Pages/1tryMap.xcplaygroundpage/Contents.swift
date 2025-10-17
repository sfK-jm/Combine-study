import Foundation
import Combine

enum MyError: Error {
    case ZeroError
}


let publiisher = [1, 2, 0, 3, 4].publisher

publiisher
// 0으로 나눌 수 없기 때문에 에러 발생
//    .map { num in
//        return 100 / num
//    }
    .map{ num in
        print("number: \(num)")
        return num
    }
    .tryMap { num in
        if num == 0 { throw MyError.ZeroError }
        return 100 / num
    }
    .sink { completion in
        switch completion {
        case .finished:
            print("정상완료")
        case .failure(let error):
            print("에러 발생: \(error)")
        }
    } receiveValue: { num in
        print("-> \(num)")
    }

