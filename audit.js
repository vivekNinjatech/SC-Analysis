// const { exec } = require('child_process');
// const path = require('path');

// // Path to your Solidity contract
// const contractPath = path.join('/app', 'contracts', 'MyContract.sol');

// // Run Slither command using child_process
// exec(`slither ${contractPath}`, (error, stdout, stderr) => {
//     if (error) {
//         console.error(`Error running Slither: ${error.message}`);
//         return;
//     }
//     if (stderr) {
//         console.error(`Slither stderr: ${stderr}`);
//         return;
//     }

//     // Output the results from Slither
//     console.log(`Slither Output:\n${stdout}`);
// });




const { exec } = require('child_process');
const path = require('path');

// Path to your Solidity contract
const contractPath = path.join('/app', 'contracts', 'MyContract.sol');

// Run Slither command using child_process
exec(`slither ${contractPath}`, (error, stdout, stderr) => {
    // Define the result object with default values
    let result = {
        error: false,
        message: '',
        issues: '',
        comments: ''
    };

    try {
        if (error) {
            result.error = true;
            result.message = `Error running Slither: ${error.message}`;
            result.comments = `stderr: ${stderr}`;
            console.log(result);
            return;
        }
        
        if (stderr) {
            // Check for specific error patterns in stderr
            if (/error|failed|exception/i.test(stderr)) {
                result.error = true;
                result.message = `Slither stderr: ${stderr}`;
                result.comments = `stderr: ${stderr}`;
                console.log(result);
                return;
            }
            // If stderr contains non-error information
            result.message = 'Slither informational output';
            result.comments = `stderr: ${stderr}`;
        }

        // Set result with Slither's stdout
        result.message = 'Slither analysis completed successfully';
        result.issues = stdout;
        result.comments += `\nstdout: ${stdout}`;
        console.log(result);
    } catch (err) {
        // Handle unexpected errors
        result.error = true;
        result.message = `Unexpected error: ${err.message}`;
        result.comments = `Exception details: ${err.stack}`;
        console.log(result);
    }
});
