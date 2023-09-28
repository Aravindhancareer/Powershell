# Install the RestSharp library.
Install-Module RestSharp

# Get the cluster IP of the Kubernetes pod.
$clusterIP = kubectl get service my-service -o jsonpath='{.status.loadBalancer.ingress[0].ip}'

# Get the path to the .zip file.
$zipFilePath = "C:\path\to\my.zip"

# Generate a UUID for the `clientIdentifier` header.
$clientIdentifier = [System.Guid]::NewGuid().ToString()

# Create the RestSharp client.
$client = New-Object RestSharp.RestClient

# Set the base URL.
$client.BaseUrl = "http://$clusterIP:8080"

# Create the request.
$request = New-Object RestSharp.RestRequest("/container/{containerid}/apps")

# Add the `containerId` and `clientIdentifier` headers to the request.
$request.AddHeader("containerId", "my-container-id")
$request.AddHeader("clientIdentifier", $clientIdentifier)

# Add the request body to the request.
$file = New-Object RestSharp.Parameter
$file.Name = "appPackage"
$file.Value = [System.IO.File]::OpenRead($zipFilePath)
$request.AddParameter($file)

# Execute the request and get the response.
$response = $client.Post($request)

# Check the response status code.
if ($response.StatusCode -eq 200) {
    # The app was created successfully.
    Write-Host "The app was created successfully."
} else {
    # An error occurred while creating the app.
    Write-Host "An error occurred while creating the app: $response.StatusCode"
}
