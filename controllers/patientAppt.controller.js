const patientApptService = require("../services/patientAppt.service");
const statusCode = require("http-status");
const ApiError = require("../utils/ApiError");
const catchAsync = require("../utils/catchAsync");

const createAppointment = catchAsync(async (req, res) => {
  const appointment = await patientApptService.createAppointment(req.body);
  res.status(statusCode.CREATED).send({
    appointment,
    statusCode: 201,
    message: "Appointment created successfully",
  });
});

const getUpcomingAppointments = catchAsync(async (req, res) => {
  const appointments = await patientApptService.getUpcomingAppointments(
    req.body.userId
  );
  if (appointments.length === 0) {
    throw new ApiError(
      statusCode.NOT_FOUND,
      "You have no upcoming appointments"
    );
  }
  res.send({
    appointments,
    statusCode: 200,
    message: "Appointments data retrieved successfully",
  });
});

const getCompletedAppointments = catchAsync(async (req, res) => {
  const appointments = await patientApptService.getCompletedAppointments(
    req.body.userId
  );
  if (appointments.length === 0) {
    throw new ApiError(
      statusCode.NOT_FOUND,
      "You have no completed appointments"
    );
  }
  res.send({
    appointments,
    statusCode: 200,
    message: "Appointments data retrieved successfully",
  });
});

const getCancelledAppointments = catchAsync(async (req, res) => {
  const appointments = await patientApptService.getCancelledAppointments(
    req.body.userId
  );
  if (appointments.length === 0) {
    throw new ApiError(
      statusCode.NOT_FOUND,
      "You have no cancelled appointments"
    );
  }
  res.send({
    appointments,
    statusCode: 200,
    message: "Appointments data retrieved successfully",
  });
});

const cancelAppointment = catchAsync(async (req, res) => {
  const appointment = await patientApptService.cancelAppointment(
    req.body.apptId
  );
  if (!appointment) {
    throw new ApiError(statusCode.NOT_FOUND, "Appointment not found");
  }
  res.send({
    appointment,
    statusCode: 200,
    message: "Appointment cancelled successfully",
  });
});

const updateAppointment = catchAsync(async (req, res) => {
  const appointment = await patientApptService.updateAppointment(
    req.body.apptId,
    req.body
  );
  if (!appointment) {
    throw new ApiError(statusCode.NOT_FOUND, "Appointment not found");
  }
  res.send({
    appointment,
    statusCode: 200,
    message: "Appointment updated successfully",
  });
});

const deleteAppointment = catchAsync(async (req, res) => {
    const appointment = await patientApptService.deleteAppointment(
        req.body.apptId
    );
    if (!appointment) {
        throw new ApiError(statusCode.NOT_FOUND, "Appointment not found");
    }
    res.send({
        appointment,
        statusCode: 200,
        message: "Appointment deleted successfully",
    });
}
);

const getAppointmentsByDoctorId = catchAsync(async (req, res) => {
    const appointments = await patientApptService.getAppointmentsByDoctorId(
        req.body.doctorId , req.body.option
    );
    if (appointments.length === 0) {
        throw new ApiError(statusCode.NOT_FOUND, "No appointments found");
    }
    res.send({
        appointments,
        statusCode: 200,
        message: "Appointments data retrieved successfully",
    });
}
);

module.exports = {
    createAppointment,
    getUpcomingAppointments,
    getCompletedAppointments,
    getCancelledAppointments,
    cancelAppointment,
    updateAppointment,
    deleteAppointment,
    getAppointmentsByDoctorId
};


