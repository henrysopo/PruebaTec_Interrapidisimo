using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using WebApiStudent.Data;
using WebApiStudent.Models;

namespace WebApiStudent.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class StudentController : ControllerBase
    {
        private readonly StudentData _studentData;
        public StudentController(StudentData studentData)
        {
            _studentData = studentData;
        }
        [HttpGet("GetTypeDoc")]
        public async Task<IActionResult> GetTypeDoc()
        {
            List<TypeDocModels> tiposDoc = await _studentData.GetTypeDoc();

            return StatusCode(StatusCodes.Status200OK, tiposDoc);
        }

        [HttpGet]
        public async Task<IActionResult> GetListStudents()
        {
            List<StudentModels> listaEstudiantes = await _studentData.GetListStudents();

            return StatusCode(StatusCodes.Status200OK, listaEstudiantes);
        }

        [HttpGet("{numDoc}")]
        public async Task<IActionResult> GetStudentsXDoc(string numDoc)
        {
            //StudentModels estudiante = await _studentData.GetStudentsXDoc(numDoc);
            List<StudentModels> listaEstudiante = await _studentData.GetStudentsXDoc(numDoc);

            return StatusCode(StatusCodes.Status200OK, listaEstudiante);
        }

        [HttpPost]
        public async Task<IActionResult> SaveStudent([FromBody] StudentModels student)
        {
            bool result = await _studentData.SaveStudent(student);

            return StatusCode(StatusCodes.Status200OK, new { isSucces = result });
        }

        [HttpPut]
        public async Task<IActionResult> EditStudent([FromBody] StudentModels student)
        {
            bool result = await _studentData.EditStudent(student);

            return StatusCode(StatusCodes.Status200OK, new { isSucces = result });
        }

        [HttpDelete("{typeDoc}/{numDoc}")]
        public async Task<IActionResult> DeleteStudent(string typeDoc, string numDoc)
        {
            bool result = await _studentData.DeleteStudentsXDoc(typeDoc, numDoc);

            return StatusCode(StatusCodes.Status200OK, new { isSucces = result });
        }
    }
}
