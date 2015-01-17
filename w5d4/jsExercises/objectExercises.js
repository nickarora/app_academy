/*
var Cat = function(name, owner) {
  this.name = name;
  this.owner = owner;
};

Cat.prototype.cuteStatement = function(){
  return "Everyone loves " + this.name;
};

Cat.prototype.meow = function(){
  return "MEOEOEOEOEOEOE!"
};
*/

// students and courses

var Student = function(firstName, lastName) {
  this.firstName = firstName;
  this.lastName = lastName;
  this.courses = [];
};

Student.prototype.name = function() {
  return this.firstName + " Smelly " + this.lastName;
};

Student.prototype.enroll = function(course){
  this.courses.push(course);
};

Student.prototype.courseLoad = function(){
  var courseLoads = {};

  for(var i = 0; i < this.courses.length; i++){
    if (!courseLoads[ this.courses[i].department ]){
      courseLoads[ this.courses[i].department ] = this.courses[i].creds;
    } else {
      courseLoads[ this.courses[i].department ] += this.courses[i].creds;
    }

  }

  return courseLoads;
};

var Course = function(courseName, department, creds){
  this.courseName = courseName;
  this.department = department;
  this.creds = creds;
  this.students = [];
};

Course.prototype.addStudent = function(student) {
  this.students.push(student);
  student.enroll(this);
}


nick = new Student("Nick", "Aloha");
amit = new Student("Amit", "Super Sexy");

programming = new Course("programming", "CS", 1000);
farming = new Course("programming tractors", "Agro", 1000);
javascriptrocks = new Course("digging for rocks", "Geology", 1000);
logic = new Course("logic", "CS", 1000);


programming.addStudent(nick);
farming.addStudent(nick);
javascriptrocks.addStudent(nick);
logic.addStudent(nick);

console.log(programming.students);
