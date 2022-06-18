$data = Import-Csv .\sample.csv

$data[-1..1]


# Filter data
# fetch records where salary grade starts with A

$data | Where-Object {
    $_.SalaryGrade -like 'A*'
}

$data | Where-Object {
    $_.SalaryGrade -like 'A*' -and $_.Department -like 'CS'
}


# replace operation
$data | ForEach-Object {
    if( $_.SalaryGrade -like 'A*' ){ $_.SalaryGrade = 'High' }
    elseif ( $_.SalaryGrade -like 'B*' ){ $_.SalaryGrade = 'Medium' }
}


# Adding a new row

$new_row = [PSCustomObject]@{
    EmployeeName     = 'NewName'
    Role = 'PowerShell'
    Department    = 'Platform'
	SalaryGrade = 'Highest'
}

$exp_data = $data + $new_row


# Adding a new column
$my_employees_data = @()
$exp_data | ForEach-Object {

    if($_.Department -like 'Sales'){
        
        $record = [PSCustomObject]@{
            EmployeeName     =  $_.EmployeeName
            Role = $_.Role
            Department    = $_.Department
	        SalaryGrade = $_.SalaryGrade
            Group =  'Non-Technical'
        }

    } else {
        $record = [PSCustomObject]@{
            EmployeeName     =  $_.EmployeeName
            Role = $_.Role
            Department    = $_.Department
	        SalaryGrade = $_.SalaryGrade
            Group =  'Technical'
        }    
    }

    $my_employees_data = $my_employees_data + $record
}


# Removing columns
$exp_data = $my_employees_data | Select-Object *

$exp_data 


# Export data to CSV
$exp_data | Export-Csv -Path 'sample.csv' -NoTypeInformation