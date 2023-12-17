# mysql  Ver 8.0.35-0ubuntu0.22.04.1 for Linux on x86_64 ((Ubuntu))

## Dump

Can be found in [MySQLDump](https://github.com/Bodiok007/DevOps/blob/develop/MySQLDump/MySQLDump%20Ver%208.0.35-0ubuntu0.22.04.1%20for%20Linux%20on%20x86_64%20((Ubuntu)).sql).

## Queries

1. All projects with emoloyee:
```
SELECT p.ProjectName, e.FirstName, e.LastName
FROM Project p
LEFT JOIN Employee e on e.EmployeeId = p.ProjectManagerId;
```

2. All tasks for particular project with employee of tasks:
```
SELECT t.TaskName, p.ProjectName, e.FirstName, e.LastName
FROM Task t
LEFT JOIN Project p on p.ProjectID = t.ProjectID
LEFT JOIN Employee e on e.EmployeeID = t.AssignedToID;
```

3. Avarage and maximum time of pojects completion:
```
SELECT AVG(DATEDIFF(EndDate, StartDate)) AS AverageTimeCompletion, MAX(DATEDIFF(EndDate, StartDate)) as MaxTimeCompletion
FROM Project;
```
