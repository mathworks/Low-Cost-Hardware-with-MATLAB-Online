
# <span style="color:rgb(213,80,0)">Project\-Based Learning with Low\-Cost Hardware using MATLAB Online</span>

# Overview

This workshop serves as a resource for educators seeking to enhance experiential learning with MATLAB**®** and Simulink**®** in online, hybrid, and remote environments. By leveraging MATLAB Online in conjunction with affordable hardware, educators can offer students engaging projects and activities without the need for costly lab equipment, extensive software installations, or complex desktop configurations. The repository includes guidance on using MATLAB Online with low\-cost hardware platforms, such as Arduino, and other devices via MATLAB Mobile and ThingSpeak, to facilitate project\-based learning. It also provides instructions on connecting hardware to MATLAB Online and designing effective project\-based learning activities for remote settings.

## Technical Requirements

It is recommended that Google Chrome™ be used for this workshop.

## Material Requirements

If you would like to follow along with all of the workshop activities, a basic Arduino kit is required. The below links are some options that are available online.


[<u>ELEGOO Super Starter Kit</u>](https://www.amazon.com/ELEGOO-Project-Tutorial-Controller-Projects/dp/B01D8KOZF4/ref=asc_df_B01D8KOZF4/?tag=hyprod-20&linkCode=df0&hvadid=693369603351&hvpos=&hvnetw=g&hvrand=12451674447145320957&hvpone=&hvptwo=&hvqmt=&hvdev=c&hvdvcmdl=&hvlocint=&hvlocphy=9001873&hvtargid=pla-406302474425&psc=1&mcid=80a5b47d61dc377992c3c25d65d73272)


[<u>Arduino Starter Kit</u>](https://store.arduino.cc/products/arduino-starter-kit-multi-language?srsltid=AfmBOoo8ChxKlB7y5MEod3Eek5t9001C-l_8_YQT77jxbHOjEc_IE9ac)


This workshop will be recorded and available following the EXPO, so even if you do not have the materials or time required to perform every activity, you can consult this repository and the recording at a later time.

# Getting Started
### 1. Create a MathWorks Account

Click on the link below to create a MathWorks account if you do not already have one:


[<u>https://www.mathworks.com/mwaccount/account/create</u>](https://www.mathworks.com/mwaccount/account/create)


Troubleshooting:


[<u>https://www.mathworks.com/matlabcentral/answers/361072\-how\-do\-i\-create\-a\-mathworks\-account</u>](https://www.mathworks.com/matlabcentral/answers/361072-how-do-i-create-a-mathworks-account)

### 2. Download MATLAB Mobile

Scan the QR code below to download the app on your smart device:

<p style="text-align:left">
   <img src="README_media/image_0.png" width="324" alt="image_0.png">
</p>


### 3. Install MATLAB Connector

Follow the instructions at the link below to install MATLAB Connector, which allows you to interface your Arduino hardware with MATLAB Online:

   https://www.mathworks.com/products/matlab-drive.html?s_tid=AO_MLConnector#matlab-drive-connector
   

Next, run the MATLAB Connector Installer from the command line with these parameters (*note that file names may vary*):
- Windows
```console
tar -xf mathworksservicehost_2024.8.0.2_win64_installer.exe
bin\win64\InstallMathWorksServiceHost.exe -feature hwservice
```
- Mac
```console
/Volumes/mathworksservicehost_xxxx.x.x.x_maci64_installer/InstallMathWorksServiceHost.app/Contents/MacOS/InstallMathWorksServiceHost -feature hwservice
```
- Linux 
```console
sh ~/Downloads/mathworksservicehost_xxxx.x.x.x_glnxa64_installer.bin -feature hwservice
```


### 4. Configure MATLAB Connector for Arduino Hardware

*Unlike MATLAB Desktop, the MATLAB and Simulink Support Packages for Arduino are automatically installed on MATLAB Online.*

-  After you have successfully installed MATLAB Connector, plug in your Arduino board.
- Log in to MATLAB Online and run the following command in the Command Window:
```Matlab
arduinosetup
```
- Follow the instructions, accepting the default libraries.
- When complete, run the following command and ensure the status of your board is *"Ready to connect"*:
```Matlab
arduinolist
```


### 5. Clone this Repository to your MATLAB Drive

Click the button below to clone the repository for this workshop to your MATLAB Drive to use in MATLAB Online.


[<img src="README_media/image_1.png" width="136" alt="image_1.png">](https://matlab.mathworks.com/open/github/v1?repo=mathworks/Low-Cost-Hardware-with-MATLAB-Online&project=low-cost-hw-mlo.prj&file=README.mlx) 

# Activities
### Demo: Advanced Arduino Control
<p style="text-align:left">
   <img src="README_media/image_2.png" width="576" alt="image_2.png">
</p>


[<u>https://www.mathworks.com/help/matlab/supportpkg/iot\-automatic\-cooling\-fan\-arduino\-example.html</u>](https://www.mathworks.com/help/matlab/supportpkg/iot-automatic-cooling-fan-arduino-example.html)

### Demo: [Collecting Smartphone Sensor Data](https://matlab.mathworks.com/open/github/v1?repo=mathworks/Low-Cost-Hardware-with-MATLAB-Online&project=low-cost-hw-mlo.prj&file=PlotLoggedAccelerationDatafromMATLABMobile.mlx)
<p style="text-align:left">
   <img src="README_media/image_3.png" width="569" alt="image_3.png">
</p>


[https://www.mathworks.com/help/matlabmobile/ug/sensor\-data\-collection\-with\-matlab\-mobile.html](https://www.mathworks.com/help/matlabmobile/ug/sensor-data-collection-with-matlab-mobile.html)

### Activity 1: [Taking a Selfie Using a Webcam](https://matlab.mathworks.com/open/github/v1?repo=mathworks/Low-Cost-Hardware-with-MATLAB-Online&project=low-cost-hw-mlo.prj&file=TakingaSelfieUsingaWebcam.mlx)
<p style="text-align:left">
   <img src="README_media/image_4.png" width="446" alt="image_4.png">
</p>


### Activity 2: [Plot Traffic Data Using ThingSpeak](https://matlab.mathworks.com/open/github/v1?repo=mathworks/Low-Cost-Hardware-with-MATLAB-Online&project=low-cost-hw-mlo.prj&file=UseAreaPlotToCompareTrafficDataSetsTSExample.mlx)
<p style="text-align:left">
   <img src="README_media/image_5.png" width="481" alt="image_5.png">
</p>


### Activity 3: [Controlling an LED using MATLAB Online and Arduino](https://matlab.mathworks.com/open/github/v1?repo=mathworks/Low-Cost-Hardware-with-MATLAB-Online&project=low-cost-hw-mlo.prj&file=ArduinoGettingStartedExample.mlx)
<p style="text-align:left">
   <img src="README_media/image_6.png" width="528" alt="image_6.png">
</p>


# License

The license for this module is available in the [LICENSE.txt](https://github.com/mathworks/Low-Cost-Hardware-with-MATLAB-Online/blob/main/LICENSE.txt)


## Products

MATLAB®, Image Processing Toolbox

# Educator Resources

[<u>https://www.mathworks.com/academia.html</u>](https://www.mathworks.com/academia.html)

-  Access tools and resources for delivering great MATLAB based courses, including lectures, project\-based learning, and assessments 
-  Browse courseware and examples from MathWorks and educators 

[<u>https://www.mathworks.com/hardware\-support/arduino.html</u>](https://www.mathworks.com/hardware-support/arduino.html)

-  Get support for MATLAB, Simulink, and hardware support packages 
-  Contact your Customer Success team for assistance with curriculum 

[<u>https://github.com/mathworks</u>](https://github.com/mathworks) [<u>https://github.com/MathWorks\-Teaching\-Resources</u>](https://github.com/MathWorks-Teaching-Resources)

# Additional Resources
### MATLAB Mobile

[<u>https://www.mathworks.com/help/matlabmobile/matlab\-mobile\-fundamentals.html</u>](https://www.mathworks.com/help/matlabmobile/matlab-mobile-fundamentals.html)

### Webcams

https://www.mathworks.com/help/matlab/cameras-and-mobile-sensing.html

### ThingSpeak

https://www.mathworks.com/help/thingspeak/

### Arduino

[<u>https://www.mathworks.com/help/matlab/examples.html?category=arduinoio&exampleproduct=all&newonly=&s\_tid=CRUX\_lftnav</u>](https://www.mathworks.com/help/matlab/examples.html?category=arduinoio&exampleproduct=all&newonly=&s_tid=CRUX_lftnav)

### Raspberry Pi

[<u>https://www.mathworks.com/help/matlab/supportpkg/connect\-to\-raspberry\-pi\-hardware\-board\-in\-matlab\-online.html</u>](https://www.mathworks.com/help/matlab/supportpkg/connect-to-raspberry-pi-hardware-board-in-matlab-online.html) 

[<u>https://www.mathworks.com/help/matlab/examples.html?category=raspberrypiio&exampleproduct=all&newonly=&s\_tid=CRUX\_lftnav</u>](https://www.mathworks.com/help/matlab/examples.html?category=raspberrypiio&exampleproduct=all&newonly=&s_tid=CRUX_lftnav)


 *©* Copyright 2024 The MathWorks™, Inc

