Add-Content -Path ./Employees.csv  -Value '"FirstName","LastName","UserName"'
  $employees = @(cat 

  '"Adam","Bertram","abertram"'

  '"Joe","Jones","jjones"'

  '"Mary","Baker","mbaker"'

  )


  $employees | foreach { Add-Content -Path  ./Employees.csv -Value $_ }