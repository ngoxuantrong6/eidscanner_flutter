import UIKit
import QKMRZScanner
import eidsdk

class ScanMainViewController: NavigationBarViewController {
    
    @IBOutlet weak var _mrzScannerView: QKMRZScannerView!
    
    @IBOutlet weak var _infoContainerView: UIView!
    @IBOutlet weak var _documentNumberLbl: UILabel!
    @IBOutlet weak var _dateOfBirthLbl: UILabel!
    @IBOutlet weak var _dateOfExpiryLbl: UILabel!
    @IBOutlet weak var _documentNumberValueLbl: UILabel!
    @IBOutlet weak var _dateOfBirthValueLbl: UILabel!
    @IBOutlet weak var _dateOfExpiryValueLbl: UILabel!
    
    @IBOutlet weak var _nfcScanBtn: CustomActivityButton!
    
    // --------------------------------------
    // MARK: Life Cycle
    // --------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TITLE
        self.title = LOCALIZED("title_scan_step")
        
        // LABEL
        self._documentNumberLbl.text = LOCALIZED("label_eid_number:")
        self._dateOfBirthLbl.text = LOCALIZED("label_date_of_birth:")
        self._dateOfExpiryLbl.text = LOCALIZED("label_date_of_expiry:")
        self._documentNumberValueLbl.text = ""
        self._dateOfBirthValueLbl.text = ""
        self._dateOfExpiryValueLbl.text = ""
        self._infoContainerView.layer.cornerRadius = 10.0
        
        // BUTTON
        self._nfcScanBtn.isUserInteractionEnabled = false
        self._nfcScanBtn.backgroundColor = ColorBrand.gtelBrandSilver
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _mrzScannerView.startScanning()
        _mrzScannerView.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        _mrzScannerView.stopScanning()
        _mrzScannerView.delegate = nil
        _infoContainerView.isHidden = true
    }
    
    deinit {
        _mrzScannerView = nil
    }
    
    @IBAction func _handleScanNfcButtonEvent(_ sender: Any) {
        EIDFACADE.readChipNfc(mrzKey: ONBOARDDATAMANAGER.mrzKey) { eid in
            ONBOARDDATAMANAGER.eid = eid
            let customerCode = Bundle.main.infoDictionary?["CUSTOMER_CODE"] as! String
            EIDFACADE.verifyEid(eid: eid, code: customerCode) { eidVerify in
                DISPATCH_ASYNC_MAIN {
                    let eidVerified = eidVerify.isValidIdCard
                    let eidSignatureVerified = EIDFACADE.verifyRsaSignatureDefault(plainText: eidVerify.responds ?? "", signature: eidVerify.signature)
                    ONBOARDDATAMANAGER.eid?.eidVerified = eidVerified
                    ONBOARDDATAMANAGER.eid?.eidSignatureVerified = eidSignatureVerified
                    let controller = INIT_CONTROLLER_XIB(DetailViewController.self)
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            } errorHandler: { error in
                Graphics.showMessage(.error, body: error.localizedDescription)
            }
        } errorHandler: { error in
            Log.error(error.localizedDescription)
        }
    }
    
}

extension ScanMainViewController : QKMRZScannerViewDelegate {
    public func mrzScannerView(_ mrzScannerView: QKMRZScannerView, didFind scanResult: QKMRZScanResult) {
        let df = DateFormatter()
        df.timeZone = TimeZone(secondsFromGMT: 0)
        df.dateFormat = "YYMMdd"
        let documentNumber = scanResult.documentNumber
        let dateOfBirth = df.string(from:scanResult.birthdate ?? Date())
        let dateOfExpiry = df.string(from:scanResult.expiryDate ?? Date())
        ONBOARDDATAMANAGER.mrzKey = EIDFACADE.generateMRZKey(eidNumber: documentNumber, dateOfBirth: dateOfBirth, dateOfExpiry: dateOfExpiry)
        ONBOARDDATAMANAGER.mrz = scanResult
        
        df.dateFormat = "dd/MM/YYYY"
        self._documentNumberValueLbl.text = documentNumber
        self._dateOfBirthValueLbl.text = df.string(from:scanResult.birthdate ?? Date())
        self._dateOfExpiryValueLbl.text = df.string(from:scanResult.expiryDate ?? Date())
        self._infoContainerView.isHidden = false
        
        self._nfcScanBtn.isUserInteractionEnabled = true
        self._nfcScanBtn.backgroundColor = ColorBrand.gtelBrandOrange
        
    }
}
