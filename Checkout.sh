MCDARCH_DIR=${WORKSPACE}
MCDAPPCORE_DIR="${MCDARCH_DIR}/libraries/android-mcd-core-app"
MCDUIKIT_DIR="${MCDARCH_DIR}/libraries/android-mcd-core-app/libraries/android-mcd-uikit"
MCDCONNECT_DIR="${MCDARCH_DIR}/libraries/android-mcd-core-app/libraries/android-gma-sdk-sapient"
ARCH_BRANCH=${GIT_BRANCH#*/}
APPCORE_BRANCH=${GIT_BRANCH#*/}
UIKIT_BRANCH=${GIT_BRANCH#*/}
SDK_BRANCH=${GIT_BRANCH#*/}

echo "*************Checking out McDAppARCH Repository*****************"
cd "${MCDARCH_DIR}"
git gc --prune=now
git checkout dap-develop
git submodule
git submodule init
git branch
git submodule update --checkout --recursive
git log --pretty=format:'%h' -n 1

echo "*************Checking out McDAppCore Repository*****************"
cd "${MCDAPPCORE_DIR}"
git gc --prune=now
git checkout dap-develop
git pull
git branch
#git reset --hard
git pull
git submodule update --checkout --recursive
git checkout dap-develop
git log --pretty=format:'%h' -n 1

echo "*************Checking out McDonaldsSDK Repository*****************"
cd "${MCDCONNECT_DIR}"
git gc --prune=now
git checkout dap-develop
git pull
git branch
#git reset --hard
git pull
git submodule update --checkout --recursive
git checkout dap-develop
git log --pretty=format:'%h' -n 1

echo "*************Checking out McDUIKit Repository*****************"
cd "${MCDUIKIT_DIR}"
git gc --prune=now
git checkout dap-develop
git pull
git branch
#git reset --hard
git pull
git submodule update --checkout --recursive
git checkout dap-develop
git log --pretty=format:'%h' -n 1
