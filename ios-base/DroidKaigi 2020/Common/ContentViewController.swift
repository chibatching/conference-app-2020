import RxCocoa
import RxSwift
import UIKit

// this is base contentViewController in NavigationDrawerController
class ContentViewController: UIViewController {
    private let disposeBag = DisposeBag()
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAppBar() 
    }

    private func setUpAppBar() {
        let menuImage = UIImage(named: "ic_menu")
        let templateMenuImage = menuImage?.withRenderingMode(.alwaysTemplate)
        let menuItem = UIBarButtonItem(image: templateMenuImage,
                                       style: .plain,
                                       target: self,
                                       action: nil)
        let logoImage = UIImage(named: "logo")
        let templateLogoImage = logoImage?.withRenderingMode(.alwaysOriginal)
        let logoItem = UIBarButtonItem(image: templateLogoImage, style: .plain, target: nil, action: nil)

        navigationItem.leftBarButtonItems = [menuItem, logoItem]
        navigationController?.navigationBar.barTintColor = ApplicationScheme.shared.colorScheme.primaryColor
        navigationController?.navigationBar.tintColor = ApplicationScheme.shared.colorScheme.onPrimaryColor
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
        ]

        menuItem.rx.tap
            .bind(to: Binder(self) { me, _ in
                me.navigationDrawerController?.toggleLeftView()
            }).disposed(by: disposeBag)
    }
}
