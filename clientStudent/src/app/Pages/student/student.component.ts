import { Component, inject, Input, OnInit } from '@angular/core';
import {MatFormFieldModule} from '@angular/material/form-field';
import {MatSelectModule} from '@angular/material/select';
import {MatInputModule} from '@angular/material/input';
import {MatButtonModule} from '@angular/material/button';
import {FormBuilder,FormGroup,ReactiveFormsModule} from '@angular/forms';
import { StudentService } from '../../Services/student.service';
import {MatDatepickerModule} from '@angular/material/datepicker';

import { Student } from '../../Models/Student';
import { Router } from '@angular/router';

@Component({
  selector: 'app-student',
  standalone: true,
  imports: [MatFormFieldModule,MatSelectModule,MatInputModule,MatButtonModule,ReactiveFormsModule,MatDatepickerModule],
  templateUrl: './student.component.html',
  styleUrl: './student.component.css'
})
export class StudentComponent implements OnInit{
  @Input('tipoDoc')typeDocStudent!:string;
  @Input('numeroDocumento')numDocStudent!:string;
private studentService=inject(StudentService);
public formBuild = inject(FormBuilder);
public formStudent:FormGroup=this.formBuild.group({
  tipoDoc:[''],
  numeroDocumento:[''],
  fechaNacimiento:[''],
  primerNombre:[''],
  segundoNombre:[''],
  primerApellido:[''],
  segundoApellido:[''],
  direccion:[''],
  numeroCelular:[''],
  email:['']
});


constructor(private router:Router) {}

ngOnInit(): void {
  if(this.numDocStudent){
    this.studentService.getStudent(this.numDocStudent).subscribe({
      next:(data)=>{
        this.formStudent.patchValue({
          tipoDoc:data[0].tipoDoc,
          numeroDocumento:data[0].numeroDocumento,
          fechaNacimiento:data[0].fechaNacimiento,
          primerNombre:data[0].primerNombre,
          segundoNombre:data[0].segundoNombre,
          primerApellido:data[0].primerApellido,
          segundoApellido:data[0].segundoApellido,
          direccion:data[0].direccion,
          numeroCelular:data[0].numeroCelular,
          email:data[0].email
        })
      },
      error:(err)=>{
        console.log(err.message)
      }
    })
    this.formStudent.controls['tipoDoc'].disable();
    this.formStudent.controls['numeroDocumento'].disable();
  }
}

SaveStudent(){
const student:Student={
  tipoDoc:this.formStudent.value.tipoDoc,
  numeroDocumento:this.formStudent.value.numeroDocumento,
  fechaNacimiento:this.formStudent.value.fechaNacimiento,
  primerNombre:this.formStudent.value.primerNombre,
  segundoNombre:this.formStudent.value.segundoNombre,
  primerApellido:this.formStudent.value.primerApellido,
  segundoApellido:this.formStudent.value.segundoApellido,
  direccion:this.formStudent.value.direccion,
  numeroCelular:this.formStudent.value.numeroCelular,
  email:this.formStudent.value.email,
  fechaReg:new Date()
}
if(this.typeDocStudent){
  student.tipoDoc=this.typeDocStudent;
  student.numeroDocumento=this.numDocStudent;
  this.studentService.editStudent(student).subscribe({
    next:(data)=>{
      if(data.isSucces){
        this.router.navigate(["/"]);
      }
      else{
        alert("Error al editar los datos del estudiante")
      }
    }
  })
}
else{
  this.studentService.saveStudent(student).subscribe({
    next:(data)=>{
      if(data.isSucces){
        this.router.navigate(["/"]);
      }
      else{
        alert("Error al crear el nuevo estudiante")
      }
    }
  })
}}

EditStudent(){
  const student:Student={
    tipoDoc:this.formStudent.value.tipoDoc,
    numeroDocumento:this.formStudent.value.numeroDocumento,
    fechaNacimiento:this.formStudent.value.fechaNacimiento,
    primerNombre:this.formStudent.value.primerNombre,
    segundoNombre:this.formStudent.value.segundoNombre,
    primerApellido:this.formStudent.value.primerApellido,
    segundoApellido:this.formStudent.value.segundoApellido,
    direccion:this.formStudent.value.direccion,
    numeroCelular:this.formStudent.value.numeroCelular,
    email:this.formStudent.value.email,
    fechaReg:new Date()
  }
  this.studentService.editStudent(student).subscribe({
    next:(data)=>{
      if(data.isSucces){
        this.router.navigate(["/"]);
      }
      else{
        alert("Error al editar los datos del estudiante")
      }
    }
  })
  }

GoBack(){
  this.router.navigate(["/"]);
}

}
