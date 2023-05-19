const statusCode = require("http-status");
const { Patient, Doctor, ClinicsSkd, PatientAppt } = require("../models");
const { Op, STRING } = require("sequelize");
const ApiError = require("../utils/ApiError");

const moment = require("moment-timezone");
// const { doctorService, clinicsSkdService } = require("../services");

// services
// create appointment done
// get upcoming appointments done
// get completed appointments done
// get cancelled appointments done
// return all descinding order by date then start time done
// cancel appointment take reason done
// update appointment same as reschedule done
// get appointment by doctor id
// delete appointment if was created by mistake
const getPatientIdByUserId = async (userId) => {
  const patinet = await Patient.findOne({ where: { userId: userId } });
  if (!patinet) {
    throw new ApiError(
      statusCode.NOT_FOUND,
      "UserId not valid , does not refer to any patient"
    );
  }
  return patinet.patientId;
};
const createAppointment = async (appointmentBody) => {
  const dateStr = appointmentBody.date;
  const timeZone = moment.tz.guess();
  const localDate = moment(dateStr).tz(timeZone).toDate();
  const date = localDate;
  const {
    clinicsSkdId,
    patientComplaint,
    note,
    // cancelReason,
  } = await appointmentBody;
  const patientId = await getPatientIdByUserId(appointmentBody.userId);
  const oldAppointment = await PatientAppt.findAll({
    where: {
      patientId: patientId,
      date: date,
      clinicsSkdId: clinicsSkdId,
    },
  });
  // console.log(oldAppointment + "oldAppointment");
  if (oldAppointment.length > 0) {
    throw new ApiError(
      statusCode.BAD_REQUEST,
      "Appointment already exists , you must select another date or clinics skd"
    );
  }

  const clinicsSkd = await ClinicsSkd.findByPk(clinicsSkdId);
  if (!clinicsSkd) {
    throw new ApiError(
      statusCode.NOT_FOUND,
      "Clinics Skd not found , you must select valid clinics skd "
    );
  }
  const doctor = await Doctor.findByPk(clinicsSkd.doctorId);
  const startTime = clinicsSkd.startTime;
  const endTime = clinicsSkd.endTime;
  const doctorName = "Dr." + doctor.firstName + " " + doctor.lastName;
  const hospitalName = doctor.hospitalName;
  const departmentId = doctor.departmentId;
  const doctorImageUrl = doctor.imageUrl;
  const doctorImageHash = doctor.imageHash;
  const apptState = "upcoming";
  const cancelReason = null;
  const report = null;
  const appointment = await PatientAppt.create({
    patientId,
    clinicsSkdId,
    date,
    startTime,
    endTime,
    doctorName,
    hospitalName,
    departmentId,
    doctorImageUrl,
    doctorImageHash,
    apptState,
    report,
    patientComplaint,
    note,
    cancelReason,
  });
  return appointment;
};

const getUpcomingAppointments = async (userId) => {
  const patientId = await getPatientIdByUserId(userId);
  const appointments = await PatientAppt.findAll({
    where: {
      patientId: patientId,
      apptState: "upcoming",
    },
    order: [
      ["date", "DESC"],
      ["startTime", "DESC"],
    ],
  });

  return appointments;
};

const getCompletedAppointments = async (userId) => {
  const patientId = await getPatientIdByUserId(userId);
  const appointments = await PatientAppt.findAll({
    where: {
      patientId: patientId,
      apptState: "completed",
    },
    order: [
      ["date", "DESC"],
      ["startTime", "DESC"],
    ],
  });

  return appointments;
};

const getCancelledAppointments = async (userId) => {
  const patientId = await getPatientIdByUserId(userId);
  const appointments = await PatientAppt.findAll({
    where: {
      patientId: patientId,
      apptState: "cancelled",
    },
    order: [
      ["date", "DESC"],
      ["startTime", "DESC"],
    ],
  });

  return appointments;
};

