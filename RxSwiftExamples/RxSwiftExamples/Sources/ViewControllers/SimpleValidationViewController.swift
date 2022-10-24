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
    
    let minimalUsernameLength = 5
    let minimalPasswordLength = 5
    var disposeBag = DisposeBag()

}

extension SimpleValidationViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        configureLayout()
        configureAttributes()
        
        checkValidation()
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
        button.setTitle("Login", for: .normal)
        configureUINavigationBar()
    }
    
    func configureUINavigationBar() {
        self.navigationItem.title = "Validation Check 🤔"
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        appearance.backgroundColor = .black
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    }

}

extension SimpleValidationViewController {
    func checkValidation() {
        
        let usernameValid = topLoginView.textFiled.rx.text.orEmpty
            .map { $0.count >= self.minimalUsernameLength }
            .share(replay: 1) // without this map would be executed once for each binding, rx is stateless by default

        let passwordValid = bottomLoginView.textFiled.rx.text.orEmpty
            .map { $0.count >= self.minimalPasswordLength }
            .share(replay: 1)

        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)
        
        usernameValid //문구
            .bind(to: bottomLoginView.textFiled.rx.isEnabled)
            .disposed(by: disposeBag)

        usernameValid
            .bind(to: topLoginView.vaildLabel.rx.isHidden)
            .disposed(by: disposeBag)
            
        

        passwordValid //문구
            .bind(to: bottomLoginView.vaildLabel.rx.isHidden)
            .disposed(by: disposeBag)

        everythingValid
            .bind(onNext: { bool in
//                button.rx.isEnabled
                if bool {
                    self.button.rx.isEnabled
                    
                }
            })
            
            .disposed(by: disposeBag)

        button.rx.tap
            .subscribe(onNext: { [weak self] _ in self?.showAlert() })
            .disposed(by: disposeBag)
     
        
    }
    
}
