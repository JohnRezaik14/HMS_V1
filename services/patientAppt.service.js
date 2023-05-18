const statusCode = require("http-status");
const { Doctor, ClinicsSkd } = require("../models");
const { Op } = require("sequelize");
const ApiError = require("../utils/ApiError");
const { string } = require("joi");
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

const createAppointment = async (appointmentBody) => {
  const {
    clinicsSkdId,
    patientId,
    date,
    patientComplaint,
    note,
    cancelReason,
  } = appointmentBody;
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
  const doctorName = stringConcat("Dr.", doctor.firstName, doctor.lastName);
  const hospitalName = doctor.hospitalId;
  const departmentId = doctor.departmentId;
  const doctorImageUrl = doctor.imageUrl;
  const doctorImageHash = doctor.imageHash;
  const apptState = "upcoming";
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

const getUpcomingAppointments = async (patientId) => {
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

const getCompletedAppointments = async (patientId) => {
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

const getCancelledAppointments = async (patientId) => {
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
    const {
        clinicsSkdId,
        patientId,
        date,
        patientComplaint,
        note,
        cancelReason,
    } = apptBody;
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
    const doctorName = stringConcat("Dr.", doctor.firstName, doctor.lastName);
    const hospitalName = doctor.hospitalId;
    const departmentId = doctor.departmentId;
    const doctorImageUrl = doctor.imageUrl;
    const doctorImageHash = doctor.imageHash;
    const apptState = "upcoming";
    const report = null;
    const updatedAppointment = await PatientAppt.update({
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
    return updatedAppointment;
};


const deleteAppointment = async (apptId) => {
    const appointment = await PatientAppt.findByPk(apptId);
    if (!appointment) {
        throw new ApiError(statusCode.NOT_FOUND, "Appointment not found");
    }
    const deletedAppointment = await PatientAppt.destroy({
        where: {
            apptId: apptId,
        }
    });
    return deletedAppointment;
};
const getAppointmentsByDoctorIdByState = async (doctorId, state) => {
    const appointments = await PatientAppt.findAll({
        where: {
            doctorId: doctorId,
            apptState: state,
        },
        order: [
            ["date", "DESC"],
            ["startTime", "DESC"],
        ],
    });

    return appointments;
};
const getAppointmentsByDoctorId = async (doctorId,option) => {
    const option = option;
    let appointments = [];
    switch (option) {
        case "upcoming":
            appointments = await getAppointmentsByDoctorIdByState(doctorId,"upcoming");
            break;
            case "completed":
                appointments = await getAppointmentsByDoctorIdByState(doctorId,"completed");
                break;
                case "cancelled":
                    appointments = await getAppointmentsByDoctorIdByState(doctorId,"cancelled");
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
            appointments = await PatientAppt.findAll({
                where: {
                    doctorId: doctorId,
                },
                order: [
                    ["date", "DESC"],
                    ["startTime", "DESC"],
                ],
            });
          break;
      }
   
    return appointments;
}

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

    
