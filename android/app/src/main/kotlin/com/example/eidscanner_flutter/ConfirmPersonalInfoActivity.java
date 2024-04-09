package com.example.eidscanner_flutter;

import static android.view.View.GONE;

import android.content.Intent;
import android.graphics.Bitmap;
import android.os.Build;
import android.os.Bundle;
import android.view.View;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.ContextCompat;

import org.jmrtd.lds.SODFile;

import java.security.MessageDigest;
import java.security.cert.X509Certificate;
import java.text.SimpleDateFormat;

import javax.security.auth.x500.X500Principal;
import com.example.eidscanner_flutter.databinding.ActivityConfirmPersonalInfoBinding;
import vn.gtel.eidsdk.data.AdditionalDocumentDetails;
import vn.gtel.eidsdk.data.PersonAdditionalDetails;
import vn.gtel.eidsdk.data.PersonDetails;
import vn.gtel.eidsdk.data.PersonOptionalDetails;
import vn.gtel.eidsdk.jmrtd.FeatureStatus;
import vn.gtel.eidsdk.jmrtd.VerificationStatus;
import vn.gtel.eidsdk.utils.StringUtils;

public class ConfirmPersonalInfoActivity extends AppCompatActivity {

    private ActivityConfirmPersonalInfoBinding mBinding;
    private SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        mBinding = ActivityConfirmPersonalInfoBinding.inflate(getLayoutInflater());
        setContentView(mBinding.getRoot());
        loadData();
    }

    private void loadData() {

        // STATUS
        _displayStatusHeader();

        // A-SYSTEM REQUIREMENTS STATUS
        // Chip Authentication means that DG14 exist in chip and can be used to authenticate using MRZ, DG14 and SOD
        // Passive Authentication means all data in the chip is verified
        // Active Authentication means that the chip is genunity (not cloned or copied)
        _displayASystemRequirements();

        // RAR VERIFICATION STATUS
        _displayRarVerification();

        _displayContinueBtn();

        // CHIP - IMAGE
        mBinding.eidImage.setImageBitmap(OnboardDataManager.shared.eid.getFace());

        // CHIP - PERSON DETAILS
        PersonDetails personDetails = OnboardDataManager.shared.eid.getPersonDetails();
        if (personDetails != null) {
            mBinding.valuePdEid.setText(personDetails.getDocumentNumber());
            mBinding.valuePdDateofexpiry.setText(personDetails.getDateOfExpiry());
            mBinding.valuePdPlaceofissue.setText(personDetails.getIssuingState());
            mBinding.valuePdNationality.setText(personDetails.getNationality());
        }

        // CHIP - Person Optional Details
        PersonOptionalDetails personOptionalDetails = OnboardDataManager.shared.eid.getPersonOptionalDetails();
        if (personOptionalDetails != null) {
            mBinding.valuePodEid.setText(personOptionalDetails.getEidNumber());
            mBinding.valuePodFullname.setText(personOptionalDetails.getFullName());
            mBinding.valuePodDob.setText(personOptionalDetails.getDateOfBirth());
            mBinding.valuePodGender.setText(personOptionalDetails.getGender());
            mBinding.valuePodNationality.setText(personOptionalDetails.getNationality());
            mBinding.valuePodEthinicity.setText(personOptionalDetails.getEthnicity());
            mBinding.valuePodReligion.setText(personOptionalDetails.getReligion());
            mBinding.valuePodPlaceoforigin.setText(personOptionalDetails.getPlaceOfOrigin());
            mBinding.valuePodPlaceofresidence.setText(personOptionalDetails.getPlaceOfResidence());
            mBinding.valuePodPersonalidentification.setText(personOptionalDetails.getPersonalIdentification());
            mBinding.valuePodDateofissue.setText(personOptionalDetails.getDateOfIssue());
            mBinding.valuePodDateofexpiry.setText(personOptionalDetails.getDateOfExpiry());
            mBinding.valuePodFathername.setText(personOptionalDetails.getFatherName());
            mBinding.valuePodMothername.setText(personOptionalDetails.getMotherName());
            mBinding.valuePodOldeidnumber.setText(personOptionalDetails.getOldEidNumber());
            mBinding.valuePodUnkidnumber.setText(personOptionalDetails.getUnkIdNumber());
        }

        // CHIP - Person Additional Details
        PersonAdditionalDetails personAdditionalDetails = OnboardDataManager.shared.eid.getPersonAdditionalDetails();
        if (personAdditionalDetails != null) {
            mBinding.cardViewAdditionalPersonInformation.setVisibility(View.VISIBLE);
            if (personAdditionalDetails.getCustodyInformation() != null) {
                mBinding.valuePadCustody.setText(personAdditionalDetails.getCustodyInformation());
            }
            if (personAdditionalDetails.getFullDateOfBirth() != null) {
                mBinding.valuePadDob.setText(personAdditionalDetails.getFullDateOfBirth());
            }
            if (personAdditionalDetails.getOtherNames() != null) {
                mBinding.valuePadOthernames.setText(personAdditionalDetails.getOtherNames().toString());
            }
            if (personAdditionalDetails.getOtherValidTDNumbers() != null) {
                mBinding.valuePadOthertdnumbers.setText(personAdditionalDetails.getOtherValidTDNumbers().toString());
            }
            if (personAdditionalDetails.getPermanentAddress() != null) {
                mBinding.valuePadPermanentaddress.setText(personAdditionalDetails.getPermanentAddress().toString());
            }
            if (personAdditionalDetails.getPersonalNumber() != null) {
                mBinding.valuePdEid.setText(personAdditionalDetails.getPersonalNumber());
            }
            if (personAdditionalDetails.getPersonalSummary() != null) {
                mBinding.valuePadPersonalsummary.setText(personAdditionalDetails.getPersonalSummary());
            }
            if (personAdditionalDetails.getPlaceOfBirth() != null) {
                mBinding.valuePadPlaceofbirth.setText(personAdditionalDetails.getPlaceOfBirth().toString());
            }
            if (personAdditionalDetails.getProfession() != null) {
                mBinding.valuePadProfession.setText(personAdditionalDetails.getProfession());
            }
            if (personAdditionalDetails.getTelephone() != null) {
                mBinding.valuePadTelephone.setText(personAdditionalDetails.getTelephone());
            }
            if (personAdditionalDetails.getTitle() != null) {
                mBinding.valuePadTitle.setText(personAdditionalDetails.getTitle());
            }
        } else {
            mBinding.cardViewAdditionalPersonInformation.setVisibility(GONE);
        }

        // CHIP - Additional Document Details
        AdditionalDocumentDetails additionalDocumentDetails = OnboardDataManager.shared.eid.getAdditionalDocumentDetails();
        if (additionalDocumentDetails != null) {
            mBinding.cardViewAdditionalDocumentInformation.setVisibility(View.VISIBLE);
            if (additionalDocumentDetails.getDateAndTimeOfPersonalization() != null) {
                mBinding.valueDatePersonalization.setText(additionalDocumentDetails.getDateAndTimeOfPersonalization());
            }
            if (additionalDocumentDetails.getDateOfIssue() != null) {
                mBinding.valueDateIssue.setText(additionalDocumentDetails.getDateOfIssue());
            }
            if (additionalDocumentDetails.getEndorsementsAndObservations() != null) {
                mBinding.valueEndorsements.setText(additionalDocumentDetails.getEndorsementsAndObservations());
            }
            if (additionalDocumentDetails.getIssuingAuthority() != null) {
                mBinding.valueIssuingAuthority.setText(additionalDocumentDetails.getIssuingAuthority());
            }
            if (additionalDocumentDetails.getNamesOfOtherPersons() != null) {
                mBinding.valueNamesOtherPersons.setText(additionalDocumentDetails.getNamesOfOtherPersons().toString());
            }
            if (additionalDocumentDetails.getPersonalizationSystemSerialNumber() != null) {
                mBinding.valueSystemSerialNumber.setText(additionalDocumentDetails.getPersonalizationSystemSerialNumber());
            }
            if (additionalDocumentDetails.getTaxOrExitRequirements() != null) {
                mBinding.valueTaxExit.setText(additionalDocumentDetails.getTaxOrExitRequirements());
            }
        } else {
            mBinding.cardViewAdditionalDocumentInformation.setVisibility(GONE);
        }

        SODFile sodFile = OnboardDataManager.shared.eid.getSodFile();
        if (sodFile != null) {
            X500Principal countrySigningCertificate = sodFile.getIssuerX500Principal();
            String dnRFC2253 = countrySigningCertificate.getName(X500Principal.RFC2253);
            String dnCANONICAL = countrySigningCertificate.getName(X500Principal.CANONICAL);
            String dnRFC1779 = countrySigningCertificate.getName(X500Principal.RFC1779);

            String name = countrySigningCertificate.getName();
            X509Certificate docSigningCertificate = sodFile.getDocSigningCertificate();

            if (docSigningCertificate != null) {
                mBinding.valueDocumentSigningCertificateSerialNumber.setText(docSigningCertificate.getSerialNumber().toString());
                mBinding.valueDocumentSigningCertificatePublicKeyAlgorithm.setText(docSigningCertificate.getPublicKey().getAlgorithm());
                mBinding.valueDocumentSigningCertificateSignatureAlgorithm.setText(docSigningCertificate.getSigAlgName());

                try {
                    mBinding.valueDocumentSigningCertificateThumbprint.setText(StringUtils.INSTANCE.bytesToHex(
                        MessageDigest.getInstance("SHA-1").digest(
                            docSigningCertificate.getEncoded())).toUpperCase());
                } catch (Exception e) {
                    e.printStackTrace();
                }
                mBinding.valueDocumentSigningCertificateIssuer.setText(docSigningCertificate.getIssuerDN().getName());
                mBinding.valueDocumentSigningCertificateSubject.setText(docSigningCertificate.getSubjectDN().getName());
                mBinding.valueDocumentSigningCertificateValidFrom.setText(docSigningCertificate.getIssuerDN().getName());
                mBinding.valueDocumentSigningCertificateValidFrom.setText(dateFormat.format(docSigningCertificate.getNotBefore()));
                mBinding.valueDocumentSigningCertificateValidTo.setText(dateFormat.format(docSigningCertificate.getNotAfter()));

            } else {
                mBinding.cardViewDocumentSigningCertificate.setVisibility(GONE);
            }
        } else {
            mBinding.cardViewDocumentSigningCertificate.setVisibility(GONE);
        }
    }

    private void _displayStatusHeader() {
        FeatureStatus featureStatus = OnboardDataManager.shared.eid.getFeatureStatus();
        VerificationStatus verificationStatus = OnboardDataManager.shared.eid.getVerificationStatus();
        boolean chipAuthSuccess = verificationStatus.getCa() == VerificationStatus.Verdict.SUCCEEDED;
        boolean passiveAuthSuccess = verificationStatus.getHt() == VerificationStatus.Verdict.SUCCEEDED;
        boolean activeAuthSuccess = verificationStatus.getAa() == VerificationStatus.Verdict.SUCCEEDED;
        boolean rarCertVerification = verificationStatus.getDs() == VerificationStatus.Verdict.SUCCEEDED;
        boolean rarSignVerification = verificationStatus.getCs() == VerificationStatus.Verdict.SUCCEEDED;
        int color;
        String title;
        String message;

        if (featureStatus.hasCA() == FeatureStatus.Verdict.PRESENT) {
            if (chipAuthSuccess && passiveAuthSuccess && activeAuthSuccess && rarCertVerification && rarSignVerification) {
                color = getColor(R.color.success);
                title = getString(R.string.document_valid_eid);
                message = getString(R.string.document_content_success);
            } else if (!chipAuthSuccess) {
                color = getColor(R.color.failed);
                title = getString(R.string.document_invalid_eid);
                message = getString(R.string.document_chip_failure);
            } else if (!passiveAuthSuccess) {
                color = getColor(R.color.failed);
                title = getString(R.string.document_invalid_eid);
                message = getString(R.string.document_document_failure);
            } else if (!activeAuthSuccess) {
                color = getColor(R.color.failed);
                title = getString(R.string.document_invalid_eid);
                message = getString(R.string.document_document_failure);
            } else if (!rarCertVerification) {
                color = getColor(R.color.failed);
                title = getString(R.string.document_invalid_eid);
                message = getString(R.string.document_rar_cert_failure);
            } else if (!rarSignVerification) {
                color = getColor(R.color.failed);
                title = getString(R.string.document_invalid_eid);
                message = getString(R.string.document_rar_signature_failure);
            } else {
                color = getColor(R.color.unknown);
                title = getString(R.string.document_unknown_eid_title);
                message = getString(R.string.document_unknown_eid_message);
            }
        } else if (featureStatus.hasCA() == FeatureStatus.Verdict.NOT_PRESENT) {
            if (passiveAuthSuccess && rarCertVerification && rarCertVerification) {
                color = getColor(R.color.success);
                title = getString(R.string.document_valid_eid);
                message = getString(R.string.document_content_success);
            } else if (!passiveAuthSuccess) {
                color = getColor(R.color.failed);
                title = getString(R.string.document_invalid_eid);
                message = getString(R.string.document_document_failure);
            } else if (!activeAuthSuccess) {
                color = getColor(R.color.failed);
                title = getString(R.string.document_invalid_eid);
                message = getString(R.string.document_document_failure);
            } else if (!rarCertVerification) {
                color = getColor(R.color.failed);
                title = getString(R.string.document_invalid_eid);
                message = getString(R.string.document_rar_cert_failure);
            } else if (!rarSignVerification) {
                color = getColor(R.color.failed);
                title = getString(R.string.document_invalid_eid);
                message = getString(R.string.document_rar_signature_failure);
            } else {
                color = getColor(R.color.unknown);
                title = getString(R.string.document_unknown_eid_title);
                message = getString(R.string.document_unknown_eid_message);
            }
        } else {
            color = getColor(R.color.unknown);
            title = getString(R.string.document_unknown_eid_title);
            message = getString(R.string.document_unknown_eid_message);
        }

        mBinding.cardViewWarning.setCardBackgroundColor(color);
        mBinding.textWarningTitle.setText(title);
        mBinding.textWarningMessage.setText(message);

    }

    private void _displayASystemRequirements() {
        FeatureStatus featureStatus = OnboardDataManager.shared.eid.getFeatureStatus();
        VerificationStatus verificationStatus = OnboardDataManager.shared.eid.getVerificationStatus();
        mBinding.rowChipAuthentication.setVisibility(featureStatus.hasCA() == FeatureStatus.Verdict.PRESENT ? View.VISIBLE: GONE);
        if (verificationStatus.getCa() == VerificationStatus.Verdict.SUCCEEDED) {
            mBinding.valueChipAuthentication.setImageResource(R.drawable.ic_check_circle_outline);
            mBinding.valueChipAuthentication.setColorFilter(ContextCompat.getColor(this, R.color.success));
        } else {
            mBinding.valueChipAuthentication.setImageResource(R.drawable.ic_close_circle_outline);
            mBinding.valueChipAuthentication.setColorFilter(ContextCompat.getColor(this, R.color.failed));
        }
        if (verificationStatus.getHt() == VerificationStatus.Verdict.SUCCEEDED) {
            mBinding.valuePassiveAuthentication.setImageResource(R.drawable.ic_check_circle_outline);
            mBinding.valuePassiveAuthentication.setColorFilter(ContextCompat.getColor(this, R.color.success));
        } else {
            mBinding.valuePassiveAuthentication.setImageResource(R.drawable.ic_close_circle_outline);
            mBinding.valuePassiveAuthentication.setColorFilter(ContextCompat.getColor(this, R.color.failed));
        }
        if (verificationStatus.getAa() == VerificationStatus.Verdict.SUCCEEDED) {
            mBinding.valueActiveAuthentication.setImageResource(R.drawable.ic_check_circle_outline);
            mBinding.valueActiveAuthentication.setColorFilter(ContextCompat.getColor(this, R.color.success));
        } else {
            mBinding.valueActiveAuthentication.setImageResource(R.drawable.ic_close_circle_outline);
            mBinding.valueActiveAuthentication.setColorFilter(ContextCompat.getColor(this, R.color.failed));
        }
    }

    private void _displayRarVerification() {
        VerificationStatus verificationStatus = OnboardDataManager.shared.eid.getVerificationStatus();
        if (verificationStatus.getDs() == VerificationStatus.Verdict.SUCCEEDED) {
            mBinding.valueRarCertVerification.setImageResource(R.drawable.ic_check_circle_outline);
            mBinding.valueRarCertVerification.setColorFilter(ContextCompat.getColor(this, R.color.success));
        } else {
            mBinding.valueRarCertVerification.setImageResource(R.drawable.ic_close_circle_outline);
            mBinding.valueRarCertVerification.setColorFilter(ContextCompat.getColor(this, R.color.failed));
        }
        if (verificationStatus.getCs() == VerificationStatus.Verdict.SUCCEEDED) {
            mBinding.valueRarSignatureVerification.setImageResource(R.drawable.ic_check_circle_outline);
            mBinding.valueRarSignatureVerification.setColorFilter(ContextCompat.getColor(this, R.color.success));
        } else {
            mBinding.valueRarSignatureVerification.setImageResource(R.drawable.ic_close_circle_outline);
            mBinding.valueRarSignatureVerification.setColorFilter(ContextCompat.getColor(this, R.color.failed));
        }

    }

    private void _displayContinueBtn() {
        mBinding.buttonContinue.setOnClickListener(v -> {
//            Intent intent = new Intent();
            Intent intent = new Intent(this, MyFlutterActivity.class);
            assert OnboardDataManager.shared.eid.getPersonOptionalDetails() != null;
            intent.putExtra("fullName", OnboardDataManager.shared.eid.getPersonOptionalDetails().getFullName());
            intent.putExtra("dateOfBirth", OnboardDataManager.shared.eid.getPersonOptionalDetails().getDateOfBirth());
            intent.putExtra("personalId", OnboardDataManager.shared.eid.getPersonOptionalDetails().getPersonalIdentification());
            intent.putExtra("fatherName", OnboardDataManager.shared.eid.getPersonOptionalDetails().getFatherName());
            intent.putExtra("motherName", OnboardDataManager.shared.eid.getPersonOptionalDetails().getMotherName());
            startActivity(intent);
//            setResult(RESULT_OK, intent);
//            finish();
        });
    }
}
