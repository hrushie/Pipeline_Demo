pipeline {
  agent any
  options{
  	timestamps()
	gitLabConnection('')

  		 }

	parameters{
		string(defaultValue: 'beta/DAP-6416', description: '', name: 'ARCH_BRANCH')
		string(defaultValue: 'beta/DAP-6416', description: '', name: 'APPCORE_BRANCH')
		string(defaultValue: 'beta/DAP-6416', description: '', name: 'UIKIT_BRANCH')
		string(defaultValue: 'beta/DAP-6416', description: '', name: 'SDK_BRANCH')}


  stages {

  	stage('SCM') {

		steps{
  		checkout([$class: 'GitSCM',
			  branches: [[name: 'test_pipeline']],
			  doGenerateSubmoduleConfigurations: false,
			  extensions: [[$class: 'SubmoduleOption', disableSubmodules: false, parentCredentials: true, recursiveSubmodules: true, reference: '', timeout: 15, trackingSubmodules: true]],
			  submoduleCfg: [],
			  userRemoteConfigs: [[credentialsId: 'c39b0118-cfc4-4024-ac99-cdf2f69ed733', url: 'ssh://git@coderepository.mcd.com:8443/gma5_us/android.git']]])
			}
  		}

        stage('Checkout') {
          steps {
            sh '''
	    MCDARCH_DIR=${WORKSPACE}
MCDAPPCORE_DIR="${MCDARCH_DIR}/libraries/android-mcd-core-app"
MCDUIKIT_DIR="${MCDARCH_DIR}/libraries/android-mcd-core-app/libraries/android-mcd-uikit"
MCDCONNECT_DIR="${MCDARCH_DIR}/libraries/android-mcd-core-app/libraries/android-gma-sdk-sapient"
			echo "*************Checking out McDAppARCH Repository*****************"
cd "${MCDARCH_DIR}"
git config -f .gitmodules submodule.libraries/android-mcd-core-app.branch beta/DAP-6416
git checkout beta/DAP-6416
git branch --set-upstream-to=origin/beta/DAP-6416 beta/DAP-6416
git pull
git config -f .gitmodules submodule.libraries/android-mcd-core-app.branch beta/DAP-6416
git submodule
git submodule init
git submodule sync
git config --get remote.origin.url
git submodule update --init --remote --recursive
git branch
#git submodule update --init --recursive libraries/android-mcd-core-app
git log --pretty=format:'%h' -n 1

echo "*************Checking out McDAppCore Repository*****************"
cd "${MCDARCH_DIR}"
cd "${MCDAPPCORE_DIR}"
git checkout beta/DAP-6416
git branch --set-upstream-to=origin/beta/DAP-6416 beta/DAP-6416
git pull
git config -f .gitmodules submodule.libraries/android-mcd-uikit.branch beta/DAP-6416
git config -f .gitmodules submodule.libraries/android-gma-sdk-sapient.branch beta/DAP-6416
#git submodule update --remote --recursive
git submodule
git submodule init
git submodule sync
git config --get remote.origin.url
git submodule update --init --remote --recursive
git branch
git branch
git reset --hard
#git pull
#git submodule update --checkout --recursive
git checkout beta/DAP-6416
git log --pretty=format:'%h' -n 1




#echo "*************Checking out McDonaldsSDK Repository*****************"
cd "${MCDARCH_DIR}"
git config -f .gitmodules submodule.libraries/android-gma-sdk-sapient.branch beta/DAP-6416
cd "${MCDCONNECT_DIR}"
git gc --prune=now
git checkout beta/DAP-6416
git pull
git branch
git reset --hard
#git pull
#git submodule update --checkout --recursive
#git checkout ${ARCH_BRANCH}
#git log --pretty=format:'%h' -n 1

#echo "*************Checking out McDUIKit Repository*****************"
cd "${MCDARCH_DIR}"
cd "${MCDUIKIT_DIR}"
git gc --prune=now
git checkout beta/DAP-6416
git pull
git branch
git reset --hard
#git pull
#git submodule update --checkout --recursive
#git checkout ${ARCH_BRANCH}
#git log --pretty=format:'%h' -n 1'''
          }
        }


   stage('Build') {
      steps {
        sh '''
	  #run build
	  ./gradlew clean assembleQARelease
	 '''
    }
    }

/*stage('Test') {
      steps {
        sh './gradlew cleanTest test jacocoTestReport --continue --info'
      }
    }
*/

    stage('Hockeyapp') {
    	steps {
    			step([$class: 'HockeyappRecorder',
    			applications: [[apiToken: 'd90ccdd12e7440518048400adee5bb23',
    			downloadAllowed: false,
    			filePath: 'app/build/outputs/apk/app-QA-release.apk',
    			mandatory: false,
    			notifyTeam: false,
    			releaseNotesMethod: [$class: 'NoReleaseNotes'],
    			uploadMethod: [$class: 'AppCreation', publicPage: false]]],
    			debugMode: false,
    			failGracefully: false])
    	 	 }
}
    }
 /*	post {

		success {

			emailext (
          		subject: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
          		body: """<p>SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
          		  <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>""",
         		recipientProviders: [[$class: 'rushikesh.jawali@capgemini.com']]
				)

		}


	        failure {

			emailext (
          		subject: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
          		body: """<p>FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
          		  <p>Check console output at &QUOT;<a href='${env.BUILD_URL}'>${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>&QUOT;</p>""",
          		recipientProviders: [[$class: 'rushikesh.jawali@capgemini.com']]
       			 	)
            
        }
    } */
}
