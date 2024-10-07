using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using WebApiStudent.Data;
using WebApiStudent.Models;

namespace WebApiStudent.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CourseController : ControllerBase
    {
        private readonly CourseData _courseData;
        public CourseController(CourseData courseData)
        {
            _courseData = courseData;
        }

        [HttpGet]
        public async Task<IActionResult> GetCourses()
        {
            List<CourseModels> cursos = await _courseData.GetListCourses();

            return StatusCode(StatusCodes.Status200OK, cursos);
        }

        [HttpGet("{numDoc}")]
        public async Task<IActionResult> GetCoursesXDoc(string numDoc)
        {
            List<CourseModels> cursos = await _courseData.GetListCoursesXEst( numDoc);

            return StatusCode(StatusCodes.Status200OK, cursos);
        }

        [HttpGet("GetStudentXCouses")]
        public async Task<IActionResult> GetStudentXCouses(Int32 idCourse)
        {
            List<string> cursos = await _courseData.GetStudentXCouses(idCourse);

            return StatusCode(StatusCodes.Status200OK, cursos);
        }

        [HttpPost]
        public async Task<IActionResult> SaveCoursesXEst(string numDoc, string idMateria)
        {
            bool result = await _courseData.InsertCoursesXEst(numDoc, idMateria);

            return StatusCode(StatusCodes.Status200OK, new { isSucces = result });
        }
        
        [HttpDelete("{id}/{numDoc}")]
        public async Task<IActionResult> DeleteCourse(int id, string numDoc)
        {
            bool result = await _courseData.DeleteCourseXDoc(id, numDoc);

            return StatusCode(StatusCodes.Status200OK, new { isSucces = result });
        }
    }
}
