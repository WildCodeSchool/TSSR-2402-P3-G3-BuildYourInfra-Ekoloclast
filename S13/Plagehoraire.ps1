$users = Get-ADUser -filter * | Select-object SamAccountName -Skip 1

foreach ($user in $users) {
    $username = $user.SamAccountName  
    net user $username /times:M-Sa,7:00-20:00
}
