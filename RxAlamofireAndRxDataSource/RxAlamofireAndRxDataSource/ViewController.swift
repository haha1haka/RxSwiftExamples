import UIKit
import RxSwift
import RxCocoa
import RxAlamofire


class ViewController: UIViewController {

    let disposBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testRxAlmofire()
    }
}




// MARK: - RxAlamofire
extension ViewController {
    func testRxAlmofire() {
        let url = APIKey.searchURL + "apple"
        request(.get, url, headers: ["Authorization": APIKey.authorization])
            .data()
            .decode(type: SearchPhoto.self, decoder: JSONDecoder())
            .subscribe(onNext: { value in
                print(value.results[0].likes)
            })
            .disposed(by: disposBag)
    }
}
