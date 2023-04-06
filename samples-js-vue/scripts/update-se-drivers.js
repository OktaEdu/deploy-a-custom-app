const { execSync, execFileSync, spawnSync } = require('child_process');

function getOS() {
  let os = process.platform;
  if (os === 'darwin') {
    os = 'MacOS';
  } else if (os === 'win32' || os === 'win64') {
    os = 'Windows';
  } else if (os === 'linux') {
    os = 'Linux';
  }
  return os;
}

const os = getOS();
console.log(`Operating System - ${os}`);

let chromeVersion;
if (os === 'MacOS') {
  const chromeVersionString = execSync('/Applications/Google\\ Chrome.app/Contents/MacOS/Google\\ Chrome --version').toString();
  // Get the major and minor version of the chrome version using regex (1 or more digits followed by a dot followed by 1 or more digits)
  const matchIndex = 0;
  chromeVersion = chromeVersionString.match(/(\d+(\.\d+)?)/)[matchIndex];
} else {
  chromeVersion = execSync('google-chrome --product-version').toString();
}

const chromeMajorVersion = chromeVersion.split('.')[0];
console.log(`Chrome Major Version - ${chromeMajorVersion}`);

const chromeDriverUrl = `https://chromedriver.storage.googleapis.com/LATEST_RELEASE_${chromeMajorVersion}`;

const {stdout: chromeDriverVersion, stderr: errorResponse} = spawnSync('curl', [chromeDriverUrl], { encoding : 'utf8' });

if(!chromeDriverVersion) {
    console.log("ERROR: ",errorResponse);
}
else {
    console.log(`Chrome Driver Version - ${chromeDriverVersion}`);
    try {
    execFileSync(`${__dirname}/../node_modules/protractor/bin/webdriver-manager`, ["update",  "--versions.chrome", chromeDriverVersion, "--gecko", "false", "--versions.standalone", "latest"]);
    console.log('Webdriver was updated');
} catch (err) {
    console.log(err);
  };
}