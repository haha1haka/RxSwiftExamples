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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Int>>(configureCell: {
            dataSorce, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(item)"
            return cell
        })
        

        Observable.just([
            SectionModel(model: "title", items: [1,2,3]),
            SectionModel(model: "title", items: [1,2,3]),
            SectionModel(model: "title", items: [1,2,3])
        ])
        .bind(to: tableView.rx.items(dataSource: dataSource))
        .disposed(by: disposeBag)
           
        
        

    }
}
