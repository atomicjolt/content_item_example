//
// Quiz Submission Events
//
// Submit captured events
// Store a set of events which were captured during a quiz taking session.
// 
// On success, the response will be 204 No Content with an empty body.
//
// API Docs: https://canvas.instructure.com/doc/api/quiz_submission_events.html
// API Url: courses/{course_id}/quizzes/{quiz_id}/submissions/{id}/events
//
// Example:
// const query = {
//   quiz_submission_events (required)
// }
// return canvasRequest(submit_captured_events, {course_id, quiz_id, id}, query);
export const submit_captured_events = { type: "SUBMIT_CAPTURED_EVENTS", method: "post", reducer: 'quiz_submission_events'};

// Retrieve captured events
// Retrieve the set of events captured during a specific submission attempt.
//
// API Docs: https://canvas.instructure.com/doc/api/quiz_submission_events.html
// API Url: courses/{course_id}/quizzes/{quiz_id}/submissions/{id}/events
//
// Example:
// const query = {
//   attempt
// }
// return canvasRequest(retrieve_captured_events, {course_id, quiz_id, id}, query);
export const retrieve_captured_events = { type: "RETRIEVE_CAPTURED_EVENTS", method: "get", reducer: 'quiz_submission_events'};