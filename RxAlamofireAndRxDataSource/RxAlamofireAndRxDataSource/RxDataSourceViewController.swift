import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class RxDataSourceViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        testRxDataSource()
    }
    
    

    
    

}

extension RxDataSourceViewController {
    func testRxDataSource() {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Int>>(configureCell: configureCell)
        Observable.just([SectionModel(model: "title", items: [1, 2, 3])])
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}
