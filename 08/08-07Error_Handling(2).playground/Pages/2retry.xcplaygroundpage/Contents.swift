import Foundation
import Combine

enum MyError: Error {
    case zeroError
}


let url = URL(string: "https://www.google.com")!
var retryCount = 0

let subscription = URLSession.shared.dataTaskPublisher(for: url)
    .timeout(.seconds(0.2), scheduler: DispatchQueue.main) {
        URLError(.timedOut)
    }
    .handleEvents { _ in
        retryCount += 1
        print("시도 \(retryCount)")
    }
    .retry(10)
    .sink { completion in
        switch completion {
        case .finished:
            print("정상 종료")
        case .failure(let error):
            print("에러 \(error)")
        }
    } receiveValue: { num in
        //print(num)
    }
    

