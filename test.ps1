$service_name="HelloWorld"

$outputDirectory = Get-Location

# Write-Host docker build --build-arg "APP_NAME=$service_name,BUILD_PATH=output"  -t "$service_name`:latest" .
# docker build --build-arg "APP_NAME=$service_name,BUILD_PATH=output"  -t "$service_name`:latest" .

# New-Item -Path "$build_path" -Name "$service_name" -ItemType Directory


Copy "$outputDirectory\deploy\application.yml" "$outputDirectory\application.yml"

(Get-Content "$outputDirectory\application.yml") -Replace "<name>", "$service_name" | Set-Content "$outputDirectory\application.yml"