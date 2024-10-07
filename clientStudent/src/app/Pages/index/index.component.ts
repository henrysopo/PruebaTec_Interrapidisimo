import { Component, inject } from '@angular/core';
import {MatCardModule} from '@angular/material/card';
import {MatTableModule} from '@angular/material/table';
import {MatIconModule} from '@angular/material/icon';
import {MatButtonModule} from '@angular/material/button';
import { StudentService } from '../../Services/student.service';
import { Student } from '../../Models/Student';
import { Route, Router } from '@angular/router';

import {MatFormFieldModule} from '@angular/material/form-field';
import { FormBuilder, FormControl, FormGroup, ReactiveFormsModule } from '@angular/forms';
import {MatSelectModule} from '@angular/material/select';
import {MatInputModule} from '@angular/material/input';
import { Course } from '../../Models/Course';

@Component({
  selector: 'app-index',
  standalone: true,
  imports: [MatCardModule,MatTableModule,MatIconModule,MatButtonModule,MatFormFieldModule,MatInputModule,MatSelectModule,ReactiveFormsModule],
  templateUrl: './index.component.html',
  styleUrl: './index.component.css'
})
export class IndexComponent {
private studentService=inject(StudentService);
public formBuild = inject(FormBuilder);
public listStudents:Student[]=[];
public displayedColumns:string[] =['tipoDoc','numeroDocumento','fechaNacimiento','primerNombre','segundoNombre','primerApellido','segundoApellido','direccion','numeroCelular','email','accion'];
public formIndex:FormGroup=this.formBuild.group({
  numeroDocumento:[''],
  idCourseSel:['']
});
public buttonDisabled = true;

getStudents(){
  this.studentService.listStudent().subscribe({
    next:(data)=>{
      if(data.length>0){
        this.listStudents=data;
        this.buttonDisabled=true;
      }
    },
    error:(err)=>{
      console.log(err.message)
    }
  })
}

getStudent(){
  this.listStudents = [];
  var numDoc = this.formIndex.value.numeroDocumento;
  if(numDoc){
    this.studentService.getStudent(numDoc).subscribe({
      next:(data)=>{
        if(data[0].tipoDoc != null){
          this.buttonDisabled=false;
          this.listStudents=data;
        }
        else{
          alert("El número de documento (" + numDoc + ") no se encuentra registrado en el sistema")
          this.buttonDisabled=true;
        }
    },
      error:(err)=>{
        console.log(err.message)
      }
    })
  }
  else{
    this.buttonDisabled=true;
  }
}
constructor(private router:Router){}

nuevo(){
  this.router.navigate(['/student']);
}

editar(student:Student){
  var tipoDoc1 = student.tipoDoc;
  var numDoc1 = student.numeroDocumento;
  this.router.navigate(['/student/', {tipoDoc: tipoDoc1, numeroDocumento: numDoc1}]);
}

eliminar(student:Student){
  if(confirm("Seguro que desea eliminar al estudiante " + student.primerNombre + " " + student.primerApellido + " ?")){
    this.studentService.deleteStudent(student.tipoDoc, student.numeroDocumento).subscribe({
      next:(data)=>{
        if(data.isSucces){
          this.getStudents();
        }else{
          alert("Registro del estudiante NO se pudo eliminar")
        }
      },
      error:(err)=>{
        console.log(err.message)
      }
    })
  }
}

registroMaterias(){
  var numDoc = this.formIndex.value.numeroDocumento;
  var nomCompleto = this.listStudents[0].primerNombre +" "+ 
                    this.listStudents[0].segundoNombre + " " +
                    this.listStudents[0].primerApellido + " " +
                    this.listStudents[0].segundoApellido;
   this.router.navigate(['/course/', {numeroDocumento: numDoc, nombreCompleto: nomCompleto}]);
}

}