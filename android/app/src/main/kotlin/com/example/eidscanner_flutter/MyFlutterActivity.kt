package com.example.eidscanner_flutter

import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MyFlutterActivity : FlutterActivity() {
    private val FLUTTER_CHANNEL = "read_mrz"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            FLUTTER_CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "mrz") {
                Log.d("YourTag", "vào configureFlutterEngine222")
                val fullName = intent.getStringExtra("fullName").toString()
                val dateOfBirth = intent.getStringExtra("dateOfBirth").toString()
                val personalId = intent.getStringExtra("personalId").toString()
                val fatherName = intent.getStringExtra("fatherName").toString()
                val motherName = intent.getStringExtra("motherName").toString()

                result.success("SUCCESS")
                MethodChannel(
                    flutterEngine.dartExecutor.binaryMessenger,
                    FLUTTER_CHANNEL
                ).invokeMethod("onSuccess", fullName)
                MethodChannel(
                    flutterEngine.dartExecutor.binaryMessenger,
                    FLUTTER_CHANNEL
                ).invokeMethod("onSuccess", dateOfBirth)
                MethodChannel(
                    flutterEngine.dartExecutor.binaryMessenger,
                    FLUTTER_CHANNEL
                ).invokeMethod("onSuccess", personalId)
                MethodChannel(
                    flutterEngine.dartExecutor.binaryMessenger,
                    FLUTTER_CHANNEL
                ).invokeMethod("onSuccess", fatherName)
                MethodChannel(
                    flutterEngine.dartExecutor.binaryMessenger,
                    FLUTTER_CHANNEL
                ).invokeMethod("onSuccess", motherName)
            }
        }
    }
}