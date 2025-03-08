# TronBox CICD

This repository demonstrates how to develop, test, and deploy TRON smart contracts using TronBox and GitHub Actions for continuous integration and deployment (CI/CD). The project includes:

- A sample Solidity contract (`SimpleStorage.sol`)
- Migration scripts for deployment
- Unit tests using the TronBox framework
- A GitHub Actions workflow to automatically:
  - Install dependencies
  - Compile and test the contracts on the Nile testnet
  - Deploy the contracts to Nile if tests pass

## Features

- **Smart Contract Development**: Write, compile, and test TRON contracts in Solidity using TronBox.
- **Automated Testing**: Every push or pull request to `main` triggers a workflow that runs the test suite.
- **Continuous Deployment**: Successful tests automatically trigger deployment to the TRON Nile network.
- **Secure Secrets**: Private keys and node URLs are stored as GitHub Secrets and passed as environment variables.

## Requirements

- Node.js (v20 or higher recommended)
- TronBox globally or as a dev dependency (installed via `npm install` in this project)
- Git for version control
- A GitHub repository with Actions enabled

## Project Structure

```bash
tronbox-CICD
├── contracts/
│   ├── SimpleStorage.sol        # Example Solidity contract
│   ├── Migrations.sol           # Example Migration contract
├── migrations/
│   ├── 1_initial_migration.js   # Tracks TronBox migrations
│   ├── 2_deploy_contracts.js    # Deploy script for SimpleStorage
├── test/
│   └── SimpleStorage.test.js    # Example tests
├── tronbox.js                   # TronBox config (network definitions)
├── package.json                 # Node dependencies & scripts
└── .github/workflows/
    └── tron.yml                 # GitHub Actions CI/CD pipeline

```
# Installation & Local Usage
Clone the Repository
```bash
git clone https://github.com/aziz1975/tronbox-CICD.git
cd tronbox-CICD
```
Install Dependencies
```bash
npm install
```
Compile Contracts
```bash
npx tronbox compile
```
# Run Tests
By default, if you run npx tronbox test, it uses the development network in tronbox.js (if defined). To explicitly use Nile (if you’ve configured it and provided environment variables locally), run:

```bash
npx tronbox test --network nile
```
Deploy Manually (Optional)
```bash
npx tronbox deploy --network nile
```
# GitHub Actions CI/CD for Tron Contracts

This repository uses GitHub Actions to automate the build, test, and deployment processes for Tron smart contracts. The workflow is defined in the `.github/workflows/tron.yml` file.

## Workflow Overview

### Triggers
- **Push to `main` branch**
- **Pull requests targeting the `main` branch**

### Jobs

#### `build-and-test` Job
1. **Checkout the code**: Fetches the latest code from the repository.
2. **Set up Node.js**: Uses Node.js version 20 for the build and test processes.
3. **Install dependencies**: Installs all project dependencies using `npm install`.
4. **Compile contracts**: Compiles the smart contracts.
5. **Run tests**: Executes tests against the Nile testnet. This step requires the following secrets:
   - `PRIVATE_KEY_NILE`: The private key of your wallet for testing on Nile.
   - `FULL_NODE_NILE`: The URL of the Nile testnet node (usually `https://nile.trongrid.io`).
6. **Upload artifacts**: Uploads the build artifacts (compiled contracts, `node_modules`, etc.) to GitHub for reuse in the `deploy` job.

#### `deploy` Job (runs only if tests pass)
1. **Download artifacts**: Downloads the build artifacts from the `build-and-test` job.
2. **Set up Node.js**: Uses Node.js version 20 for the deployment process.
3. **Deploy contracts**: Deploys the contracts to the Nile testnet using `tronbox deploy --network nile`. This step also consumes the `PRIVATE_KEY_NILE` and `FULL_NODE_NILE` secrets.

## Important Note 
If you encounter the ‘ERROR: No contract or not a valid smart contract’ message in the GitHub Actions logs, simply rerun the jobs. Occasionally, a network glitch causes this error.

## Setting Up GitHub Secrets

To ensure secure handling of sensitive data, you need to set up the following secrets in your GitHub repository:

1. Go to your repository’s **Settings**.
2. Click on **Secrets and variables > Actions**.
3. Add the following secrets:
   - `PRIVATE_KEY_NILE`: The private key of your wallet for testing on Nile.
   - `FULL_NODE_NILE`: The URL of the Nile testnet node (usually `https://nile.trongrid.io`).

These secrets are injected into the environment at runtime, preventing exposure of sensitive data in the repository.

## Deployment Notes

- **Multiple Deployments**: The pipeline will deploy the contracts once during testing (TronBox auto-deploys for tests) and once again in the `deploy` job. If you want to avoid multiple deployments to Nile, consider pointing your tests to a local development network or using a separate test account.
  
- **Verifying on Nile Explorer**: After a successful deployment, you can verify the transaction on Nile’s block explorer.

## Contributing

Feel free to open issues or submit pull requests for any improvements or bug fixes. Please ensure that your changes are well-tested and documented.
