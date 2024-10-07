using System.ComponentModel.DataAnnotations;

namespace WebApiStudent.Models
{
    public class CourseModels
    {
        public Int32? Id { get; set; }

        public string? Nombre { get; set; }

        public string? Descripcion { get; set; }
        public string? Docente { get; set; }

        public DateTime? FechaReg { get; set; }
    }
}
