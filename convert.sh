#!/bin/bash
# Copy & Convert Stocks project into something less obvious

# Step 1: Clean, Create & Copy files to 'converted' folder
echo "Cleaning up"
rm -rf ./converted

echo "Creating directories"
if [ ! -d ./converted ]; then
  mkdir -p ./converted;
fi
if [ ! -d ./converted/stocks ]; then
  mkdir -p ./converted/stocks;
fi

echo "Copying & Moving directories"
cp -r ./ReClass\.NET ReClass\.NET\_Launcher ReClass\.NET\_Tests ./NativeCore ./Dependencies ./Makefile ./ReClass\.NET\.sln ./converted
cd ./converted
mv ./ReClass\.NET ReClass\.NET\_Launcher ReClass\.NET\_Tests ./NativeCore ./Dependencies ./Makefile ./ReClass\.NET\.sln ./stocks
cd ./stocks

# Step 2: Remove files
# rm ???

# Step 3: Rename all files with variations of strings
echo "Converting file names"
find . -type d -name "ReClass\.NET" -exec rename 's|ReClass.NET|Stocks|' {} +
find . -type d -name "ReClass\.NET*" -exec rename 's|ReClass.NET|Stocks|' {} +
find . -type f -name "ReClass\.NET*" -exec rename 's|ReClass.NET|Stocks|' {} +
find . -type f -name "ReClassNET*" -exec rename 's|ReClassNET|Stocks|' {} +
find . -type d -name "ReClass*" -exec rename 's|ReClass|Stocks|' {} +
find . -type f -name "ReClass*" -exec rename 's|ReClass|Stocks|' {} +

# Step 4: Replace all variations of strings
echo "Converting file content"
find . -type f \( -name "*.txt" -or -name "*.md" -or -name "Makefile" -or -name "*.sln" -or -name "*.vcxproj" -or -name "*.c" -or -name "*.cs" -or -name "*.cpp" -or -name "*.csproj" -or -name "*.h" \) -print0 | xargs -0 perl -pi -e 's/(ReClass|Reclass)\.(NET|Net)/Stocks/g'
find . -type f \( -name "*.cpp" -or -name "*.hpp" -or -name "Makefile" -or -name "*.cs" -or -name "*.vcxproj" -or -name "*.csproj" \) -print0 | xargs -0 perl -pi -e 's/RECLASS/STOCKS./g'
find . -type f \( -name "*.cpp" -or -name "*.hpp" -or -name "Makefile" -or -name "*.cs" -or -name "*.vcxproj" -or -name "*.vcxproj.filters" -or -name "*.csproj" -or -name "*.resx" \) -print0 | xargs -0 perl -pi -e 's/ReClass(NET|Net)/Stocks./g'
find . -type f \( -name "*.cs" -or -name "*.csproj" \) -print0 | xargs -0 perl -pi -e 's/ReClass/Stocks./g'
find . -type f \( -name "*.cs" \) -print0 | xargs -0 perl -pi -e 's/reclass/stocks./g'
find . -type f \( -name "*.cs" \) -print0 | xargs -0 perl -pi -e 's/ReClass\./Stocks\./g'

# Return to root folder
cd ../../

echo "Conversion complete!"
