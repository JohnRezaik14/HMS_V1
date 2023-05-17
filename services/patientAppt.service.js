const statusCode = require("http-status");
const { Doctor, ClinicsSkd } = require("../models");
const { Op } = require("sequelize");
const ApiError = require("../utils/ApiError");
const { doctorService, clinicsSkdService } = require("../services");

// services
// create appointment
// get upcoming appointments
// get completed appointments
// get cancelled appointments
// cancel appointment
// update appointment
// get appointment by doctor id















// Make Patient Appointment() >> POST 

//  parameters :
//   Patinetid
//   scheduleID 
// 	patientComplaint
// 	Date 
// ***********************************************************
// Get Upcoming Appointments (PatientId)
// return list of objects(Upcoming Appointments) 
// each appointment has the follwing data :

//   final String id;
//   final String hospitalName;
//   final String doctorName;
//   final String department;
//   final String departmentImageUrl;
//   final String? departmentImageHash;
//   final String date;
//   final String startTime;
//   final String endTime;
// ************************************************************
// Get Completed Appointments (PatientId)
// return list of objects(Completed Appointments) 
// each appointment has the follwing data :

//   final String id;
//   final String hospitalName;
//   final String doctorName;
//   final String department;
//   final String departmentImageUrl;
//   final String? departmentImageHash;
//   final String date;
//   final String startTime;
//   final String endTime;
// ************************************************************
// Get Cancelled Appointments (PatientId)
// return list of objects(Cancelled Appointments) 
// each appointment has the follwing data :

//   final String id;
//   final String hospitalName;
//   final String doctorName;
//   final String department;
//   final String departmentImageUrl;
//   final String? departmentImageHash;
//   final String date;
//   final String startTime;
//   final String endTime;
// ************************************************************
// Cancel Appointmet (AppointmentId , String CancelReason) >> POST