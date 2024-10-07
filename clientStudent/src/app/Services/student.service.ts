import { HttpClient } from '@angular/common/http';
import { Injectable, inject} from '@angular/core';
import { appsettings } from '../settings/appsettings';
import { Student } from '../Models/Student';
import { Course } from '../Models/Course';
import { ResponseAPI } from '../Models/ResponseAPI';

@Injectable({
  providedIn: 'root'
})
export class StudentService {

  private http = inject(HttpClient);
  private apiUrl:string=appsettings.apiUrl + "Student";
  private apiUrl2:string=appsettings.apiUrl + "Course";
  private apiUrl3:string=appsettings.apiUrl + "Course/GetStudentXCouses"; 
  constructor() {}

  listStudent(){
    return this.http.get<Student[]>(this.apiUrl);
  }

  getStudent(numDoc:string){
    return this.http.get<Student[]>(`${this.apiUrl}/${numDoc}`);
  }

  saveStudent(student:Student){
    return this.http.post<ResponseAPI>(this.apiUrl,student);
  }

  editStudent(student:Student){
    return this.http.put<ResponseAPI>(this.apiUrl,student);
  }

  deleteStudent(typeDoc:string, numDoc:string){
    return this.http.delete<ResponseAPI>(`${this.apiUrl}/${typeDoc}/${numDoc}`);
  }

  listCourses(){
    return this.http.get<Course[]>(this.apiUrl2);
  }

  listCoursesXEst(numDoc:string){
    return this.http.get<Course[]>(`${this.apiUrl2}/${numDoc}`);
  }

  deleteCourse(id:number, numDoc:string){
    return this.http.delete<ResponseAPI>(`${this.apiUrl2}/${id}/${numDoc}`);
  }

  addCourse(idMat:number, numDoc:string){
    return this.http.post<ResponseAPI>(`${this.apiUrl2}?numDoc=${numDoc}&idMateria=${idMat}`, null);
  }

  listStudentsxCourse(idCourse:number){
    return this.http.get<string[]>(`${this.apiUrl3}?idCourse=${idCourse}`);
  }
}
