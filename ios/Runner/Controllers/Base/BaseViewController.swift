import SnapKit

class BaseViewController: UIViewController {

    var isRequesting: Bool = false
    var isModal: Bool = false
    var didLoad: Bool = false

    private var _progressHud = ProgressHud()

    // --------------------------------------
    // MARK: Life Cycle
    // --------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        _setupProgressView()
    }

    override func viewDidAppear(_ animated: Bool) {
        if !_progressHud.isAttached {
            _progressHud.isAttached = true
            _progressHud.attachProgress(toView: view)
            _progressHud.boxView.center = view.center
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // --------------------------------------
    // MARK: Private
    // --------------------------------------

    private func _setupProgressView() {
        _progressHud.iprogressStyle = .horizontal
        _progressHud.indicatorStyle = .ballPulse
        _progressHud.isShowModal = false
        _progressHud.boxSize = 44
        _progressHud.captionSize = 15
        _progressHud.alphaBox = 0.8
        _progressHud.captionColor = ColorBrand.gtelBrandDarkWhite
        _progressHud.captionView.font = FontBrand.titleLabelFont
        _progressHud.indicatorColor = ColorBrand.gtelBrandDarkWhite
        _progressHud.captionDistance = 5
        _progressHud.indicatorSize = 44
        _progressHud.isTouchDismiss = true
    }

    // --------------------------------------
    // MARK: Public
    // --------------------------------------

    var isVisible: Bool {
        return isViewLoaded && view.window != nil
    }

    func showActivity(_ loadingText: String = LOCALIZED("loading_data")) {
        view.updateCaption(text: loadingText)
        view.showProgress()
    }

    func hideActivity() {
        view.dismissProgress()
    }

    func alert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: LOCALIZED("ok"), style: .default, handler: { action in }))
        DISPATCH_ASYNC_MAIN { self.present(alert, animated: true) }
    }

    func alert(title: String?, message: String?, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: LOCALIZED("ok"), style: .default, handler: {action in
            DISPATCH_ASYNC_MAIN { handler?(action) }
        }))
        DISPATCH_ASYNC_MAIN { self.present(alert, animated: true) }
    }

    func alert(title: String?, message: String?, okHandler: ((UIAlertAction) -> Void)? = nil, cancelHandler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: LOCALIZED("ok"), style: .default, handler: {action in
            DISPATCH_ASYNC_MAIN { okHandler?(action) }
        }))
        alert.addAction(UIAlertAction(title: LOCALIZED("cancel"), style: .cancel, handler: { action in
            DISPATCH_ASYNC_MAIN { cancelHandler?(action) }
        }))
        DISPATCH_ASYNC_MAIN { self.present(alert, animated: true) }
    }
}

extension BaseViewController {
    func startLoading(_ view: UIView?, _ loadingText: String = LOCALIZED("loading_data"), shouldReload: Bool = true) {
        if _progressHud.isShowing() {
            return
        }
        if view is CustomTableView {
            guard let tableView = view as? CustomTableView else { return }
            tableView.isLoading = true
            if !tableView.isRefreshing && !didLoad && tableView.isDataEmpty {
                showActivity(loadingText)
            }
            if shouldReload {
                tableView.reload()
            }
        } else if view is CustomCollectionView {
            guard let collectionView = view as? CustomCollectionView else { return }
            if !collectionView.isRefreshing && !didLoad && collectionView.isDataEmpty {
                showActivity(loadingText)
            }
            if shouldReload {
                collectionView.reload()
            }
        } else {
            showActivity(loadingText)
        }
        isRequesting = true
    }

    func endLoading(_ view: UIView?, error: NSError?, shouldReload: Bool = true) {
        hideActivity()
        if view is CustomTableView {
            guard let tableView = view as? CustomTableView else { return }
            tableView.isLoading = false
            if tableView.isRefreshing {
                tableView.endRefreshing()
            }
            if shouldReload {
                tableView.reload()
            }
        } else if view is CustomCollectionView {
            guard let collectionView = view as? CustomCollectionView else { return }
            if collectionView.isRefreshing {
                collectionView.endRefreshing()
            }
            if shouldReload {
                collectionView.reload()
            }
        }
        isRequesting = false
        didLoad = true
        showError(error: error)
    }

    func endLoading(_ view: UIView?, errorMessage: String?, shouldReload: Bool = true) {
        hideActivity()
        if view is CustomTableView {
            guard let tableView = view as? CustomTableView else { return }
            tableView.isLoading = false
            if tableView.isRefreshing {
                tableView.endRefreshing()
            }
            if shouldReload {
                tableView.reload()
            }
        } else if view is CustomCollectionView {
            guard let collectionView = view as? CustomCollectionView else { return }
            if collectionView.isRefreshing {
                collectionView.endRefreshing()
            }
            if shouldReload {
                collectionView.reload()
            }
        }
        Graphics.showMessage(.error, body: errorMessage ?? LOCALIZED("error_unknown"))
        isRequesting = false
        didLoad = true
    }

    func showError(error: NSError?) {
        guard let error = error else  { return }
        let message = String(format: "%ld - %@", error.code, error.localizedDescription)
        Graphics.showMessage(.error, body: message)
    }
}

extension BaseViewController: UIAdaptivePresentationControllerDelegate {
    public func presentationControllerDidDismiss( _ presentationController: UIPresentationController) {
        if #available(iOS 13, *) {
            viewWillAppear(true)
            viewDidAppear(true)
        }
    }
}

