/* Keep your existing full course list below this line. This file only applies the latest verified corrections. */
window.COURSES = window.COURSES || [];
window.COURSES = window.COURSES.filter(x => !(x.code === 'BSD308' && x.level === 'Level 3' && x.group === 'Elective Courses'));
for (const program of ['Computer Science','Information Systems']) {
  if (!window.COURSES.some(x => x.program === program && x.code === 'BSD234')) window.COURSES.push({program,level:'Level 2',group:'Elective Courses',code:'BSD234',name:'Partial Differential Equation and its numerical solution'});
}
for (const x of window.COURSES) if (x.code === 'CSD445') { x.level='Level 4'; x.group=x.program === 'Computer Science' ? 'Elective Courses' : 'Second Semester'; }
window.COURSES.sort((a,b)=>`${a.program}|${a.level}|${a.group}|${a.code}`.localeCompare(`${b.program}|${b.level}|${b.group}|${b.code}`));
