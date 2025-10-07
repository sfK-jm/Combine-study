import Foundation
import Combine

let arrayPublisher = [1, 2, 3, 4].publisher
    .sink { num in
        print(num)
    }

let urlPublisher = URLSession.shared.dataTaskPublisher(for: URL(string: "https://www.naver.com")!)
    .sink { completion in
        switch completion {
        case .finished:
            print("정상 종ㄹ")
        case .failure(let error):
            print("오류 발생: \(error)")
        }
    } receiveValue: { (data: Data, response: URLResponse) in
        print(data)
    }

