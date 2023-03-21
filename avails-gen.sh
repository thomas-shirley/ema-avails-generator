#!/bin/bash

##  
#  Copyright 2023 Thomas Alexander Shirley
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
##

#Formatting
green_on=$(tput setaf 2)$(tput smso);
green_off=$(tput sgr0);

#Create the EMA avails headings & Rows
headings1=(
"Avail" "Avail" "AvailTrans" "AvailTrans" "AvailTrans" "AvailAsset" "Disposition" "AvailMetadata" "AvailMetadata" "AvailMetadata" "AvailMetadata" "AvailMetadata" "AvailMetadata" "AvailTrans" "AvailTrans" "AvailTrans" "AvailTrans" "AvailTrans" "AvailTrans" "AvailTrans" "AvailTrans" "AvailTrans" "AvailTrans" "AvailTrans" "AvailTrans" "AvailTrans" "AvailTrans" "AvailTrans" "AvailTrans" "AvailTrans" "AvailTrans" "AvailTrans" "AvailTrans" "AvailAsset" "AvailAsset" "AvailAsset" "AvailAsset" "Avail" "Avail" "Avail" "Avail" "AvailAsset" "Avail" "AvailTrans" "AvailTrans" "AvailTrans" "AvailMetadata" "AvailMetadata" "AvailMetadata" "Avail" "AvailMetadata" "AvailMetadata" "AvailMetadata" "AvailTrans" "AvailTrans" "AvailMetadata" "AvailMetadata" "AvailMetadata" "AvailTrans" "AvailTrans" "AvailTrans" "AvailTrans" "AvailTrans" "AvailTrans" "Avail" "AvailMetadata" "AvailTrans" "AvailTrans" "AvailTrans" "Avail" "AvailMetadata" "AvailMetadata" "AvailMetadata" "Avail" "Avail" "Avail"
)

# create an array with the headings for the second row
headings2=(
"DisplayName" "Licensee" "AssetLanguage" "Territory" "TerritoryExclusion" "WorkType" "EntryType" "TitleInternalAlias" "TitleDisplayUnlimited" "LocalizationType" "CompanyDisplayCredit" "GroupIdentity" "Director" "LicenseType" "LicenseRightsDescription" "FormatProfile" "HDR" "WCG" "HFR" "NGAudio" "Start" "StartLag" "End" "EndLag" "WindowDuration" "PriceType" "PriceValue" "PriceCurrency" "SRP" "Description" "Download" "OtherTerms" "OtherInstructions" "TitleID" "EditID" "AltID" "ContentID" "AvailID" "UV_ID" "DMA_ID" "ReportingID" "Metadata" "ALID" "SuppressionLiftDate" "SpecialPreOrderFulfillDate" "AnnounceDate" "ReleaseYear" "ReleaseHistoryOriginal" "ReleaseHistoryPhysicalHV" "ExceptionFlag" "RatingSystem" "RatingValue" "RatingReason" "RentalDuration" "WatchDuration" "CaptionIncluded" "CaptionExemption" "Any" "ContractID" "TitleStatus" "Exclusive" "ExclusiveAttributes" "BrandingRights" "BrandingRightsAttributes" "ServiceProvider" "TotalRunTime" "HoldbackLanguage" "AllowedLanguages" "RequiredFulfillmentLanguages" "BundleALIDs" "RetailerID1" "RetailerID2" "RetailerID3" "RetailerSpare1" "RetailerSpare2" "RetailerSpare3"
)

# add third row of headers
headings3=(
"//REQ" "//Opt" "//Opt" "//REQ" "//Opt" "//REQ" "//REQ" "//REQ" "//Opt" "//Opt" "//Opt" "//Opt" "//Opt" "//REQ" "//Opt" "//REQ" "//Opt" "//Opt" "//Opt" "//Opt" "//REQ" "//Opt" "//REQ" "//Opt" "//Opt" "//REQ for all but SVOD LicenseType" "//REQ for all but SVOD LicenseType" "//Opt" "//Opt" "//Opt" "//Opt" "//Opt" "//Opt" "//Opt" "//Opt" "//Opt" "//REQ" "//Opt" "//Opt" "//Opt" "//Opt" "//Opt" "//REQ" "//REQUIRED for pre-orders" "//Optional for preorders. Should be blank for all other license types. " "//Opt" "//Opt" "//Opt" "//Opt" "//Opt" "//Opt" "//Opt" "//Opt" "//Opt" "//Opt" "//REQUIRED for episodes in US. " "//REQUIRED in US if captions are *not* included." "//Opt" "//Opt" "//Opt" "//Opt" "//Opt" "//Opt" "//Opt" "//Opt" "//Opt" "//Opt" "//Opt" "//Opt" "//Opt" "//Opt" "//Opt" "//Opt" "//Opt" "//Opt" "//Opt"
)

