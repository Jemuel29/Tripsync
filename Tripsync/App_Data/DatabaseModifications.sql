-- Create Users table with roles
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Username NVARCHAR(50) NOT NULL UNIQUE,
    Password NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    Role NVARCHAR(20) NOT NULL CHECK (Role IN ('Passenger', 'Driver', 'Admin')),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    PhoneNumber NVARCHAR(20),
    CreatedDate DATETIME DEFAULT GETDATE(),
    IsActive BIT DEFAULT 1
);

-- Create Drivers table
CREATE TABLE Drivers (
    DriverID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT FOREIGN KEY REFERENCES Users(UserID),
    LicenseNumber NVARCHAR(50) NOT NULL,
    VehicleModel NVARCHAR(50) NOT NULL,
    VehicleNumber NVARCHAR(20) NOT NULL,
    IsAvailable BIT DEFAULT 1,
    CurrentLocation NVARCHAR(100),
    Rating DECIMAL(3,2) DEFAULT 5.0
);

-- Create Rides table
CREATE TABLE Rides (
    RideID INT PRIMARY KEY IDENTITY(1,1),
    PassengerID INT FOREIGN KEY REFERENCES Users(UserID),
    DriverID INT FOREIGN KEY REFERENCES Drivers(DriverID),
    PickupLocation NVARCHAR(200) NOT NULL,
    DropoffLocation NVARCHAR(200) NOT NULL,
    RequestTime DATETIME DEFAULT GETDATE(),
    PickupTime DATETIME,
    DropoffTime DATETIME,
    Status NVARCHAR(20) CHECK (Status IN ('Requested', 'Accepted', 'InProgress', 'Completed', 'Cancelled')),
    Fare DECIMAL(10,2),
    Distance DECIMAL(10,2),
    EstimatedDuration INT -- in minutes
);

-- Create Payments table
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    RideID INT FOREIGN KEY REFERENCES Rides(RideID),
    Amount DECIMAL(10,2) NOT NULL,
    PaymentDate DATETIME DEFAULT GETDATE(),
    PaymentMethod NVARCHAR(50),
    TransactionID NVARCHAR(100),
    Status NVARCHAR(20) CHECK (Status IN ('Pending', 'Completed', 'Failed', 'Refunded'))
);

-- Create RideRatings table
CREATE TABLE RideRatings (
    RatingID INT PRIMARY KEY IDENTITY(1,1),
    RideID INT FOREIGN KEY REFERENCES Rides(RideID),
    Rating DECIMAL(3,2) CHECK (Rating >= 1 AND Rating <= 5),
    Comment NVARCHAR(500),
    RatingDate DATETIME DEFAULT GETDATE()
); 