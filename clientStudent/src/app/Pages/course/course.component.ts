import { Component, Inject, inject, Input, OnInit } from '@angular/core';
import { StudentService } from '../../Services/student.service';
import { FormBuilder, FormControl, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import {MatFormFieldModule} from '@angular/material/form-field';
import {MatSelectModule} from '@angular/material/select';
import {MatInputModule} from '@angular/material/input';
import {MatButtonModule} from '@angular/material/button';
import { Course } from '../../Models/Course';
import {MatIconModule} from '@angular/material/icon';
import {MatCardModule} from '@angular/material/card';
import {MatTableModule} from '@angular/material/table';
import {
  MatDialog,
  MAT_DIALOG_DATA,
  MatDialogRef,
  MatDialogTitle,
  MatDialogContent,
  MatDialogActions,
  MatDialogClose,
  MatDialogModule
} from '@angular/material/dialog';

export interface DialogData {
  idMateria: number;
  resultado: string;
}

@Component({
  selector: 'app-course',
  standalone: true,
  imports: [MatFormFieldModule,
            MatSelectModule,
            MatInputModule,
            MatButtonModule,
            ReactiveFormsModule,
            MatCardModule,
            MatTableModule,
            MatIconModule,
            MatDialogTitle,
            MatDialogContent,
            MatDialogActions,
            MatDialogClose, MatButtonModule, MatDialogModule,
          ],
  templateUrl: './course.component.html',
  styleUrl: './course.component.css'
})
export class CourseComponent implements OnInit{
 @Input('numeroDocumento')numDocStudent!:string;
 @Input('nombreCompleto')nomCompletoStudent!:string;

 private studentService=inject(StudentService);
 public listCourse:Course[]=[];
 public fullListCourse:Course[]=[]; 
 public displayedColumns:string[] =['id','nombre','descripcion', 'docente', 'accion'];
 public displayedColumns2:string[] =['nombreCompleto'];
 public formBuild = inject(FormBuilder);
 public contMateriasXEst:number = 0;
 public listStudentsCourse:string[]=[];
 public listStudentsCourse2:string[]=[];
 public formCourse:FormGroup=this.formBuild.group({
  numeroDocumento:[''],
  nombreEstudiante:[''],
  idCourseSel:['']
});
constructor(private router:Router,public dialog: MatDialog) {
}
ngOnInit(): void {
  this.formCourse.controls['numeroDocumento'].disable();
  this.formCourse.controls['nombreEstudiante'].disable();
  if(this.numDocStudent){
    this.formCourse.patchValue({
      numeroDocumento:this.numDocStudent,
      nombreEstudiante:this.nomCompletoStudent
    })
    this.getCourses();    
  }
}
  getCourses(){
    this.listCourse = [];
    this.contMateriasXEst=0;
    var numDoc =  this.numDocStudent;
    this.studentService.listCoursesXEst(numDoc).subscribe({
      next:(data)=>{
        if(data.length>0){
          this.contMateriasXEst=data.length;
          this.listCourse=data;
        }
        else {
          alert("El estudiante con documento " + numDoc + " No tiene materias asignadas.");
        }
      },
      error:(err)=>{
        console.log(err.message)
      }
    });
    this.studentService.listCourses().subscribe({
      next:(data)=>{
        if(data.length>0){
          this.fullListCourse=data;
        }
        else {
          alert("No existen materias configuradas en el sistema");
        }
      },
      error:(err)=>{
        console.log(err.message)
      }
    })
  }

GoBack(){
  this.router.navigate(["/"]);
}

eliminar(course:Course){
  var numDoc = this.numDocStudent;
  if(confirm("Seguro que desea eliminar el curso " + course.nombre + ", de sus materias asociadas? ")){
    this.studentService.deleteCourse(course.id, numDoc).subscribe({
      next:(data)=>{
        if(data.isSucces){
          this.getCourses();
        }else{
          alert("No se pudo eliminar el curso")
        }
      },
      error:(err)=>{
        console.log(err.message)
      }
    })
  }
}

addCourses(){
  var idNewCourse = this.formCourse.value.idCourseSel;
  var numDoc = this.numDocStudent;
  var existeDocente = false;
  if(this.contMateriasXEst <3){  
    this.fullListCourse.forEach(course => {
      if(course.id ==  idNewCourse){
        this.listCourse.forEach(course2 => {
          if(course2.docente == course.docente){
            alert("El estudiante ya tiene asignada otra materia con el docente " + course2.docente);
            existeDocente = true;
            return;
          }
        })
      }
    })
    if(!existeDocente){
      this.studentService.addCourse(idNewCourse,numDoc).subscribe({
        next:(data)=>{
          if(data.isSucces){
            this.getCourses();
          }else{
            alert("No se pudo agregar el curso seleccionado.")
          }
        },
        error:(err)=>{
          console.log(err.message)
        }
      })
    }
  }
  else{
    alert("El estudiante con documento " + numDoc + " ya cuenta con las " + this.contMateriasXEst + " materias asignadas.");
  }  
}

consultarEstXMateria(course:Course){
  this.studentService.listStudentsxCourse(course.id).subscribe({
    next:(data)=>{
      if(data.length>0){
        this.listStudentsCourse=data;
        this.listStudentsCourse2=data;
        alert("Prueba de ingreso 1 --Nombres de los estudiantes obtenidos: " + this.listStudentsCourse2.length);
      }
      else {
        alert("No hay estudiantes asociados a la materia indicada.");
      }
    },
    error:(err)=>{
      console.log(err.message)
    }
  });
  const dialogRef = this.dialog.open(DialogContentExampleDialog, {
    height: "calc(100% - 30px)",
    width: "calc(100% - 30px)",
    maxWidth: "100%",
    maxHeight: "100%",
    data:{
      listaEstXCurso: this.listStudentsCourse2
    }
  });
  dialogRef.afterClosed().subscribe(result => {
  console.log(`Dialog result: ${result}`);
  this.listStudentsCourse2 = result;
  });
} 

openDialog(course:Course) {
  const dialogRef = this.dialog.open(DialogContentExampleDialog, {
    height: "calc(100% - 30px)",
    width: "calc(100% - 30px)",
    maxWidth: "70%",
    maxHeight: "100%",
    data: {idMateria: course.id},
  });

  dialogRef.afterClosed().subscribe(result => {
    console.log('The dialog was closed');
    var resultadoPrueba = result;
  });      
  }
}

@Component({
  selector: 'courseDialog.component.html',
  templateUrl: 'courseDialog.component.html',
  standalone: true,
  imports: [MatDialogModule, MatButtonModule,
    MatFormFieldModule,
    MatSelectModule,
    MatInputModule,
    MatButtonModule,
    ReactiveFormsModule,
    MatCardModule,
    MatTableModule,
    MatIconModule,
    MatDialogTitle,
    MatDialogContent,
    MatDialogActions,
    MatDialogClose, MatButtonModule, MatDialogModule,
  ],
  styles: [`
    :host{
      display: flex;
      flex-direction: column;
      height: 100%;
    }
    mat-dialog-content{
      max-height: unset !important;
      flex: 1 0 0;
    }
  `]
})
export class DialogContentExampleDialog implements OnInit {
  @Input('idMateria')idCoursenew!:number;
  private studentService=inject(StudentService);
  public displayedColumns2:string[] =['nombreCompleto'];
  public listStudentsCourse2:string[]=[];
  constructor(
    public dialogRef: MatDialogRef<DialogContentExampleDialog>,
    @Inject(MAT_DIALOG_DATA) public data: DialogData,
  ) {}

  ngOnInit(): void {
    this.studentService.listStudentsxCourse(this.data.idMateria).subscribe({
      next:(data)=>{
        if(data.length>0){
          this.listStudentsCourse2=data;
        }
        else {
          alert("No hay estudiantes asociados a la materia indicada.");
        }
      },
      error:(err)=>{
        console.log(err.message)
      }
    });
  }

  onNoClick(): void {
    this.dialogRef.close();
  }
}