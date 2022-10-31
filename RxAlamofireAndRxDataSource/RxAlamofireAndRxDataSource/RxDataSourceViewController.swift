import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class RxDataSourceViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    var dataSource: RxTableViewSectionedReloadDataSource<SectionModel<String, Int>>!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testRxDataSource()
    }
}




extension RxDataSourceViewController {
    func testRxDataSource() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        dataSource = .init(configureCell: {
            dataSorce, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(item)"
            return cell
        })
        

    
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].model
        }
        
        

        Observable.just([
            SectionModel(model: "title", items: [1,2,3]),
            SectionModel(model: "title", items: [1,2,3]),
            SectionModel(model: "title", items: [1,2,3])
        ])
        .bind(to: tableView.rx.items(dataSource: dataSource))
        .disposed(by: disposeBag)
           

        

    }
}
