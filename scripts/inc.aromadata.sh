#This file is part of The Open GApps script of @mfonville.
#
#    The Open GApps scripts are free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    These scripts are distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
makearomaconfig(){
tee "$build/META-INF/com/google/android/aroma-config" > /dev/null <<'EOFILE'
#This file is part of The Open GApps script of @raulx222.
#
#    The Open GApps scripts are free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    These scripts are distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#

# ROM Info
ini_set("rom_name", "OpenGApps");
ini_set("rom_author", "enrc2b");
ini_set("rom_date", zipprop("g.prop", "ro.addon.open_version"));
ini_set("text_quit", "Выход");
ini_set("text_next", "Далее");
ini_set("text_back", "Назад");
ini_set("text_savelog", "Сохранить Лог");

##############################################
# UI/Font/Splash
##############################################
ini_set("force_colorspace", "rgba");
splash(
    3000,
    "open"
);
fontresload("0", "ttf/Roboto-Regular.ttf", "12");
fontresload("1", "ttf/Roboto-Regular.ttf", "14");
theme("material_green");

##############################################
# Welcome
##############################################
viewbox(
  "Добро пожаловать",

  "Этим установщиком OpenGApps Вы можете выбрать какие GApps установить!\n\n\n\n" +
  "Информация о пакетах\n\n" +

    "   Имя\t\t: <b><#scrollbar>" + ini_get("rom_name") + "</#></b>\n"+
    "   Сборка\t\t: <b><#scrollbar>" + ini_get("rom_author") + "</#></b>\n"+
    "   Поддерживаемые устройства: <b><#scrollbar>HTC One X+</#></b>\n"+
    "   Версии Android: <b><#scrollbar>"+zipprop("g.prop", "ro.addon.platform")+"</#></b>\n"+
    "   Дата сборки\t: <b><#scrollbar>" + ini_get("rom_date") + " </#></b>\n\n"+
    "<b>Сборка для устройств HTC One X+!            <#scrollbar>(AndyLavr: andy.lavr@gmail.com)</#></b>"+"\n\n\n\n",

  "@welcome"
);

##############################################
# MENU
##############################################
menubox(
    "OpenGApps HOX+",
    "Выберите один из приведенных ниже вариантов",
    "@apps",
    "menu.prop",
    "Настройка установки",   "Выбрать приложения для установки",     "@personalize",      #-- selected = 1
    "Полная установка",     "Установка Super пакета",      "@default",         #-- selected = 2
    "Выход",              "Возврат в рекавери",    "@alert"      #-- selected = 3
);

#Exit
if prop("menu.prop", "selected")=="3" then
    exit("");
endif;

##############################################
# Load Previous Choices
##############################################
checkviewbox(
  "Импорт настроек",
  "Загрузка сохраненных настроек\n\n\n\n\n<b>Вы хотите импортировать настройки установщика?</b>\n\n",
  "@welcome",

  "Загрузить настройки.", "1", "loadselections"
);

if
    getvar("loadselections")=="1"
  then
    if
        getvar("reset")!="1"
    then
        resexec("scripts/tools.sh", "load");
        setvar("reset", "1");
    endif;
  else
    if
      getvar("reset")=="1" then
        resexec("scripts/tools.sh", "reset");
        setvar("reset","0");
    endif;
endif;

if prop("menu.prop", "selected")=="1" then
##############################################
# Customized installation
##############################################
form(
    "Приложения",
    "Пожалуйста, выберите, какие приложения вы хотите включить или исключить</#>",
    "@default",
    aromagapps.prop,
    "inclorexcl",     "Выберите ваш вариант",        "",                    "group",
      "1",     "Включить",   "Выберите приложения, которые вы хотите установить из списка ниже.",             "select.selected",
      "0",     "Исключить",   "Выберите приложения, которые вы хотите исключить из списка ниже",       "select",

    "gapps",     "Выберите Gapps которые вы хотите установить/исключить",        "",                                         "group",
      "AndroidPay",     "<b>Android Pay</b>",       "",                      "check",
      "AndroidForWork",     "<b>Android For Work</b>",       "",                      "check",
      "Books",     "<b>Google Play Books</b>",       "",                      "check",
      "CalculatorGoogle",     "<b>Google Calculator</b>",       "",                      "check",
      "CalendarGoogle",     "<b>Google Calendar</b>",       "",                      "check",
      "CalSync",     "<b>Google Calendar Sync</b>",       "(устанавливается по умолчанию, когда Календарь Google не установлен)",                      "check",
      "CameraGoogle",     "<b>Google Camera</b>",       "",                      "check",
      "Chrome",     "<b>Google Chrome</b>",       "",                      "check",
      "ClockGoogle",     "<b>Google Clock</b>",       "",                      "check",
      "CloudPrint",     "<b>Google Cloud Print</b>",       "",                      "check",
      "ContactsGoogle",     "<b>Google Contacts</b>",       "",                      "check",
      "DMAgent",     "<b>Google Apps Device Policy</b>",       "",                      "check",
      "Docs",     "<b>Google Docs</b>",       "",                      "check",
      "Drive",     "<b>Google Drive</b>",       "",                      "check",
      "Ears",     "<b>Sound Search for Google Play</b>",       "",                      "check",
      "Earth",     "<b>Google Earth</b>",       "",                      "check",
      "ExchangeGoogle",     "<b>Google Exchange Services</b>",       "",                      "check",
      "FaceDetect",     "<b>Face Detection for Media</b>",       "",                      "check",
      "FaceUnlock",     "<b>Face Unlock</b>",       "",                      "check",
      "Fitness",     "<b>Google Fit</b>",       "",                      "check",
      "GCS",     "<b>Google Connectivity Services</b>",       "Выключает Google Connectivity Services и Project Fi Google <#f00>ИЛИ</#> Включает Google Connectivity Services",                      "check",
      "Gmail",     "<b>Gmail</b>",       "",                      "check",
      "GoogleNow",     "<b>Google Now Launcher</b>",       "",                      "check",
      "GooglePlus",     "<b>Google+</b>",       "",                      "check",
      "GoogleTTS",     "<b>Google Text-to-Speech</b>",       "",                      "check",
      "Hangouts",     "<b>Google Hangouts</b>",       "",                      "check",
      "Indic",     "<b>Google Indic Keyboard</b>",       "",                      "check",
      "Japanese",     "<b>Google Japanese Input</b>",       "",                      "check",
      "Keep",     "<b>Google Keep</b>",       "",                      "check",
      "KeyboardGoogle",     "<b>Google Keyboard</b>",       "",                      "check",
      "Korean",     "<b>Google Korean Input</b>",       "",                      "check",
      "Maps",     "<b>Google Maps</b>",       "",                      "check",
      "Messenger",     "<b>Messenger</b>",       "(не устанавливается на Tablet устройства)",                      "check",
      "Movies",     "<b>Google Play Movies & TV</b>",       "",                      "check",
      "Music",     "<b>Google Play Music</b>",       "",                      "check",
      "NewsStand",     "<b>Google Play Newsstand</b>",       "",                      "check",
      "NewsWidget",     "<b>Google News & Weather</b>",       "",                      "check",
      "Pinyin",     "<b>Google Pinyin Input</b>",       "",                      "check",
      "Photos",     "<b>Google Photos</b>",       "",                      "check",
      "PlayGames",     "<b>Google Play Games</b>",       "",                      "check",
      "ProjectFi",     "<b>Project Fi by Google</b>",       "",                      "check",
      "Sheets",     "<b>Google Sheets</b>",       "",                      "check",
      "Slides",     "<b>Google Slides</b>",       "",                      "check",
      "Search",     "<b>Google Search</b>",       "Выключает Google Search и Google Now Launcher <#f00>ИЛИ</#> Влючает Google Search",                      "check",
      "Speech",     "<b>Offline Speech Files</b>",       "(Требуется для поддержки голосового ввода)",                      "check",
      "Street",     "<b>Google Street View</b>",       "",                      "check",
      "TagGoogle",     "<b>Google NFC Tags</b>",       "",                      "check",
      "Talkback",     "<b>Talkback</b>",       "",                      "check",
      "Translate",     "<b>Google Translate</b>",       "",                      "check",
      "WebViewGoogle",     "<b>Android System WebView</b>",       "",                      "check",
      "YouTube",     "<b>YouTube</b>",       "",                      "check",
      "Zhuyin",     "<b>Google Zhuyin Input</b>",       "",                      "check"
);
# Duplicate aromagapps.prop and rename it to gapps.prop - this is useful because the selections won't be erased by the complete installation (menu.prop selected ==2)
resexec("scripts/props.sh");
endif;

#IF COMPLETE INSTALLATION IS CHOOSEN - reset gapps.prop
if prop("menu.prop", "selected")=="2" then
  writetmpfile("gapps.prop", " ");
endif;

form(
    "Удаление приложений",
    "Внимание! Тут вы можете выбрать для удаления установленные пакеты Stock/AOSP. Не заменяйте приложения если вы не уверены в вашем выборе!",
    "@default",
    bypass.prop,
    "bypassrem",     "Не заменять приложения",        "",     "group",
      "+Browser",     "<b>+Browser</b>",      "",    "check",
      "+Email",     "<b>+Email</b>",      "",        "check",
      "+Gallery",     "<b>+Gallery</b>",      "",    "check",
      "+Launcher",     "<b>+Launcher</b>",      "",  "check",
      "+MMS",     "<b>+MMS</b>",      "",            "check",
      "+PicoTTS",     "<b>+PicoTTS</b>",      "",    "check"
);

form(
    "Удалить",
    "Пожалуйста выберите Stock/AOSP приложения для удаления\n</#>",
    "@default",
    rem.prop,
    "remove",     "Приложения для удаления",        "",                                         "group",
      "BasicDreams",     "<b>Basic Dreams Live Wallpaper</b>",       "",                      "check",
      "Browser",     "<b>Stock/AOSP Browser</b>",       "",                      "check",
      "CalendarStock",     "<b>Stock/AOSP Calendar</b>",       "(автоматически удаляется если Google Calendar установлен)",                      "check",
      "CameraStock",     "<b>Stock/AOSP/Moto Camera</b>",       "(автоматически удаляется если Google Camera установлена)",                      "check",
      "ClockStock",     "<b>Stock/AOSP Clock</b>",       "(автоматически удаляется если Google Clock установлен)",                      "check",
      "CMAccount",     "<b>CyanogenMod Account</b>",       "",                      "check",
      "CMAudioFX",     "<b>CyanogenMod AudioFX</b>",       "",                      "check",
      "CMEleven",     "<b>CyanogenMod Music</b>",       "",                      "check",
      "CMFileManager",     "<b>CyanogenMod File Manager</b>",       "",                      "check",
      "CMSetupWizard",     "<b>CyanogenMod Setup Wizard</b>",       "",                      "check",
      "CMUpdater",     "<b>CyanogenMod Updater</b>",       "",                      "check",
      "CMWallpapers",     "<b>CyanogenMod Wallpapers</b>",       "",                      "check",
      "DashClock",     "<b>DashClock Widget</b>",       "(присутствует в некоторых прошивках)",                      "check",
      "Email",     "<b>Stock/AOSP Email</b>",       "",                      "check",
      "ExchangeStock",     "<b>Stock/AOSP Exchange Services</b>",       "(автоматически удаляется если Google Exchange Services установлен)",                      "check",
      "FMRadio",     "<b>Stock/AOSP FM Radio</b>",       "(отсутствует во всех прошивках)",                      "check",
      "Galaxy",     "<b>Galaxy Live Wallpaper</b>",       "",                      "check",
      "Gallery",     "<b>Stock/AOSP Gallery</b>",       "",                      "check",
      "HoloSpiral",     "<b>Holo Spiral Live Wallpaper</b>",       "",                      "check",
      "KeyboardStock",     "<b>Stock/AOSP Keyboard</b>",       "(автоматически удаляется если Google Keyboard установлена)",                      "check",
      "Launcher",     "<b>Stock/AOSP Launcher(s)</b>",       "",                      "check",
      "LiveWallpapers",     "<b>Live Wallpapers</b>",       "",                      "check",
      "LockClock",     "<b>Lock Clock</b>",       "(присутствует в некоторых прошивках)",                      "check",
      "MMS",     "<b>Stock/AOSP MMS</b>",       "",                      "check",
      "NoiseField",     "<b>NoiseField Live Wallpaper</b>",       "",                      "check",
      "Phasebeam",     "<b>Phasebeam Live Wallpaper</b>",       "",                      "check",
      "PhotoPhase",     "<b>PhotoPhase Live Wallpaper</b>",       "",                      "check",
      "PhotoTable",     "<b>PhotoTable Live Wallpaper</b>",       "",                      "check",
      "PicoTTS",     "<b>Stock/AOSP Text-to-Speech</b>",       "",                      "check",
      "SimToolKit",     "<b>Stock/AOSP Sim ToolKit</b>",       "",                      "check",
      "Studio",     "<b>Stock/AOSP Movie Studio</b>",       "",                      "check",
      "SykoPath",     "<b>SykoPath Layers Manager</b>",       "(отсутствует во всех прошивках)",                      "check",
      "Terminal",     "<b>Terminal</b>",       "",                      "check",
      "Themes",     "<b>CyanogenMod Theme Engine</b>",       "(Разрывает связь с настройками темы!)",                      "check",
      "VisualizationWallpapers",     "<b>Visualization Live Wallpaper</b>",       "",                      "check",
      "WhisperPush",     "<b>WhisperPush</b>",       "",                      "check"
);
form(
    "Расширенные настройки",
    "Некоторые дополнительные настройки, которые, скорее всего, не нужно использовать.\n</#>",
    "@default",
    extra.prop,
    "extra",     "Расширенные настройки",        "",                                         "group",
      "ex1",     "<b>Не использовать лог отладки</b>",       "Выключить отладку",                      "check",
      "ex2",     "<b>Тест</b>",       "Тестирование установки в лог файл, <u>НЕ ВНОСИТ ИЗМЕНЕНИЙ</u> в прошивку.",                      "check"
);

##############################################
# Write the gapps-config file
##############################################
setvar("gapps","");

# ADVANCED OPTIONS
if
  prop("extra.prop", "ex1")=="1"
then
  appendvar("gapps", "NoDebug\n");
endif;
if
  prop("extra.prop", "ex2")=="1"
then
  appendvar("gapps", "Test\n");
endif;

# INCLUDE/EXCLUDE
if
  prop("gapps.prop", "inclorexcl")=="1"
then
  appendvar("gapps", "Include");
else
  appendvar("gapps", "Exclude");
endif;

# APP CHOICES
appendvar("gapps", "\n\n");

if
  prop("gapps.prop", "AndroidPay")=="1"
then
  appendvar("gapps", "AndroidPay\n");
endif;

if
  prop("gapps.prop", "AndroidForWork")=="1"
then
  appendvar("gapps", "AndroidForWork\n");
endif;

if
  prop("gapps.prop", "Books")=="1"
then
  appendvar("gapps", "Books\n");
endif;

if
  prop("gapps.prop", "CalculatorGoogle")=="1"
then
  appendvar("gapps", "CalculatorGoogle\n");
endif;

if
  prop("gapps.prop", "CalendarGoogle")=="1"
then
  appendvar("gapps", "CalendarGoogle\n");
endif;

if
  prop("gapps.prop", "CalSync")=="1"
then
  appendvar("gapps", "CalSync\n");
endif;

if
  prop("gapps.prop", "CameraGoogle")=="1"
then
  appendvar("gapps", "CameraGoogle\n");
endif;

if
  prop("gapps.prop", "Chrome")=="1"
then
  appendvar("gapps", "Chrome\n");
endif;

if
  prop("gapps.prop", "ClockGoogle")=="1"
then
  appendvar("gapps", "ClockGoogle\n");
endif;

if
  prop("gapps.prop", "CloudPrint")=="1"
then
  appendvar("gapps", "CloudPrint\n");
endif;

if
  prop("gapps.prop", "ContactsGoogle")=="1"
then
  appendvar("gapps", "ContactsGoogle\n");
endif;

if
  prop("gapps.prop", "DMAgent")=="1"
then
  appendvar("gapps", "DMAgent\n");
endif;

if
  prop("gapps.prop", "Docs")=="1"
then
  appendvar("gapps", "Docs\n");
endif;

if
  prop("gapps.prop", "Drive")=="1"
then
  appendvar("gapps", "Drive\n");
endif;

if
  prop("gapps.prop", "Ears")=="1"
then
  appendvar("gapps", "Ears\n");
endif;

if
  prop("gapps.prop", "Earth")=="1"
then
  appendvar("gapps", "Earth\n");
endif;

if
  prop("gapps.prop", "ExchangeGoogle")=="1"
then
  appendvar("gapps", "ExchangeGoogle\n");
endif;

if
  prop("gapps.prop", "FaceDetect")=="1"
then
  appendvar("gapps", "FaceDetect\n");
endif;

if
  prop("gapps.prop", "FaceUnlock")=="1"
then
  appendvar("gapps", "FaceUnlock\n");
endif;

if
  prop("gapps.prop", "Fitness")=="1"
then
  appendvar("gapps", "Fitness\n");
endif;

if
  prop("gapps.prop", "GCS")=="1"
then
  appendvar("gapps", "GCS\n");
endif;

if
  prop("gapps.prop", "Gmail")=="1"
then
  appendvar("gapps", "Gmail\n");
endif;

if
  prop("gapps.prop", "GoogleNow")=="1"
then
  appendvar("gapps", "GoogleNow\n");
endif;

if
  prop("gapps.prop", "GooglePlus")=="1"
then
  appendvar("gapps", "GooglePlus\n");
endif;

if
  prop("gapps.prop", "GoogleTTS")=="1"
then
  appendvar("gapps", "GoogleTTS\n");
endif;

if
  prop("gapps.prop", "Hangouts")=="1"
then
  appendvar("gapps", "Hangouts\n");
endif;

if
  prop("gapps.prop", "Indic")=="1"
then
  appendvar("gapps", "Indic\n");
endif;

if
  prop("gapps.prop", "Japanese")=="1"
then
  appendvar("gapps", "Japanese\n");
endif;

if
  prop("gapps.prop", "Keep")=="1"
then
  appendvar("gapps", "Keep\n");
endif;

if
  prop("gapps.prop", "KeyboardGoogle")=="1"
then
  appendvar("gapps", "KeyboardGoogle\n");
endif;

if
  prop("gapps.prop", "Korean")=="1"
then
  appendvar("gapps", "Korean\n");
endif;

if
  prop("gapps.prop", "Maps")=="1"
then
  appendvar("gapps", "Maps\n");
endif;

if
  prop("gapps.prop", "Messenger")=="1"
then
  appendvar("gapps", "Messenger\n");
endif;

if
  prop("gapps.prop", "Movies")=="1"
then
  appendvar("gapps", "Movies\n");
endif;

if
  prop("gapps.prop", "Music")=="1"
then
  appendvar("gapps", "Music\n");
endif;

if
  prop("gapps.prop", "NewsStand")=="1"
then
  appendvar("gapps", "NewsStand\n");
endif;

if
  prop("gapps.prop", "NewsWidget")=="1"
then
  appendvar("gapps", "NewsWidget\n");
endif;

if
  prop("gapps.prop", "Pinyin")=="1"
then
  appendvar("gapps", "Pinyin\n");
endif;

if
  prop("gapps.prop", "Photos")=="1"
then
  appendvar("gapps", "Photos\n");
endif;

if
  prop("gapps.prop", "PlayGames")=="1"
then
  appendvar("gapps", "PlayGames\n");
endif;

if
  prop("gapps.prop", "ProjectFi")=="1"
then
  appendvar("gapps", "ProjectFi\n");
endif;

if
  prop("gapps.prop", "Sheets")=="1"
then
  appendvar("gapps", "Sheets\n");
endif;

if
  prop("gapps.prop", "Slides")=="1"
then
  appendvar("gapps", "Slides\n");
endif;

if
  prop("gapps.prop", "Search")=="1"
then
  appendvar("gapps", "Search\n");
endif;

if
  prop("gapps.prop", "Speech")=="1"
then
  appendvar("gapps", "Speech\n");
endif;

if
  prop("gapps.prop", "Street")=="1"
then
  appendvar("gapps", "Street\n");
endif;

if
  prop("gapps.prop", "TagGoogle")=="1"
then
  appendvar("gapps", "TagGoogle\n");
endif;

if
  prop("gapps.prop", "Talkback")=="1"
then
  appendvar("gapps", "Talkback\n");
endif;

if
  prop("gapps.prop", "Translate")=="1"
then
  appendvar("gapps", "Translate\n");
endif;

if
  prop("gapps.prop", "WebViewGoogle")=="1"
then
  appendvar("gapps", "WebViewGoogle\n");
endif;

if
  prop("gapps.prop", "YouTube")=="1"
then
  appendvar("gapps", "YouTube\n");
endif;

if
  prop("gapps.prop", "Zhuyin")=="1"
then
  appendvar("gapps", "Zhuyin\n");
endif;

appendvar("gapps", "\n");

# REMOVALS
if
  prop("rem.prop", "BasicDreams")=="1"
then
  appendvar("gapps", "BasicDreams\n");
endif;

if
  prop("rem.prop", "Browser")=="1"
then
  appendvar("gapps", "Browser\n");
endif;

if
  prop("rem.prop", "CalendarStock")=="1"
then
  appendvar("gapps", "CalendarStock\n");
endif;

if
  prop("rem.prop", "ClockStock")=="1"
then
  appendvar("gapps", "ClockStock\n");
endif;

if
  prop("rem.prop", "CameraStock")=="1"
then
  appendvar("gapps", "CameraStock\n");
endif;

if
  prop("rem.prop", "CMAccount")=="1"
then
  appendvar("gapps", "CMAccount\n");
endif;

if
  prop("rem.prop", "CMAudioFX")=="1"
then
  appendvar("gapps", "CMAudioFX\n");
endif;

if
  prop("rem.prop", "CMEleven")=="1"
then
  appendvar("gapps", "CMEleven\n");
endif;

if
  prop("rem.prop", "CMFileManager")=="1"
then
  appendvar("gapps", "CMFileManager\n");
endif;

if
  prop("rem.prop", "CMSetupWizard")=="1"
then
  appendvar("gapps", "CMSetupWizard\n");
endif;

if
  prop("rem.prop", "CMUpdater")=="1"
then
  appendvar("gapps", "CMUpdater\n");
endif;

if
  prop("rem.prop", "CMWallpapers")=="1"
then
  appendvar("gapps", "CMWallpapers\n");
endif;

if
  prop("rem.prop", "DashClock")=="1"
then
  appendvar("gapps", "DashClock\n");
endif;

if
  prop("rem.prop", "Email")=="1"
then
  appendvar("gapps", "Email\n");
endif;

if
  prop("rem.prop", "ExchangeStock")=="1"
then
  appendvar("gapps", "ExchangeStock\n");
endif;

if
  prop("rem.prop", "FMRadio")=="1"
then
  appendvar("gapps", "FMRadio\n");
endif;

if
  prop("rem.prop", "Galaxy")=="1"
then
  appendvar("gapps", "Galaxy\n");
endif;

if
  prop("rem.prop", "Gallery")=="1"
then
  appendvar("gapps", "Gallery\n");
endif;

if
  prop("rem.prop", "HoloSpiral")=="1"
then
  appendvar("gapps", "HoloSpiral\n");
endif;

if
  prop("rem.prop", "KeyboardStock")=="1"
then
  appendvar("gapps", "KeyboardStock\n");
endif;

if
  prop("rem.prop", "Launcher")=="1"
then
  appendvar("gapps", "Launcher \n");
endif;

if
  prop("rem.prop", "LiveWallpapers")=="1"
then
  appendvar("gapps", "LiveWallpapers\n");
endif;

if
  prop("rem.prop", "LockClock")=="1"
then
  appendvar("gapps", "LockClock\n");
endif;

if
  prop("rem.prop", "MMS")=="1"
then
  appendvar("gapps", "MMS\n");
endif;

if
  prop("rem.prop", "NoiseField")=="1"
then
  appendvar("gapps", "NoiseField\n");
endif;

if
  prop("rem.prop", "Phasebeam")=="1"
then
  appendvar("gapps", "Phasebeam\n");
endif;

if
  prop("rem.prop", "PhotoPhase")=="1"
then
  appendvar("gapps", "PhotoPhase\n");
endif;

if
  prop("rem.prop", "PhotoTable")=="1"
then
  appendvar("gapps", "PhotoTable\n");
endif;

if
  prop("rem.prop", "PicoTTS")=="1"
then
  appendvar("gapps", "PicoTTS\n");
endif;

if
  prop("rem.prop", "SimToolKit")=="1"
then
  appendvar("gapps", "SimToolKit\n");
endif;

if
  prop("rem.prop", "Studio")=="1"
then
  appendvar("gapps", "Studio\n");
endif;

if
  prop("rem.prop", "SykoPath")=="1"
then
  appendvar("gapps", "SykoPath\n");
endif;

if
  prop("rem.prop", "Terminal")=="1"
then
  appendvar("gapps", "Terminal\n");
endif;

if
  prop("rem.prop", "Themes")=="1"
then
  appendvar("gapps", "Themes\n");
endif;

if
  prop("rem.prop", "VisualizationWallpapers")=="1"
then
  appendvar("gapps", "VisualizationWallpapers\n");
endif;

if
  prop("rem.prop", "WhisperPush")=="1"
then
  appendvar("gapps", "WhisperPush\n");
endif;



# BYPASS REMOVALS
appendvar("gapps", "\n\n");
if
  prop("bypass.prop", "+Browser")=="1"
then
  appendvar("gapps", "+Browser\n");
endif;
if
  prop("bypass.prop", "+Email")=="1"
then
  appendvar("gapps", "+Email\n");
endif;
if
  prop("bypass.prop", "+Gallery")=="1"
then
  appendvar("gapps", "+Gallery\n");
endif;
if
  prop("bypass.prop", "+Launcher")=="1"
then
  appendvar("gapps", "+Launcher\n");
endif;
if
  prop("bypass.prop", "+MMS")=="1"
then
  appendvar("gapps", "+MMS\n");
endif;
if
  prop("bypass.prop", "+PicoTTS")=="1"
then
  appendvar("gapps", "+PicoTTS\n");
endif;

# WRITE CONFIG TO TEMP AND DISPLAY IT
writetmpfile(".gapps-config", getvar("gapps"));

textbox(
    "gapps-config",
    "Ваш gapps-config файл.",
    "@update",
    read("tmp/aroma/.gapps-config")
);

##############################################
# Save Choices
##############################################
checkviewbox(
  "Сохранение настроек",
  "Сохранить настройки в: /sdcard/Open-GApps\n\n\n\n\n<b>Сохранить ваши настройки установки? Это сэкономит время в будущих установках.</b>\n\n",
  "@welcome",

  "Сохранить настройки", "1", "saveselections"
);
if
    getvar("saveselections")=="1"
  then
    resexec("scripts/tools.sh", "save");
endif;

# Pre-Install
ini_set("text_next", "Установка GApps");
viewbox(
  "Выполнить установку GApps.",
  "Готовы ли вы установить GAPPS на основе ваших предпочтений?\n\n\n\n\n" +
  "Нажмите <b>Установить GApps</b> для начала установки.\n\n" +
  "Если вы хотите просмотреть или изменить какие-либо настройки, нажмите <b>Назад</b>.",
  "@install"
);

# Install
ini_set("text_next", "Далее");
install(
  "Установка",
  "<b>OpenGApps</b> устанавливаются...\n\n" +
  "Пожалуйста, подождите, пока процесс не будет завершен",
  "@install",
  "Нажмите Далее, чтобы продолжить.."
);

# Post-Install
ini_set("text_next", "Завершить");
checkviewbox(
  "Установлено",
  "<b>Поздравляем!</b>\n\n\n\n\n" +
  "Open GApps установлены.",
  "@welcome",

  "Перегрузите систему.", "0", "reboot_it"
);

#Reboot
if
  getvar("reboot_it")=="1"
then
  reboot("onfinish");
endif;
EOFILE
}
