import UIKit
import SnapKit
import RxSwift
import RxCocoa

enum Section {
    case top(String = "Username" , String = "Username has to be at least 5 characters")
    case bottom(String = "Password", String = "Password has to be at least 5 characters")
}

class SimpleValidationViewController: UIViewController {
    
    var topLoginView = LoginUIView(frame: .zero, Section.top())
    var bottomLoginView = LoginUIView(frame: .zero, Section.bottom())
    var button = UIButton()
}

extension SimpleValidationViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        configureLayout()
        configureAttributes()
        configureUINavigationBar()
    }
}

extension SimpleValidationViewController {
    
    
    func configureHierarchy() {
        [topLoginView, bottomLoginView].forEach { view.addSubview( $0 ) }
        view.addSubview(button)
    }
    
    func configureLayout() {
        topLoginView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(150)
        }
        bottomLoginView.snp.makeConstraints {
            $0.top.equalTo(topLoginView.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(150)
        }
        button.snp.makeConstraints {
            $0.top.equalTo(bottomLoginView.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(44)
        }

    }
    
    func configureAttributes() {
        
        view.backgroundColor = .black
        
        
        button.backgroundColor = .lightGray
        button.setTitle("로그인", for: .normal)
    
    }
    
    func configureUINavigationBar() {
        self.navigationItem.title = "Validation Check!!"
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        appearance.backgroundColor = .black
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
                
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    }
    


}
