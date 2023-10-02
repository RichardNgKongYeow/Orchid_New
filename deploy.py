import subprocess
import re

# Define the command to run the deployment script
deploy_command = "npx hardhat run scripts/deploy.js --network mumbai"

try:
    # Run the deployment command and capture the output
    deployment_result = subprocess.run(deploy_command, shell=True, text=True, capture_output=True, check=True)

    # Extract contract addresses from the deployment output
    output_lines = deployment_result.stdout.splitlines()

    orchid_registry_address = None
    orchid_master_address = None

    for line in output_lines:
        # Extract OrchidRegistry address
        if "OrchidRegistry address:" in line:
            orchid_registry_address = re.search(r"0[xX][0-9a-fA-F]+", line).group()

        # Extract OrchidMaster address
        if "OrchidMaster address:" in line:
            orchid_master_address = re.search(r"0[xX][0-9a-fA-F]+", line).group()

    if orchid_registry_address and orchid_master_address:
        # Define the network and verification commands
        network = "mumbai"
        verify_registry_command = f"npx hardhat verify --network {network} {orchid_registry_address}"
        verify_master_command = f"npx hardhat verify --constructor-args arguments.js --network {network} {orchid_master_address}"

        # Verify OrchidRegistry contract
        result_registry = subprocess.run(verify_registry_command, shell=True, check=True, text=True, capture_output=True)
        
        # Verify OrchidMaster contract with constructor arguments
        constructor_args_script = "arguments.js"  # Replace with your actual arguments script
        result_master = subprocess.run(verify_master_command, shell=True, check=True, text=True, capture_output=True)

        # Print the verification outputs
        print("Verification Output - OrchidRegistry:")
        print(result_registry.stdout)

        print("\nVerification Output - OrchidMaster:")
        print(result_master.stdout)
    else:
        print("Contract addresses not found in the deployment output.")

except subprocess.CalledProcessError as e:
    # Handle verification errors
    print("Verification Error:")
    print(e.stderr)
except Exception as e:
    # Handle other exceptions
    print("An error occurred:")
    print(str(e))