const cancelAppointment = async (apptId, cancelReason) => {
  const appointment = await PatientAppt.findByPk(apptId);
  if (!appointment) {
    throw new ApiError(statusCode.NOT_FOUND, "Appointment not found");
  }
  const updatedAppointment = await PatientAppt.update({
    apptState: "cancelled",
    cancelReason: cancelReason,
  });
  return updatedAppointment;
};
const updateAppointment = async (apptId, apptBody) => {
  const appointment = await PatientAppt.findByPk(apptId);
  if (!appointment) {
    throw new ApiError(statusCode.NOT_FOUND, "Appointment not found");
  }
  const clinicsSkdId = apptBody.clinicsSkdId;
  const clinicsSkd = await ClinicsSkd.findByPk(clinicsSkdId);
  if (!clinicsSkd) {
    throw new ApiError(
      statusCode.NOT_FOUND,
      "Clinics Skd not found , you must select valid clinics skd "
    );
  }
  const doctor = await Doctor.findByPk(clinicsSkd.doctorId);
  console.log(doctor);
  const startTime = clinicsSkd.startTime;
  const endTime = clinicsSkd.endTime;
  const doctorName = "Dr." + doctor.firstName + " " + doctor.lastName;
  const hospitalName = doctor.hospitalName;
  const departmentId = doctor.departmentId;
  const doctorImageUrl = doctor.imageUrl;
  const doctorImageHash = doctor.imageHash;
  const apptState = apptBody.apptState || "upcoming";
  const patientComplaint =
    apptBody.patientComplaint || appointment.patientComplaint;
  const cancelReason = apptBody.cancelReason || appointment.cancelReason;
  const report = apptBody.report || appointment.report;
  const note = apptBody.note || appointment.note;
  const patientId = apptBody.patientId || appointment.patientId;
  const date = apptBody.date || appointment.date;

  const updatedAppointment = await {
    patientId,
    clinicsSkdId,
    date,
    startTime,
    endTime,
    doctorName,
    hospitalName,
    departmentId,
    doctorImageUrl,
    doctorImageHash,
    apptState,
    report,
    patientComplaint,
    note,
    cancelReason,
  };
  Object.assign(appointment, updatedAppointment);
  await appointment.save();
  return appointment;
};

const deleteAppointment = async (apptId) => {
  const appointment = await PatientAppt.findByPk(apptId);
  if (!appointment) {
    throw new ApiError(statusCode.NOT_FOUND, "Appointment not found");
  }
  const deletedAppointment = await PatientAppt.destroy({
    where: {
      apptId: apptId,
    },
  });
  return deletedAppointment;
};
// clinicsskd that contain the same doctor id
const clincsSkdsByDoctorId = async (doctorId) => {
  const clinicsSkds = await ClinicsSkd.findAll({
    where: {
      doctorId: doctorId,
    },
  });
  return clinicsSkds;
};
const getAppointmentsByDoctorIdByState = async (doctorId, state) => {
  const clinicsSkds = await clincsSkdsByDoctorId(doctorId);
  const clinicsSkdsIds = clinicsSkds.map(
    (clinicsSkd) => clinicsSkd.clinicsSkdId
  );

  const appointments = await PatientAppt.findAll({
    where: {
      clinicsSkdId: {
        [Op.in]: clinicsSkdsIds,
      },
      apptState: state,
    },
    order: [
      ["date", "DESC"],
      ["startTime", "DESC"],
    ],
  });

  return appointments;
};
const getAppointmentsByDoctorId = async (doctorId, option) => {
  // const option = option;
  let appointments = [];
  switch (option) {
    case "upcoming":
      appointments = await getAppointmentsByDoctorIdByState(
        doctorId,
        "upcoming"
      );
      if (appointments.length === 0) {
        throw new ApiError(
          statusCode.NOT_FOUND,
          "You have no upcoming appointments "
        );
      }
      break;
    case "completed":
      appointments = await getAppointmentsByDoctorIdByState(
        doctorId,
        "completed"
      );
      if (appointments.length === 0) {
        throw new ApiError(
          statusCode.NOT_FOUND,
          "You have no completed appointments "
        );
      }
      break;
    case "cancelled":
      appointments = await getAppointmentsByDoctorIdByState(
        doctorId,
        "cancelled"
      );
      if (appointments.length === 0) {
        throw new ApiError(
          statusCode.NOT_FOUND,
          "You have no cancelled appointments "
        );
      }
      break;
    //             case "date":
    //      appointments = await PatientAppt.findAll({
    //         where: {
    //             doctorId: doctorId,
    //         },
    //         order: [
    //             ["date", "DESC"],
    //             ["startTime", "DESC"],
    //         ],
    //     });

    //   break;
    default:
      const clinicsSkds = await clincsSkdsByDoctorId(doctorId);
      const clinicsSkdsIds = clinicsSkds.map(
        (clinicsSkd) => clinicsSkd.clinicsSkdId
      );
    
       appointments = await PatientAppt.findAll({
        where: {
          clinicsSkdId: {
            [Op.in]: clinicsSkdsIds,
          },
          
        },
        order: [
          ["date", "DESC"],
          ["startTime", "DESC"],
        ],
      });
      break;
  }

  return appointments;
};

module.exports = {
  createAppointment,
  getUpcomingAppointments,
  getCompletedAppointments,
  getCancelledAppointments,
  updateAppointment,
  cancelAppointment,
  deleteAppointment,
  getAppointmentsByDoctorId,
};
