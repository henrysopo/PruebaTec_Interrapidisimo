import { Routes } from '@angular/router';
import { IndexComponent } from './Pages/index/index.component';
import { StudentComponent } from './Pages/student/student.component';
import { CourseComponent } from './Pages/course/course.component';

export const routes: Routes = [
    {path:'',component:IndexComponent},
    {path:'index',component:IndexComponent},
    {path:'student',component:StudentComponent},
    {path:'student/:typeCod/:numDoc',component:StudentComponent},
    {path:'course',component:CourseComponent}
];
