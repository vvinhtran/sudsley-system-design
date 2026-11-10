# Sudsley Machine Service

The assignment is in [HOMEWORK.md](HOMEWORK.md).

This project is a simulated backend system for managing the state and operations of Sudsley washing machines. It includes a simple API handler, a data layer with caching, and clients for interacting with external services.

## Getting Started

Follow these steps to set up your local development environment.

### One-Time Setup

1.  **Install Node.js and npm**

    This project requires Node.js and its package manager, npm. We recommend using Node Version Manager (`nvm`) to install them, as it avoids permission issues and makes it easy to manage different Node.js versions.

    **On macOS, Linux, or other Unix-like systems:**

    a. Install `nvm` by running the following command in your terminal:
    ```bash
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
    ```

    b. Close and reopen your terminal to load `nvm` into your shell.

    c. Install the latest Long-Term Support (LTS) version of Node.js:
    ```bash
    nvm install --lts
    ```

    d. Verify the installation was successful:
    ```bash
    node -v
    npm -v
    ```

    For Windows or other installation methods, please refer to the official Node.js download page: https://nodejs.org/

2.  **Run the Setup Script**

    Once Node.js is installed, navigate to the project's root directory in your terminal and run the provided setup script. This script will install all necessary dependencies and run the test suite to verify that the environment is configured correctly.

    ```bash
    # Make the script executable (you only need to do this once)
    chmod +x setup.sh

    # Run the script
    ./setup.sh
    ```

    On Windows without bash, run `npm install` and then `npm test` instead of the script.

    If the script finishes with "Setup complete", dependencies are installed and the test suite
    ran. Until you implement
    `src/handler/api.ts`, most tests fail with "Not implemented"; that is expected.

## How to Run Tests

To run the full suite of unit and simulation tests at any time, execute the following command from the project root:

```bash
npm test
```

To run a specific test file, you can pass its path to the npm test command:
```bash
npm test -- test/api.test.ts
```

To run a single test, pass its name after the file path:
```bash
npm test -- test/api.test.ts -t "should reserve an available machine"
```