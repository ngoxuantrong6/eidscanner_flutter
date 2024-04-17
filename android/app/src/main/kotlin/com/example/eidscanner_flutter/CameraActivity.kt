package com.example.eidscanner_flutter

import android.content.Intent
import android.os.Bundle
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import org.jmrtd.lds.icao.MRZInfo
import vn.gtel.cdsdemoappscan.fragments.CameraMLKitFragment
import vn.gtel.eidsdk.facade.CameraOcrCallback
import vn.gtel.eidsdk.facade.EidFacade
import vn.gtel.eidsdk.network.EidService.EIDSERVICE

class CameraActivity : AppCompatActivity(), CameraOcrCallback {
    private var didReadMrz = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_camera)
//        EIDSERVICE.init(BuildConfig.API_KEY, BuildConfig.API_BASE_URL)
        EIDSERVICE.init("tZ3hsBK2yjtTb7UKQNjPNQXMJbHydMho", "https://api.gwork.vn")
        EidFacade.registerOcrListener(this)
        supportFragmentManager.beginTransaction()
            .replace(R.id.container, CameraMLKitFragment())
            .commit()
    }

    override fun onBackPressed() {
        super.onBackPressed()
        setResult(RESULT_CANCELED)
        finish()
    }

    override fun onStop() {
        super.onStop()
        didReadMrz = false
    }

    override fun onDestroy() {
        super.onDestroy()
    }

    override fun onEidRead(mrzInfo: MRZInfo) {
//        val intent = Intent()
//        intent.putExtra(IntentData.KEY_MRZ_INFO, mrzInfo)
//        setResult(RESULT_OK, intent)
        if (!didReadMrz) {
            val intent = Intent(this, NfcActivity::class.java)
//            val intent = Intent()
            intent.putExtra(IntentData.KEY_MRZ_INFO, mrzInfo)
            startActivity(intent)
            setResult(RESULT_OK, intent)
            didReadMrz = true
//            finish()
        }
    }

    override fun onError(e: Exception?) {
    }

    companion object {

        private val TAG = MainActivity::class.java.simpleName
    }

}