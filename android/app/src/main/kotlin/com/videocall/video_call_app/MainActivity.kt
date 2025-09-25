package com.videocall.video_call_app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    
    private var chimeSDKPlugin: ChimeSDKPlugin? = null
    
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        // Register the Chime SDK plugin
        chimeSDKPlugin = ChimeSDKPlugin(this, flutterEngine)
    }
    
    override fun onDestroy() {
        super.onDestroy()
        chimeSDKPlugin?.dispose()
    }
}
