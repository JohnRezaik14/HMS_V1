const allRoles = {
  user: [],
  patient: [],
  doctor: [getUser, updateUser,getUsers,createDiagnose,updateDiagnose,deleteDiagnose,createPrescription,updatePrescription,deletePrescription,createAppointment,updateAppointment,deleteAppointment],
  admin: ['getUsers', 'manageUsers'],
};

const roles = Object.keys(allRoles);
const roleRights = new Map(Object.entries(allRoles));

module.exports = {
  roles,
  roleRights,
};
  