import UIKit
import SnapKit

class LoginUIView: UIView {
    
    let label: UILabel = {
        let view = UILabel()
        return view
    }()
    var textFiled: UITextField = {
        let view = UITextField()
        view.backgroundColor = .systemPink
        return view
    }()
    
    var vaildLabel: UILabel = {
        let view = UILabel()
        view.textColor = .red
        return view
    }()
    
    convenience init(frame: CGRect,_ sectionType: Section) {
        self.init(frame: frame)
        
        switch sectionType {
        case .top(let title, let validText):
            label.text = title
            vaildLabel.text = validText
        case .bottom(let title,let vaildText):
            label.text = title
            vaildLabel.text = vaildText
        }
        
}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBlue
        cnofigureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func cnofigureHierarchy() {
        [label, textFiled, vaildLabel].forEach { self.addSubview($0) }
    }
    
    func configureLayout() {
        label.snp.makeConstraints {
            $0.top.equalTo(self).offset(20)
            $0.leading.trailing.equalTo(self).offset(20)
            $0.height.equalTo(24)
        }
        textFiled.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(self).inset(20)
            $0.height.equalTo(44)
        }
        vaildLabel.snp.makeConstraints {
            $0.top.equalTo(textFiled.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(self).offset(20)
            $0.height.equalTo(24)
        }
        
        
    }
    
    
}
