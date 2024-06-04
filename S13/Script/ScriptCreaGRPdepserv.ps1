# Import-Module Active Directory module
Import-Module ActiveDirectory

# Define the path to the CSV file
$csvPath = "C:\Users\Administrator\Tssr\s09_Ekoloclast.csv"  # A modifier si besoin

$DomainDN = (Get-ADDomain).DistinguishedName


# Import the CSV file
$users = Import-Csv -Path $csvPath -Delimiter ";"

# Iterate over each user in the CSV
foreach ($user in $users) {
    $department = $user.Departement
    $service = $user.Service

    # Define the distinguished names (DN) for the OU and Sub-OU
    $ouDN = "OU=$department,OU=LabUtilisateurs,$DomainDN"
    $subOuDN = "OU=$service,OU=$department,OU=LabUtilisateurs,$DomainDN"

    # Define the group names
    $groupDepartment = "$department"
    $groupService = "$service"

    # Check if the department group exists, if not create it
    if (-not (Get-ADGroup -Filter "Name -eq '$groupDepartment'")) {
        New-ADGroup -Name $groupDepartment -Path $ouDN -GroupScope Global -GroupCategory Security
        Write-Host "Le groupe $groupDepartment a été créé avec succes dans l'OU $ouDN" -ForegroundColor Green
    }
    if ($service.Length -ge 3) {
        # Check if the service group exists, if not create it
        if ($service -and -not (Get-ADGroup -Filter "Name -eq '$groupService'")) {
            New-ADGroup -Name $groupService -Path $subOuDN -GroupScope Global -GroupCategory Security
            Write-Host "Le groupe $groupService a été créé avec succes dans l'OU $subOuDN" -ForegroundColor Green
        }
    }
}
