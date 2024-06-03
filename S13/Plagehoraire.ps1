$Ordinateurs = Import-Csv -Path "C:\Users\Administrator\Documents\Ordinateur.csv" | Select-Object -Skip 1

foreach ($ordi in $Ordinateurs) {
    $username = $user.Name  
    net user $username /times:M-F,7:30AM-8:00PM
}
