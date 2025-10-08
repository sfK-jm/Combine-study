import UIKit
import Combine

//let url = URL(string: "https://www.naver.com")!
//
//let subscription = URLSession.shared.dataTaskPublisher(for: url)
//    .print("urlsession publisher")
//    .map { (data: Data, response: URLResponse) in
//        return data
//    }
//    .sink { completion in
//        switch completion {
//        case .finished:
//            print("완료됨!")
//        case .failure(let error):
//            print("에러 발생: \(error)")
//        }
//    } receiveValue: { data in
//        print("처리완료 \(data)")
//    }

//subscription.cancel()


// 동기적인 퍼블리셔는 subscription이 없어도 실행이됨
//[1, 2, 3].publisher
//    .sink { num in
//        print(num)
//    }

// 작업을 기달려야 하는 퍼블리셔는 subscription이 필요함
//let subscription2 = [1, 2, 3].publisher
//    .delay(for: .seconds(1), scheduler: DispatchQueue.main)
//    .sink { number in
//        print(number)
//    }

// - class 내부에서의 subscription

class TestClass {
    
    var cancellables: Set<AnyCancellable> = []
    
    init() {
        print("init")
        
        let url = URL(string: "https://www.naver.com")!
        
        URLSession.shared.dataTaskPublisher(for: url)
            .print("urlsession publisher1")
            .map { (data: Data, response: URLResponse) in
                return data
            }
            .sink { completion in
                switch completion {
                case .finished:
                    print("완료됨!")
                case .failure(let error):
                    print("에러 발생: \(error)")
                }
            } receiveValue: { data in
                print("처리완료 \(data)")
            }
            .store(in: &cancellables)
        
        URLSession.shared.dataTaskPublisher(for: url)
            .print("urlsession publisher2")
            .map { (data: Data, response: URLResponse) in
                return data
            }
            .sink { completion in
                switch completion {
                case .finished:
                    print("완료됨!")
                case .failure(let error):
                    print("에러 발생: \(error)")
                }
            } receiveValue: { data in
                print("처리완료 \(data)")
            }
            .store(in: &cancellables)
    }
}

var testClass = TestClass()
