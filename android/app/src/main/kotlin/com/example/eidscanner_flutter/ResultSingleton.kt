package com.example.eidscanner_flutter

import io.flutter.plugin.common.MethodChannel

class ResultSingleton private constructor() {
    companion object {
        private var result: MethodChannel.Result? = null

        var instance: MethodChannel.Result?
            get() {
                return result
            }
            set(value) {
                this.result = value
            }
    }
}