## NOTES:
## TERRITORIES array can be adapted to include as many territories as you like, just don't forget to add any additional territories to the swtich block.
## MX language code is es-419
## Check the EMA guidelines to learn more about the different fields
## 

TERRITORIES=("GB","AU","DE","FR","IT","ES","MX","BR","JP");

# join each array with commas to create the CSV rows
csv_row1=$(printf "%s," "${headings1[@]}")
csv_row1=${csv_row1%,}

csv_row2=$(printf "%s," "${headings2[@]}")
csv_row2=${csv_row2%,}

csv_row3=$(printf "%s," "${headings3[@]}")
csv_row3=${csv_row3%,}

echo -e ${green_on}'Which territory is this for?'${green_off};
for i in $TERRITORIES; do
       echo -e "$i \n";
done
read TERRITORY_NAME;
echo -e ${green_on}'What is the name of the piece?'${green_off} "INFO: e.g. Extended Preview for My Movie. This is used to identify the file on the retailer backend."
read LOCAL_TITLE_NAME;
echo -e ${green_on}'What is the peice titled locally?' ${green_off} "INFO: e.g. Extended Preview - My Movie";
read LOCAL_PEICE_TITLE;
echo -e ${green_on}'What is the local release date? (YYYY-MM-DD)'${green_off};
read LOCAL_RELEASE_DATE;
echo -e ${green_on}'What is the SKU identifier?' ${green_off};
read LOCAL_PEICE_SKU_IDENTIFER;

echo "Great, that's everything!";

