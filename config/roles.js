const allRoles = {
  user: [],
  patient: [],
  doctor: ['createDiagnose','updateDiagnose','deleteDiagnose','createAppointment','updateAppointment','deleteAppointment'],
  admin: ['getUsers', 'manageUsers'],
};

const roles = Object.keys(allRoles);
const roleRights = new Map(Object.entries(allRoles));

module.exports = {
  roles,
  roleRights,
};
  