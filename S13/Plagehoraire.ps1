$users = Import-Csv -Path "C:\Users\Administrator\Documents\Utilisateur.csv" | Select-Object -Skip 1

foreach ($user in $users) {
    $username = $user.Name  
    net user $username /times:M-F,7:30AM-8:00PM
}
