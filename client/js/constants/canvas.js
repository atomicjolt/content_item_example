import wrapper from "./constants_wrapper";
import _       from "lodash";

const CanvasMethods = {
  //ADMINS
  "ACCOUNT_ADMINS": Network.GET,
  "REMOVE_ADMINS": Network.DEL,
  //ANALYTICS
  "ACCOUNT_TERM_ANALYTICS": Network.GET,
  "ACCOUNT_CURRENT_ANALYTICS": Network.GET,
  "ACCOUNT_COMPLETED_ANALYTICS": Network.GET,
      //grades
  "ACCOUNT_TERM_ANALYTICS_GRADES": Network.GET,
  "ACCOUNT_CURRENT_ANALYTICS_GRADES": Network.GET,
  "ACCOUNT_COMPLETED_ANALYTICS_GRADES": Network.GET,
      //statistics
  "ACCOUNT_TERM_ANALYTICS_STATISTICS": Network.GET,
  "ACCOUNT_CURRENT_ANALYTICS_STATISTICS": Network.GET,
  "ACCOUNT_COMPLETED_ANALYTICS_STATISTICS": Network.GET,
      //course-level
  "COURSE_ANALYTICS": Network.GET,
  "COURSE_ANALYTICS_ASSIGNMENTS": Network.GET,
  "COURSE_ANALYTICS_STUDENT_ID": Network.GET,
  "COURSE_ANALYTICS_STUDENT_ASSIGNMENTS": Network.GET,
  "COURSE_ANALYTICS_STUDENT_MESSAGE": Network.GET,
  //EXTERNAL FEEDS
  "COURSE_EXTERNAL_FEEDS": Network.GET,
  "GROUP_EXTERNAL_FEEDS": Network.GET,
  "COURSE_EXTERNAL_FEED": Network.DEL,
  "GROUP_EXTERNAL_FEED": Network.DEL,
  //APPOINTMENT GROUP
  "LIST_APPOINTMENT_GROUPS": Network.GET,
  "CREATE_APPOINTMENT_GROUP": Network.POST,
  "SINGLE_APPOINTMENT_GROUP": Network.GET,
  "UPDATE_APPOINTMENT_GROUPS": Network.PUT,
  "DELETE_APPOINTMENT_GROUP": Network.DEL,
  "LIST_USER_PARTICIPANTS": Network.GET,
  "STUDENT_GROUP_PARTICIPANTS": Network.GET,
  // ASSIGNMENT GROUP
  "COURSE_ASSIGNMENT_GROUPS": Network.GET,
  "COURSE_ASSIGNMENT_SINGLE_GROUP": Network.GET,
  "COURSE_ASSIGNMENT_SINGLE_GROUP_EDIT": Network.PUT,
  "COURSE_ASSIGNMENT_SINGLE_GROUP_DEL": Network.DEL,
   //ASSIGNMENT OVERRIDE
  "LIST_OVERRIDE_ASSIGNMENT": Network.GET,
  "OVERRIDE_ASSIGNMENT": Network.GET,
  "LIST_OVERRIDE_ASSIGNMENT_GROUP": Network.GET,
  //ASSIGNMENTS
  "DELETE_ASSIGNMENT": Network.DEL,
  "LIST_ASSIGNMENT": Network.GET,
  "SINGLE_ASSIGNMENT": Network.GET,
  "EDIT_ASSIGNMENT": Network.PUT,
  //COURSE
  "COURSES_PER_USER": Network.GET,
  "COURSES_SINGLE_USER": Network.GET,
  "STUDENTS_IN_COURSE": Network.GET,
  "USERS_IN_COURSE": Network.GET,
  "SEARCH_USERS_IN_COURSE": Network.GET,
  "RECENT_STUDENTS_IN_COURSE": Network.GET,
  "GET_SINGLE_USER": Network.GET,
  "COURSE_ACTIVITY_STREAM": Network.GET,
  "COURSE_ACTIVITY_STREAM_SUMMARY": Network.GET,
  "COURSE_TODO_ITEMS": Network.GET,
  "CONCLUDE_COURSE": Network.DEL,
  "COURSE_SETTINGS": Network.GET,
  "UPDATE_COURSE_SETTINGS": Network.PUT,
  "GET_SINGLE_COURSE": Network.GET,
  "GET_SINGLE_COURSE_FROM_ACCOUNT": Network.GET,
  "UPDATE_SINGLE_COURSE": Network.PUT,
  "UPDATE_COURSES": Network.PUT,
  //SUBMISSIONS

};

const asyncActionTypes = _.map(CanvasMethods, (v, k) => {
  return k;
});
const actionTypes = [];

export { CanvasMethods };
export default wrapper(actionTypes, asyncActionTypes);
