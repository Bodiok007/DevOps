1. Create database: `use gymDatabase`

![CreateDatabase](https://github.com/Bodiok007/DevOps/blob/develop/MongoDB/Screenshots/CreateDatabase.png?raw=true)

3. Create collections:
```
db.createCollection("clients")
db.createCollection("memberships")
db.createCollection("workouts")
db.createCollection("trainers")
```

![CreateCollections](https://github.com/Bodiok007/DevOps/blob/develop/MongoDB/Screenshots/CreateCollections.png?raw=true)

3. Define structure of collection items by inserting one to each:
```
db.clients.insertOne({
  "client_id": 1,
  "name": "John Doe",
  "age": 30,
  "email": "john.doe@example.com"
})

db.memberships.insertOne({
  "membership_id": 101,
  "client_id": 1,
  "start_date": ISODate("2023-01-01"),
  "end_date": ISODate("2023-12-31"),
  "type": "Gold"
})

db.workouts.insertOne({
  "workout_id": 201,
  "description": "Cardio and Strength Training",
  "difficulty": "Intermediate"
})

db.trainers.insertOne({
  "trainer_id": 301,
  "name": "Alice Trainer",
  "specialization": "Personal Training"
})
```

![DefineStructure](https://github.com/Bodiok007/DevOps/blob/develop/MongoDB/Screenshots/DefineStructure.png?raw=true)

4. Insert more data to collections:
```
db.clients.insertMany([
  { "client_id": 2, "name": "Jane Smith", "age": 25, "email": "jane.smith@example.com" },
  { "client_id": 3, "name": "Bob Johnson", "age": 35, "email": "bob.johnson@example.com" },
  { "client_id": 4, "name": "Alice Brown", "age": 28, "email": "alice.brown@example.com" },
  { "client_id": 5, "name": "Charlie Green", "age": 32, "email": "charlie.green@example.com" }
])

db.memberships.insertMany([
  { "membership_id": 102, "client_id": 2, "start_date": ISODate("2023-02-01"), "end_date": ISODate("2023-11-30"), "type": "Silver" },
  { "membership_id": 103, "client_id": 3, "start_date": ISODate("2023-03-01"), "end_date": ISODate("2023-10-31"), "type": "Bronze" },
  { "membership_id": 104, "client_id": 4, "start_date": ISODate("2023-04-01"), "end_date": ISODate("2023-09-30"), "type": "Gold" },
  { "membership_id": 105, "client_id": 5, "start_date": ISODate("2023-05-01"), "end_date": ISODate("2023-08-31"), "type": "Silver" }
])

db.workouts.insertMany([
  { "workout_id": 202, "description": "Yoga and Flexibility", "difficulty": "Beginner" },
  { "workout_id": 203, "description": "HIIT Workout", "difficulty": "Advanced" },
  { "workout_id": 204, "description": "Pilates", "difficulty": "Intermediate" },
  { "workout_id": 205, "description": "Running Club", "difficulty": "Beginner" }
])

db.trainers.insertMany([
  { "trainer_id": 302, "name": "Bob Coach", "specialization": "CrossFit" },
  { "trainer_id": 303, "name": "Charlie Instructor", "specialization": "Yoga" },
  { "trainer_id": 304, "name": "David Fitness", "specialization": "HIIT" },
  { "trainer_id": 305, "name": "Eve Yoga", "specialization": "Pilates" }
])
```

![InsertMoreData](https://github.com/Bodiok007/DevOps/blob/develop/MongoDB/Screenshots/InsertMoreData.png?raw=true)

5. Find clients with age greater than 30:
```
db.clients.find({ "age": { $gt: 30 } })
```

![FindClients](https://github.com/Bodiok007/DevOps/blob/develop/MongoDB/Screenshots/FindClients.png?raw=true)

6. Find workouts with Intermidiate difficulty:
```
db.workouts.find({ "difficulty": "Intermediate" })
```

![FindWorkouts](https://github.com/Bodiok007/DevOps/blob/develop/MongoDB/Screenshots/FindWorkouts.png?raw=true)

7. Find membership for client with id equals 2:
```
db.memberships.find({ "client_id": 2 })
```

![FindMemberships](https://github.com/Bodiok007/DevOps/blob/develop/MongoDB/Screenshots/FindMemberships.png?raw=true)
