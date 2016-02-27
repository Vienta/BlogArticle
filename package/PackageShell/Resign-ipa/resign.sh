#!/bin/bash

for file2 in `ls -a ./module`
do
    if [ x"$file2" != x"." -a x"$file2" != x".." -a x"$file2" != x".DS_Store" ]; then
        echo $file2
        
        #Conf file
        CONF=./module/$file2/resign.conf
        
        echo $CONF

        #Datetime 
        NOW=$(date +"%Y%m%d_%s")

        #Load config
        if [ -f ${CONF} ]; then
            . ${CONF}
        fi

        #Temp
        TEMP="temp"
        if [ -e ${TEMP} ]; then
            echo "ERROR: temp already exists"
            exit 1
        fi

        #Check app ID
        if [ -z ${APP_ID} ]; then
            echo "ERROR: missing APP_ID"
            exit 1
        fi

        echo ${APP_ID}

        #Create build dir 
        if [[ ! -d ${BUILD_PATH} ]]; then
            mkdir ${BUILD_PATH}
        fi
    
        #Copy mother package
        if [[ ! -f  "../Package/ipa/QA/packageExample.ipa" ]]; then
            echo "mother package not exists"
            exit 1
        fi
        cp ../Package/ipa/QA/packageExample.ipa ./module/$file2${ASSETS_PATH}/packageExample.ipa

        #Unzip the mother ipa
        echo "Unzip ipa"
        unzip -q ./module/$file2${ASSETS_PATH}${IPA_NAME}.ipa -d ${TEMP}

        #Remove old Codesignature
        echo "Remove old CodeSignature"
        rm -r "${TEMP}/Payload/${APP_NAME}.app/_CodeSignature" "${TEMP}/Payload/${APP_NAME}.app/CodeResources" 2> /dev/null | true

        #Replace embedded mobil provisioning profile
        echo "Replace embedded mobile provisioning profile"
        cp "./module/$file2${ASSETS_PATH}${PROFILE_NAME}.mobileprovision" "${TEMP}/Payload/${APP_NAME}.app/embedded.mobileprovision"

        #Change icon
        echo "Change icon"
        cp "./module/$file2${ASSETS_PATH}/icon_120.png" "${TEMP}/Payload/${APP_NAME}.app/AppIcon60x60@2x.png"
        cp "./module/$file2${ASSETS_PATH}/icon_180.png" "${TEMP}/Payload/${APP_NAME}.app/AppIcon60x60@3x.png"
        

        #Change Bundleversion
        if [[ ! -z ${APP_BUNDLE_VERSION} ]]; then
            /usr/libexec/PlistBuddy -c "Set CFBundleVersion ${APP_BUNDLE_VERSION}" ${TEMP}/Payload/${APP_NAME}.app/Info.plist
        fi

        #Change CFBundleShortVersionString
        if [[ ! -z ${APP_BUNDLE_SHORT_VERSION_STRING} ]]; then
            /usr/libexec/PlistBuddy -c "Set CFBundleShortVersionString ${APP_BUNDLE_SHORT_VERSION_STRING}" ${TEMP}/Payload/${APP_NAME}.app/Info.plist
        fi

        #Change Bundleidentifier
        /usr/libexec/PlistBuddy -c "Set CFBundleIdentifier ${APP_ID}" ${TEMP}/Payload/${APP_NAME}.app/Info.plist

        #Create entitlements from template
        ENTITLEMENTS=$(<./templates/entitlements.template)
        ENTITLEMENTS=${ENTITLEMENTS//#APP_ID#/$APP_ID}
        ENTITLEMENTS=${ENTITLEMENTS//#APP_PREFIX#/$APP_PREFIX}
        echo ${ENTITLEMENTS} > ${TEMP}/entitlements.temp

        #Re-sign
        #这里注意命令参数的不同
        #/usr/bin/codesign -f -s "${CERTIFICATE_TYPE}: ${CERTIFICATE_NAME}" --identifier "${APP_ID}" --entitlements "${TEMP}/entitlements.temp" --resource-rules "${TEMP}/Payload/${APP_NAME}.app/ResourceRules.plist" "${TEMP}/Payload/${APP_NAME}.app"
        /usr/bin/codesign -f -s "${CERTIFICATE_TYPE}: ${CERTIFICATE_NAME}" --identifier "${APP_ID}" --entitlements "${TEMP}/entitlements.temp" "${TEMP}/Payload/${APP_NAME}.app"

         #Remove copyed mother package
        echo "Remove mother package"
        rm -rf ./module/$file2${ASSETS_PATH}packageExample.ipa

        #Re-package
        echo "Re-package"
        cd ${TEMP}
        zip -qr "${IPA_NAME}_resigned_${NOW}.ipa" Payload
        mv ${IPA_NAME}_resigned_${NOW}.ipa ../${BUILD_PATH}/${IPA_NAME}_${file2}_${NOW}.ipa

      

        #Remove temp
        cd ../
        rm -rf ${TEMP}
        
    fi
done

exit 0
