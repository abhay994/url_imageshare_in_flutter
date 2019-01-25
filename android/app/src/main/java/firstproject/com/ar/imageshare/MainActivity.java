package firstproject.com.ar.imageshare;


import android.graphics.BitmapFactory;
import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import android.app.WallpaperManager;
import android.graphics.Bitmap;
import android.view.Display;
import java.io.IOException;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;



public class MainActivity extends FlutterActivity {

    private static final String CHANNEL = "wallpaper";
  String file;

    @Override
  protected void onCreate(Bundle savedInstanceState) {

    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);


        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                new MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, Result result) {
                        // TODO
                        if (call.method.equals("getWallpaper")) {
                            file = call.argument("text");
                            int batteryLevel = RandomFunction(file);
                            if (batteryLevel != -1) {
                                result.success(batteryLevel);
                            } else {
                                result.error("UNAVAILABLE", "setwallpaper", null);
                            }
                        } else {
                            result.notImplemented();
                        }
                        }
                });




  }

    int RandomFunction(String f){
        Display metrics = getWindowManager().getDefaultDisplay();
        int height = metrics.getHeight();
        int width = metrics.getWidth();
        try {
            WallpaperManager myWallpaperManager
                    = WallpaperManager.getInstance(getApplicationContext());
            Bitmap mybitmap = BitmapFactory.decodeFile(f);
            Bitmap bitmap = Bitmap.createScaledBitmap(mybitmap, width, height, true);
            myWallpaperManager.setBitmap(bitmap);
            return 1;
            } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            return -1;
            }
    }
}
