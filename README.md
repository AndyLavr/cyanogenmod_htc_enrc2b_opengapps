
The fork repository of the Open GApps Project for CyanogenMod HTC One X+ device (enrc2b)



Getting the latest Open GApps for CyanogenMod HTC One X+ device (enrc2b)
---------------

The latest version of pre-built Open GApps can be found at [Download](https://drive.google.com/open?id=0B5ngHZIeNdyTTVlsZkk2Ym9GTGc/ "open_gapps-5.1-enrc2b-***-***.zip")


Build your own Open GApps for CyanogenMod HTC One X+ device (enrc2b)
---------------
If you want to build your own version of Open GApps for CyanogenMod HTC One X+ device (enrc2b), you'll need to get the git sources:

To initialize your local repository using the Open GApps for CyanogenMod HTC One X+ device (enrc2b) source tree, use a command like:
```
git clone git@github.com:AndyLavr/cyanogenmod_htc_enrc2b_opengapps.git
```
Then sync the submodules to get the original APK sources as provided by Google.
You can also use this command to update at a later moment the sources to the most recent version:
```
./download_sources.sh [--shallow] [arch]
```
* ```--shallow``` will order to fetch only the latest snapshot of the APKs (reduces space used and amount of data to be retrieved by git, by not fetching the APKs' history)
* ```arch``` can be one of the following "arm" to fetch only data required for specified architecture (note that fallback architectures will be be fetched too)

To build Open GApps for all platforms and all android releases:
```
make
```
To build Open GApps for a specific android release on a specific platform,
define both the platform and the API level of that release, seperated by a dash and optionally add the variant with another dash.
Two (most widely used) examples:
```
make arm-22
```
or
```
make arm-22-stock
```
To add updated source APKs to the sources archive (you can add more than one at once):
```
./add_sourceapp.sh [/path/to/the/files/you/want/to/add.apk]* [beta] [/apps/that/should/be/marked/as/beta.apk...]*
```
For contributors, updated sources can be uploaded by using this command:
```
./upload_sources.sh
```
If you want an overview of the locally available sources:
```
./report_sources.sh