MARKET_DATA_GB="STUDIO_NAME, , EN, GB, , Movie, Full Extract, ${LOCAL_TITLE_NAME}, , , , , , FVOD, New Release, HD, , , , , ${LOCAL_RELEASE_DATE}, , Open, , , , , , , , , , , , ${LOCAL_PEICE_SKU_IDENTIFER}, ${LOCAL_PEICE_SKU_IDENTIFER}, ${LOCAL_PEICE_SKU_IDENTIFER}, , , , , ,${LOCAL_PEICE_SKU_IDENTIFER} , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , ,";
MARKET_DATA_MX="STUDIO_NAME, , es-419, MX, , Movie, Full Extract, ${LOCAL_TITLE_NAME}, , , , , , VOD, New Release, HD, , , , , ${LOCAL_RELEASE_DATE}, , Open, , ,WSP,0, , , , , , , , ${LOCAL_PEICE_SKU_IDENTIFER}, ${LOCAL_PEICE_SKU_IDENTIFER}, ${LOCAL_PEICE_SKU_IDENTIFER}, , , , , ,${LOCAL_PEICE_SKU_IDENTIFER} , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , ,";
MARKET_DATA_AU="STUDIO_NAME, , EN, AU, , Movie, Full Extract, ${LOCAL_TITLE_NAME}, , , , , , VOD, New Release, HD, , , , , ${LOCAL_RELEASE_DATE}, , Open, , ,WSP,0, , , , , , , , ${LOCAL_PEICE_SKU_IDENTIFER}, ${LOCAL_PEICE_SKU_IDENTIFER}, ${LOCAL_PEICE_SKU_IDENTIFER}, , , , , ,${LOCAL_PEICE_SKU_IDENTIFER} , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , ,";
MARKET_DATA_BR="STUDIO_NAME, , PT, BR, , Movie, Full Extract, ${LOCAL_TITLE_NAME}, , , , , , VOD, New Release, HD, , , , , ${LOCAL_RELEASE_DATE}, , Open, , ,WSP,0, , , , , , , , ${LOCAL_PEICE_SKU_IDENTIFER}, ${LOCAL_PEICE_SKU_IDENTIFER}, ${LOCAL_PEICE_SKU_IDENTIFER}, , , , , ,${LOCAL_PEICE_SKU_IDENTIFER} , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , ,";
MARKET_DATA_DE="STUDIO_NAME, , DE, DE, , Movie, Full Extract, ${LOCAL_TITLE_NAME}, , , , , , FVOD, New Release, HD, , , , , ${LOCAL_RELEASE_DATE}, , Open, , , , , , , , , , , , ${LOCAL_PEICE_SKU_IDENTIFER}, ${LOCAL_PEICE_SKU_IDENTIFER}, ${LOCAL_PEICE_SKU_IDENTIFER}, , , , , ,${LOCAL_PEICE_SKU_IDENTIFER} , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , ,";
MARKET_DATA_FR="STUDIO_NAME, , FR, FR, , Movie, Full Extract, ${LOCAL_TITLE_NAME}, , , , , , VOD, New Release, HD, , , , , ${LOCAL_RELEASE_DATE}, , Open, , ,WSP ,0 , , , , , , , , ${LOCAL_PEICE_SKU_IDENTIFER}, ${LOCAL_PEICE_SKU_IDENTIFER}, ${LOCAL_PEICE_SKU_IDENTIFER}, , , , , ,${LOCAL_PEICE_SKU_IDENTIFER} , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , ,";
MARKET_DATA_ES="STUDIO_NAME, , ES, ES, , Movie, Full Extract, ${LOCAL_TITLE_NAME}, , , , , , VOD, New Release, HD, , , , , ${LOCAL_RELEASE_DATE}, , Open, , ,WSP ,0 , , , , , , , , ${LOCAL_PEICE_SKU_IDENTIFER}, ${LOCAL_PEICE_SKU_IDENTIFER}, ${LOCAL_PEICE_SKU_IDENTIFER}, , , , , ,${LOCAL_PEICE_SKU_IDENTIFER} , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , ,";
MARKET_DATA_IT="STUDIO_NAME, , IT, IT, , Movie, Full Extract, ${LOCAL_TITLE_NAME}, , , , , , VOD, New Release, HD, , , , , ${LOCAL_RELEASE_DATE}, , Open, , ,WSP ,0 , , , , , , , , ${LOCAL_PEICE_SKU_IDENTIFER}, ${LOCAL_PEICE_SKU_IDENTIFER}, ${LOCAL_PEICE_SKU_IDENTIFER}, , , , , ,${LOCAL_PEICE_SKU_IDENTIFER} , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , ,";
MARKET_DATA_JP="STUDIO_NAME, , JP, JP, , Movie, Full Extract, ${LOCAL_TITLE_NAME}, , , , , , FVOD, New Release, HD, , , , , ${LOCAL_RELEASE_DATE}, , Open, , , , , , , , , , , , ${LOCAL_PEICE_SKU_IDENTIFER}, ${LOCAL_PEICE_SKU_IDENTIFER}, ${LOCAL_PEICE_SKU_IDENTIFER}, , , , , ,${LOCAL_PEICE_SKU_IDENTIFER} , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , , ,";

echo "Generating EMA compliant avails in ${TERRITORY_NAME} with the filename: ${LOCAL_PEICE_SKU_IDENTIFER}.csv";

#Write the basic row headings to the csv file first.
echo $csv_row1 > ${LOCAL_PEICE_SKU_IDENTIFER}.csv
echo $csv_row2 >> ${LOCAL_PEICE_SKU_IDENTIFER}.csv
echo $csv_row3 >> ${LOCAL_PEICE_SKU_IDENTIFER}.csv

case $TERRITORY_NAME in 
    GB)
    echo $MARKET_DATA_GB >> ${LOCAL_PEICE_SKU_IDENTIFER}.csv
    ;;
    AU)
    echo $MARKET_DATA_AU >> ${LOCAL_PEICE_SKU_IDENTIFER}.csv
    ;;
    MX)
    echo $MARKET_DATA_MX >> ${LOCAL_PEICE_SKU_IDENTIFER}.csv
    ;;
    BR)
    echo $MARKET_DATA_BR >> ${LOCAL_PEICE_SKU_IDENTIFER}.csv
    ;;
    FR)
    echo $MARKET_DATA_FR >> ${LOCAL_PEICE_SKU_IDENTIFER}.csv
    ;;
    ES)
    echo $MARKET_DATA_ES >> ${LOCAL_PEICE_SKU_IDENTIFER}.csv
    ;;
    IT)
    echo $MARKET_DATA_IT >> ${LOCAL_PEICE_SKU_IDENTIFER}.csv
    ;;
    JP)
    echo $MARKET_DATA_IT >> ${LOCAL_PEICE_SKU_IDENTIFER}.csv
    ;;
    DE)
    echo $MARKET_DATA_DE >> ${LOCAL_PEICE_SKU_IDENTIFER}.csv
    ;;
esac





