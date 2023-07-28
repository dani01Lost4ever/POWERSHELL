# Function to get a random number between 1 and 5
function Get-RandomNumber {
    return Get-Random -Minimum 1 -Maximum 6
}

# Prompt the user to enter a number
$userNumber = Read-Host "Enter a number between 1 and 5"

# Validate the user input
if ($userNumber -match '^[1-5]$') {
    # Generate a random number
    $randomNumber = Get-RandomNumber

    # Display the random number for reference
    Write-Host "Random number generated: $randomNumber"

    # Check if the user's number matches the random number
    if ($userNumber -eq $randomNumber) {
        Write-Host "Congratulations! You won!"
    } else {
        Write-Host "Sorry, you lost!"
        # You can add code here to initiate the shutdown process if desired
        # For example, you can uncomment the line below to turn off the PC:
        # Stop-Computer -Force
    }
} else {
    Write-Host "Invalid input. Please enter a number between 1 and 5."
}
