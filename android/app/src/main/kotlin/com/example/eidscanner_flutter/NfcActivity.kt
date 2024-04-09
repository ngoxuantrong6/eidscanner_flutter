package com.example.eidscanner_flutter

import android.app.PendingIntent
import android.content.Intent
import android.nfc.NfcAdapter
import android.os.Build
import android.os.Bundle
import android.provider.Settings
import android.util.Log
import android.widget.Toast
import com.example.eidscanner_flutter.fragments.NfcFragment
import com.google.gson.Gson
import com.google.gson.JsonNull
import org.jmrtd.lds.icao.MRZInfo
import vn.gtel.eidsdk.data.Eid
import vn.gtel.eidsdk.facade.EidFacade
import vn.gtel.eidsdk.jmrtd.VerificationStatus
import vn.gtel.eidsdk.network.EidService.EIDSERVICE
import vn.gtel.eidsdk.network.models.EidVerifyModel
import vn.gtel.eidsdk.network.models.ResponseModel
import vn.gtel.eidsdk.network.models.RestCallback
import vn.gtel.eidsdk.utils.StringUtils

class NfcActivity : androidx.fragment.app.FragmentActivity(), NfcFragment.NfcFragmentListener {

    private var mrzInfo: MRZInfo? = null
    private var nfcAdapter: NfcAdapter? = null
    private var pendingIntent: PendingIntent? = null
    private var didScanNfc = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_nfc)
        val intent = intent
        if (intent.hasExtra(IntentData.KEY_MRZ_INFO)) {
            mrzInfo = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                intent.getSerializableExtra(IntentData.KEY_MRZ_INFO, MRZInfo::class.java)
            } else {
                intent.getSerializableExtra(IntentData.KEY_MRZ_INFO) as MRZInfo
            }
        } else {
            onBackPressed()
        }

        nfcAdapter = NfcAdapter.getDefaultAdapter(this)
        if (nfcAdapter == null) {
            Toast.makeText(this, getString(R.string.warning_no_nfc), Toast.LENGTH_SHORT).show()
            finish()
            return
        }

        pendingIntent = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            PendingIntent.getActivity(this, 0, Intent(this, javaClass).addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP), PendingIntent.FLAG_MUTABLE)
        } else{
            PendingIntent.getActivity(this, 0, Intent(this, javaClass).addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP), PendingIntent.FLAG_IMMUTABLE)
        }
        if (null == savedInstanceState) {
            supportFragmentManager.beginTransaction()
                .replace(R.id.container, NfcFragment.newInstance(mrzInfo!!), TAG_NFC)
                .commit()
        }
    }

    public override fun onResume() {
        super.onResume()
    }

    public override fun onPause() {
        super.onPause()
    }

    override fun onStop() {
        super.onStop()
        didScanNfc = false
    }

    public override fun onNewIntent(intent: Intent) {
        if (NfcAdapter.ACTION_TAG_DISCOVERED == intent.action || NfcAdapter.ACTION_TECH_DISCOVERED == intent.action) {
            // drop NFC events
            handleIntent(intent)
        }else{
            super.onNewIntent(intent)
        }
    }

    protected fun handleIntent(intent: Intent) {
        val fragmentByTag = supportFragmentManager.findFragmentByTag(TAG_NFC)
        if (fragmentByTag is NfcFragment) {
            fragmentByTag.handleNfcTag(intent)
        }
    }

    override fun onEnableNfc() {
        if (nfcAdapter != null) {
            if (!nfcAdapter!!.isEnabled)
                showWirelessSettings()
            nfcAdapter!!.enableForegroundDispatch(this, pendingIntent, null, null)
        }
    }

    override fun onDisableNfc() {
        val nfcAdapter = NfcAdapter.getDefaultAdapter(this)
        nfcAdapter.disableForegroundDispatch(this)
    }

    override fun onEidRead(eid: Eid?) {
        if (!didScanNfc) {
            didScanNfc = true
            val eidNumber = eid?.personOptionalDetails?.eidNumber
            val dsCert = StringUtils.encodeToBase64String(eid?.sodFile?.docSigningCertificate)
            Log.d("YourTag", "dsCert $dsCert")
            val province = StringUtils.getProvince(eid?.personOptionalDetails?.placeOfOrigin)
            var code = BuildConfig.CUSTOMER_CODE;
//            var path = ""
//            EIDSERVICE.verifyEid(path, eidNumber, dsCert, province, code, object: RestCallback<ResponseModel<EidVerifyModel>>(this) {
//                override fun Success(model: ResponseModel<EidVerifyModel>?) {
//                    TODO("Not yet implemented")
//                }
//                override fun Error(error: String?) {
//                    TODO("Not yet implemented")
//                }
//            });
            EIDSERVICE.verifyEid(eidNumber, dsCert, province, code, object : RestCallback<ResponseModel<EidVerifyModel>>(this) {
                override fun Success(model: ResponseModel<EidVerifyModel>?) {
                    if (model?.data?.IsValidIdCard == true) {
                        eid?.verificationStatus?.setDS(VerificationStatus.Verdict.SUCCEEDED, "DS_CERT Invalid")
                    } else {
                        eid?.verificationStatus?.setDS(VerificationStatus.Verdict.FAILED, "DS_CERT Valid")
                    }
                    val respondsMsg = Gson().toJson(model?.data?.responds ?: JsonNull.INSTANCE)
                    val signature = model?.data?.signature ?: ""
                    if (!EidFacade.verifyRsaSignatureDefault(baseContext, respondsMsg, signature)) {
                        eid?.verificationStatus?.setCS(VerificationStatus.Verdict.FAILED, "SIGNATURE Invalid", null)
                    } else {
                        eid?.verificationStatus?.setCS(VerificationStatus.Verdict.SUCCEEDED, "SIGNATURE Valid", null)
                    }
                    OnboardDataManager.shared.eid = eid;
                    val intent = Intent(this@NfcActivity, ConfirmPersonalInfoActivity::class.java)
                    startActivity(intent)
                }

                override fun Error(error: String?) {
                    Toast.makeText(this@NfcActivity, error, Toast.LENGTH_LONG).show()
                    didScanNfc = false
                }
            })
        }

    }


    override fun onCardException(cardException: Exception?) {
        Toast.makeText(this, cardException.toString(), Toast.LENGTH_SHORT).show();
        onBackPressed();
    }

    private fun showWirelessSettings() {
        Toast.makeText(this, getString(R.string.warning_enable_nfc), Toast.LENGTH_SHORT).show()
        val intent = Intent(Settings.ACTION_WIRELESS_SETTINGS)
        startActivity(intent)
    }

    companion object {

        private val TAG = NfcActivity::class.java.simpleName


        private val TAG_NFC = "TAG_NFC"
        private val TAG_PASSPORT_DETAILS = "TAG_PASSPORT_DETAILS"
        private val TAG_PASSPORT_PICTURE = "TAG_PASSPORT_PICTURE"
    }
}
