package com.example.eidscanner_flutter

import android.app.Activity
import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.util.Log
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import androidx.activity.result.registerForActivityResult
import androidx.appcompat.app.AppCompatActivity
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.jmrtd.lds.icao.MRZInfo


class MainActivity: FlutterActivity() {
    private val FLUTTER_CHANNEL = "read_mrz"
    private val RESULT_CODE = -1;
//    private val componentActivity: ComponentActivity = ComponentActivity()
//    private val appCompatActivityDelegate = AppCompatActivityDelegate()
//    private lateinit var resultLauncher: ActivityResultLauncher<Intent>


//    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
//        Log.d("YourTag", "Result1111:")
//        var data = data
//        if (data == null) {
//            data = Intent()
//        }
//        when (requestCode) {
//            REQUEST_MRZ -> {
//                when (resultCode) {
//                    Activity.RESULT_OK -> {
//                        onEidRead(data.getSerializableExtra(IntentData.KEY_MRZ_INFO) as MRZInfo)
//                    }
//                    Activity.RESULT_CANCELED -> {
//                        val fragmentByTag = supportFragmentManager.findFragmentByTag(
//                            TAG_SELECTION_FRAGMENT
//                        )
//                        if (fragmentByTag is SelectionFragment) {
//                            fragmentByTag.selectManualToggle()
//                        }
//                    }
//                    else -> {
//                        val fragmentByTag = supportFragmentManager.findFragmentByTag(
//                            TAG_SELECTION_FRAGMENT
//                        )
//                        if (fragmentByTag is SelectionFragment) {
//                            fragmentByTag.selectManualToggle()
//                        }
//                    }
//                }
//            }
//            REQUEST_NFC -> {
//                val fragmentByTag = supportFragmentManager.findFragmentByTag(TAG_SELECTION_FRAGMENT)
//                if (fragmentByTag is SelectionFragment) {
//                    fragmentByTag.selectManualToggle()
//                }
//            }
//        }
//        super.onActivityResult(requestCode, resultCode, data)
//    }


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            FLUTTER_CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "mrz") {
                Log.d("YourTag", "vào configureFlutterEngine")
                val intent = Intent(this, CameraActivity::class.java)
//                startActivityForResult(intent, RESULT_CODE)
//                result.success("SUCCESS")
                startActivityForResult(intent, REQUEST_MRZ)
//                Log.d("YourTag", "chưa qua launch ${appCompatActivityDelegate.resultLauncher}")
//                appCompatActivityDelegate.resultLauncher.launch(intent)
//                Log.d("YourTag", "qua launch")
                result.success("SUCCESS")
            }
        }
    }

//    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent) {
//        super.onActivityResult(requestCode, resultCode, data)
//        Log.d("YourTag", "vào onActivityResultttttttttttttt")
//        if (requestCode == RESULT_CODE) {
//            if (resultCode == RESULT_OK) {
//                val methodChannel = MethodChannel(
//                    flutterEngine!!.dartExecutor.binaryMessenger,
//                    FLUTTER_CHANNEL
//                )
//                val result = data.getStringExtra(IntentData.KEY_MRZ_INFO)
//                Log.d("YourTag", "Rescult: $result")
//                methodChannel.invokeMethod("onSuccess", result)
//            }
//        }
//    }

    companion object {

//        private val TAG = SelectionActivity::class.java.simpleName
        private val REQUEST_MRZ = 12
        private val REQUEST_NFC = 11

        private val TAG_SELECTION_FRAGMENT = "TAG_SELECTION_FRAGMENT"
    }



}

//class AppCompatActivityDelegate: AppCompatActivity() {
//    // Thực hiện các tác vụ cần thiết cho AppCompatActivity ở đây
//    val resultLauncher = registerForActivityResult(ActivityResultContracts.StartActivityForResult()) { result ->
//        Log.d("YourTag", "vào registerForActivityResult")
//        if (result.resultCode == Activity.RESULT_OK) {
//            val data: Intent? = result.data
//            val result = data?.getStringExtra(IntentData.KEY_MRZ_INFO)
//            Log.d("YourTag", "Result: $result")
//        }
//    }
//
//    // Thêm các phương thức khác của AppCompatActivity nếu cần
//}
