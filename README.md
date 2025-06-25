# TronBox CICD

This repository demonstrates how to develop, test, and deploy TRON smart contracts using TronBox and GitHub Actions for continuous integration and deployment (CI/CD). The project includes:

* A sample Solidity contract (`SimpleStorage.sol`)
* Migration scripts for deployment
* Unit tests using the TronBox framework
* A GitHub Actions workflow to automatically:

  * Install dependencies
  * Compile and test the contracts on the Nile testnet
  * Deploy the contracts to Nile if tests pass

## Features

* **Smart Contract Development**: Write, compile, and test TRON contracts in Solidity using TronBox.
* **Automated Testing**: Every push or pull request to `main` triggers a workflow that runs the test suite.
* **Continuous Deployment**: Successful tests automatically trigger deployment to the TRON Nile network.
* **Secure Secrets**: Private keys and node URLs are stored as GitHub Secrets and passed as environment variables.
* **Security Analysis**: Integrates Slither static analyzer for Solidity smart contracts.

## Requirements

* Node.js (v20 or higher recommended)
* TronBox globally or as a dev dependency (installed via `npm install` in this project)
* Git for version control
* Slither analyzer installed (`pip install slither-analyzer`)
* A GitHub repository with Actions enabled

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

## Installation & Local Usage

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

## Run Tests

By default, if you run `npx tronbox test`, it uses the development network in `tronbox.js` (if defined). To explicitly use Nile (if you’ve configured it and provided environment variables locally), run:

```bash
npx tronbox test --network nile
```

## Deploy Manually (Optional)

```bash
npx tronbox deploy --network nile
```

## GitHub Actions CI/CD for Tron Contracts

This repository uses GitHub Actions to automate the build, test, and deployment processes for Tron smart contracts. The workflow is defined in the `.github/workflows/tron.yml` file.

### Workflow Overview

#### Triggers

* **Push to `main` branch**
* **Pull requests targeting the `main` branch**

#### Jobs

##### `build-and-test` Job

1. **Checkout the code**
2. **Set up Node.js** (version 20)
3. **Install dependencies**
4. **Compile contracts**
5. **Run tests** against Nile testnet (requires GitHub secrets)
6. **Upload artifacts**

##### `deploy` Job (runs only if tests pass)

1. **Download artifacts**
2. **Set up Node.js**
3. **Deploy contracts** to Nile

## Using Slither Static Analyzer

To enhance the security and quality of your smart contracts, this project integrates Slither—a Solidity static analysis tool.

### Installation

Install Slither globally or within your virtual environment:

```bash
pip install slither-analyzer
```

### Running Slither

To analyze your contracts, run:

```bash
slither contracts/SimpleStorage.sol
```

Slither outputs detailed reports highlighting potential vulnerabilities, coding mistakes, and optimization suggestions.

### Integrate Slither in GitHub Actions

Add the following step in your `tron.yml` workflow to automate Slither analysis:

```yaml
- name: Run Slither static analysis
  run: |
    pip install slither-analyzer
    slither contracts/
```

## Important Note

If you encounter the ‘ERROR: No contract or not a valid smart contract’ message in the GitHub Actions logs, simply rerun the jobs. Occasionally, a network glitch causes this error.

## Setting Up GitHub Secrets

To securely handle sensitive data, set the following secrets in your GitHub repository:

1. Go to your repository’s **Settings**.
2. Click on **Secrets and variables > Actions**.
3. Add the following secrets:

   * `PRIVATE_KEY_NILE`: Private key for Nile testnet.
   * `FULL_NODE_NILE`: URL of the Nile testnet node (`https://nile.trongrid.io`).

## Deployment Notes

* **Multiple Deployments**: The pipeline deploys contracts once during testing and again in the deploy job. Consider using local networks for tests to avoid multiple Nile deployments.
* **Verification**: Verify deployments via Nile’s block explorer.

## Contributing

Feel free to open issues or submit pull requests for improvements or bug fixes. Ensure changes are thoroughly tested and documented.
