import UIKit

class DetailViewController: ChildViewController, CustomTableViewDelegate {
    
    @IBOutlet weak var _headerView: UIView!
    @IBOutlet weak var _idcardIconImgView: UIImageView!
    @IBOutlet weak var _headerTitleLbl: UILabel!
    @IBOutlet weak var _headerDescriptionLbl: UILabel!
    
    @IBOutlet weak var _tableView: CustomTableView!
    
    private let kStatusTableCellIdentifier = "statustablecell"
    private let kImageTableCellIdentifier = "imagetablecell"
    private let kInfoTableCellIdentifier = "infotablecell"
    
    // --------------------------------------
    // MARK: Life Cycle
    // --------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = LOCALIZED("title_detail_info")
        _headerView.layer.cornerRadius = 10.0
        _tableView.setup(cellPrototypes: _prototypes, hasHeaderSection: true, enableRefresh: false, delegate: self)
        _loadHeaderData()
        _loadTableData()
    }
        
    // --------------------------------------
    // MARK: Private
    // --------------------------------------
    
    private var _prototypes: [[String:Any]]? {
        return [
            [kCellIdentifierKey: kStatusTableCellIdentifier, kCellNibNameKey: String(describing: StatusTableCell.self), kCellClassKey: StatusTableCell.self],
            [kCellIdentifierKey: kImageTableCellIdentifier, kCellNibNameKey: String(describing: ImageTableCell.self), kCellClassKey: ImageTableCell.self],
            [kCellIdentifierKey: kInfoTableCellIdentifier, kCellNibNameKey: String(describing: InfoTableCell.self), kCellClassKey: InfoTableCell.self],
        ]
    }
    
    private func _loadHeaderData() {
        
        let hasChipAuth = ONBOARDDATAMANAGER.eid?.isChipAuthenticationSupported == true
        let chipAuthSuccess = ONBOARDDATAMANAGER.eid?.chipAuthenticationStatus == .success
        let passiveAuthSuccess = ONBOARDDATAMANAGER.eid?.passiveAuthenticationStatus == .success
        let activeAuthSuccess = ONBOARDDATAMANAGER.eid?.activeAuthenticationStatus == .success
        let rarCertVerification = ONBOARDDATAMANAGER.eid?.eidVerified == true
        let rarSignVerification = ONBOARDDATAMANAGER.eid?.eidSignatureVerified == true
        
        var color = ColorBrand.gtelBrandDarkGray
        var title = LOCALIZED("eid_invalid")
        var description = LOCALIZED("eid_chip_invalid")
        
        if hasChipAuth {
            if chipAuthSuccess && passiveAuthSuccess && activeAuthSuccess && rarCertVerification && rarSignVerification {
                color = ColorBrand.gtelBrandGreen
                title = LOCALIZED("eid_valid")
                description = LOCALIZED("eid_content_valid")
            } else if (!chipAuthSuccess) {
                color = ColorBrand.gtelBrandRed
                title = LOCALIZED("eid_invalid")
                description = LOCALIZED("eid_ca_invalid")
            } else if !passiveAuthSuccess {
                color = ColorBrand.gtelBrandRed
                title = LOCALIZED("eid_invalid")
                description = LOCALIZED("eid_pa_invalid")
            } else if !activeAuthSuccess {
                color = ColorBrand.gtelBrandRed
                title = LOCALIZED("eid_invalid")
                description = LOCALIZED("eid_aa_invalid")
            } else if !rarCertVerification {
                color = ColorBrand.gtelBrandRed
                title = LOCALIZED("eid_invalid")
                description = LOCALIZED("eid_rar_not_verified")
            } else if !rarSignVerification {
                color = ColorBrand.gtelBrandRed
                title = LOCALIZED("eid_invalid")
                description = LOCALIZED("eid_rar_signature_not_verified")
            } else {
                color = ColorBrand.gtelBrandDarkGray
                title = LOCALIZED("eid_invalid")
                description = LOCALIZED("eid_no_data")
            }
        } else {
            if passiveAuthSuccess && rarCertVerification && rarSignVerification {
                color = ColorBrand.gtelBrandGreen
                title = LOCALIZED("eid_valid")
                description = LOCALIZED("eid_content_valid")
            } else if !passiveAuthSuccess {
                color = ColorBrand.gtelBrandRed
                title = LOCALIZED("eid_invalid")
                description = LOCALIZED("eid_pa_invalid")
            } else if !activeAuthSuccess {
                color = ColorBrand.gtelBrandRed
                title = LOCALIZED("eid_invalid")
                description = LOCALIZED("eid_aa_invalid")
            } else if !rarCertVerification {
                color = ColorBrand.gtelBrandRed
                title = LOCALIZED("eid_invalid")
                description = LOCALIZED("eid_rar_not_verified")
            } else if !rarSignVerification {
                color = ColorBrand.gtelBrandRed
                title = LOCALIZED("eid_invalid")
                description = LOCALIZED("eid_rar_signature_not_verified")
            } else {
                color = ColorBrand.gtelBrandDarkGray
                title = LOCALIZED("eid_invalid")
                description = LOCALIZED("eid_no_data")
            }
        }
        
        _headerView.backgroundColor = color
        _headerTitleLbl.text = title
        _headerDescriptionLbl.text = description
    }
    
    private func _loadTableData() {
        
        var eid = ONBOARDDATAMANAGER.eid
        
        let hasChipAuth = eid?.isChipAuthenticationSupported == true
        let chipAuthSuccess = eid?.chipAuthenticationStatus == .success
        let passiveAuthSuccess = eid?.passiveAuthenticationStatus == .success
        let activeAuthSuccess = eid?.activeAuthenticationStatus == .success
        let rarCertVerification = eid?.eidVerified == true
        let rarSignVerification = eid?.eidSignatureVerified == true
        
        var eidImage = eid?.eidImage
        var personOptionalDetails = eid?.dg13
        
        var cellSectionData = [[String: Any]]()
        
        // --------------------------------------
        // A-SYSTEM REQUIREMENTS
        // --------------------------------------
        
        var aSystemRequirementsData = [[String: Any]]()
        
        aSystemRequirementsData.append([
            kCellIdentifierKey: kStatusTableCellIdentifier,
            kCellClassKey: StatusTableCell.self,
            kCellHeightKey: StatusTableCell.height,
            kCellTitleKey: LOCALIZED("eid_ca"),
            kCellColorCodeKey: chipAuthSuccess ? ColorBrand.gtelBrandGreen : ColorBrand.gtelBrandRed,
            kCellImageKey: chipAuthSuccess ? "icon_checkmark" : "icon_crossing"
        ])
        aSystemRequirementsData.append([
            kCellIdentifierKey: kStatusTableCellIdentifier,
            kCellClassKey: StatusTableCell.self,
            kCellHeightKey: StatusTableCell.height,
            kCellTitleKey: LOCALIZED("eid_pa"),
            kCellColorCodeKey: passiveAuthSuccess ? ColorBrand.gtelBrandGreen : ColorBrand.gtelBrandRed,
            kCellImageKey: passiveAuthSuccess ? "icon_checkmark" : "icon_crossing"
        ])
        aSystemRequirementsData.append([
            kCellIdentifierKey: kStatusTableCellIdentifier,
            kCellClassKey: StatusTableCell.self,
            kCellHeightKey: StatusTableCell.height,
            kCellTitleKey: LOCALIZED("eid_aa"),
            kCellColorCodeKey: activeAuthSuccess ? ColorBrand.gtelBrandGreen : ColorBrand.gtelBrandRed,
            kCellImageKey: activeAuthSuccess ? "icon_checkmark" : "icon_crossing"
        ])
        
        cellSectionData.append([kSectionTitleKey: LOCALIZED("eid_asystems"), kSectionDataKey: aSystemRequirementsData, kSectionCollapsedKey: false])
        
        // --------------------------------------
        // RAR VERIFICATION
        // --------------------------------------
        
        var rarVerificationData = [[String: Any]]()
        
        rarVerificationData.append([
            kCellIdentifierKey: kStatusTableCellIdentifier,
            kCellClassKey: StatusTableCell.self,
            kCellHeightKey: StatusTableCell.height,
            kCellTitleKey: LOCALIZED("rar_cert_verification"),
            kCellColorCodeKey: rarCertVerification ? ColorBrand.gtelBrandGreen : ColorBrand.gtelBrandRed,
            kCellImageKey: rarCertVerification ? "icon_checkmark" : "icon_crossing"
        ])
        rarVerificationData.append([
            kCellIdentifierKey: kStatusTableCellIdentifier,
            kCellClassKey: StatusTableCell.self,
            kCellHeightKey: StatusTableCell.height,
            kCellTitleKey: LOCALIZED("rar_sign_verification"),
            kCellColorCodeKey: rarSignVerification ? ColorBrand.gtelBrandGreen : ColorBrand.gtelBrandRed,
            kCellImageKey: rarSignVerification ? "icon_checkmark" : "icon_crossing"
        ])
        
        cellSectionData.append([kSectionTitleKey: LOCALIZED("eid_verification"), kSectionDataKey: rarVerificationData, kSectionCollapsedKey: false])
        
        // --------------------------------------
        // IMAGE DATA
        // --------------------------------------
        
        var imageData = [[String: Any]]()
        imageData.append([
            kCellIdentifierKey: kImageTableCellIdentifier,
            kCellClassKey: ImageTableCell.self,
            kCellHeightKey: ImageTableCell.height,
            kCellImageKey: eidImage ?? UIImage(named: "img_avatarholder") as Any
        ])
        
        cellSectionData.append([kSectionTitleKey: "", kSectionDataKey: imageData, kSectionCollapsedKey: false])
        
        
        // --------------------------------------
        // PERSONAL OPTIONAL DETAILS
        // --------------------------------------
        
        var personalData = [[String: Any]]()
        
        personalData.append([
            kCellIdentifierKey: kInfoTableCellIdentifier,
            kCellClassKey: InfoTableCell.self,
            kCellHeightKey: InfoTableCell.height,
            kCellTitleKey: LOCALIZED("label_name:"),
            kCellInformationKey: personOptionalDetails?.fullName ?? LOCALIZED("not_supported")
        ])
        
        personalData.append([
            kCellIdentifierKey: kInfoTableCellIdentifier,
            kCellClassKey: InfoTableCell.self,
            kCellHeightKey: InfoTableCell.height,
            kCellTitleKey: LOCALIZED("label_eid_number:"),
            kCellInformationKey: personOptionalDetails?.eidNumber ?? LOCALIZED("not_supported")
        ])
        
        personalData.append([
            kCellIdentifierKey: kInfoTableCellIdentifier,
            kCellClassKey: InfoTableCell.self,
            kCellHeightKey: InfoTableCell.height,
            kCellTitleKey: LOCALIZED("label_date_of_birth:"),
            kCellInformationKey: personOptionalDetails?.dateOfBirth ?? LOCALIZED("not_supported")
        ])
                
        personalData.append([
            kCellIdentifierKey: kInfoTableCellIdentifier,
            kCellClassKey: InfoTableCell.self,
            kCellHeightKey: InfoTableCell.height,
            kCellTitleKey: LOCALIZED("label_gender:"),
            kCellInformationKey: personOptionalDetails?.gender ?? LOCALIZED("not_supported")
        ])
        
        personalData.append([
            kCellIdentifierKey: kInfoTableCellIdentifier,
            kCellClassKey: InfoTableCell.self,
            kCellHeightKey: InfoTableCell.height,
            kCellTitleKey: LOCALIZED("label_nationality:"),
            kCellInformationKey: personOptionalDetails?.nationality ?? LOCALIZED("not_supported")
        ])
        
        personalData.append([
            kCellIdentifierKey: kInfoTableCellIdentifier,
            kCellClassKey: InfoTableCell.self,
            kCellHeightKey: InfoTableCell.height,
            kCellTitleKey: LOCALIZED("label_ethnicity:"),
            kCellInformationKey: personOptionalDetails?.ethnicity ?? LOCALIZED("not_supported")
        ])
        
        personalData.append([
            kCellIdentifierKey: kInfoTableCellIdentifier,
            kCellClassKey: InfoTableCell.self,
            kCellHeightKey: InfoTableCell.height,
            kCellTitleKey: LOCALIZED("label_religion:"),
            kCellInformationKey: personOptionalDetails?.religion ?? LOCALIZED("not_supported")
        ])
        
        personalData.append([
            kCellIdentifierKey: kInfoTableCellIdentifier,
            kCellClassKey: InfoTableCell.self,
            kCellHeightKey: InfoTableCell.height,
            kCellTitleKey: LOCALIZED("label_place_of_origin:"),
            kCellInformationKey: personOptionalDetails?.placeOfOrigin ?? LOCALIZED("not_supported")
        ])
        
        personalData.append([
            kCellIdentifierKey: kInfoTableCellIdentifier,
            kCellClassKey: InfoTableCell.self,
            kCellHeightKey: InfoTableCell.height,
            kCellTitleKey: LOCALIZED("label_place_of_residence:"),
            kCellInformationKey: personOptionalDetails?.placeOfResidence ?? LOCALIZED("not_supported")
        ])
        
        personalData.append([
            kCellIdentifierKey: kInfoTableCellIdentifier,
            kCellClassKey: InfoTableCell.self,
            kCellHeightKey: InfoTableCell.height,
            kCellTitleKey: LOCALIZED("label_identification:"),
            kCellInformationKey: personOptionalDetails?.personalIdentification ?? LOCALIZED("not_supported")
        ])
        
        personalData.append([
            kCellIdentifierKey: kInfoTableCellIdentifier,
            kCellClassKey: InfoTableCell.self,
            kCellHeightKey: InfoTableCell.height,
            kCellTitleKey: LOCALIZED("label_date_of_issue:"),
            kCellInformationKey: personOptionalDetails?.dateOfIssue ?? LOCALIZED("not_supported")
        ])
        
        personalData.append([
            kCellIdentifierKey: kInfoTableCellIdentifier,
            kCellClassKey: InfoTableCell.self,
            kCellHeightKey: InfoTableCell.height,
            kCellTitleKey: LOCALIZED("label_date_of_expiry:"),
            kCellInformationKey: personOptionalDetails?.dateOfExpiry ?? LOCALIZED("not_supported")
        ])
        
        personalData.append([
            kCellIdentifierKey: kInfoTableCellIdentifier,
            kCellClassKey: InfoTableCell.self,
            kCellHeightKey: InfoTableCell.height,
            kCellTitleKey: LOCALIZED("label_father_name:"),
            kCellInformationKey: personOptionalDetails?.fatherName ?? LOCALIZED("not_supported")
        ])
        
        personalData.append([
            kCellIdentifierKey: kInfoTableCellIdentifier,
            kCellClassKey: InfoTableCell.self,
            kCellHeightKey: InfoTableCell.height,
            kCellTitleKey: LOCALIZED("label_mother_name:"),
            kCellInformationKey: personOptionalDetails?.motherName ?? LOCALIZED("not_supported")
        ])
        
        personalData.append([
            kCellIdentifierKey: kInfoTableCellIdentifier,
            kCellClassKey: InfoTableCell.self,
            kCellHeightKey: InfoTableCell.height,
            kCellTitleKey: LOCALIZED("label_old_id:"),
            kCellInformationKey: personOptionalDetails?.oldEidNumber ?? LOCALIZED("not_supported")
        ])
        
        cellSectionData.append([kSectionTitleKey: LOCALIZED("section_personal"), kSectionDataKey: personalData, kSectionCollapsedKey: false])
                
        // --------------------------------------
        
        _tableView?.loadData(cellSectionData)
    }
    
    // --------------------------------------
    // MARK: <CustomTableViewDelegate>
    // --------------------------------------
    
    
    func setupCell(_ cell: UITableViewCell, cellDict: [String : Any]?, indexPath: IndexPath) {
        if cell is StatusTableCell {
            let title = cellDict?[kCellTitleKey] as? String
            let iconImageName = cellDict?[kCellImageKey] as? String
            let colorCode = cellDict?[kCellColorCodeKey] as? UIColor
            (cell as? StatusTableCell)?.setup(title: title, iconImageName: iconImageName, colorCode: colorCode)
        } else if cell is ImageTableCell {
            let image = cellDict?[kCellImageKey] as? UIImage
            (cell as? ImageTableCell)?.setup(image: image)
        } else if cell is InfoTableCell {
            let title = cellDict?[kCellTitleKey] as? String
            let info = cellDict?[kCellInformationKey] as? String
            (cell as? InfoTableCell)?.setup(title: title, info: info, colorCode: nil, showDisclosure: false)
        }
        
    }


}
