using System.ComponentModel.DataAnnotations;

namespace WebApiStudent.Models
{
    public class TeacherModels
    {
        [Required]
        [Display(Name = "Tipo Documento")]
        public string? TipoDoc { get; set; }

        [Required]
        [Display(Name = "Numero Documento")]
        public string? NumeroDocumento { get; set; }

        [Required]
        [Display(Name = "Fecha Nacimiento")]
        public DateTime? FechaNacimiento { get; set; }

        [Required]
        [Display(Name = "Primer Nombre")]
        public string? PrimerNombre { get; set; }

        [Required]
        [Display(Name = "Segundo Nombre")]
        public string? SegundoNombre { get; set; }

        [Required]
        [Display(Name = "Primer Apellido")]
        public string? PrimerApellido { get; set; }

        [Required]
        [Display(Name = "Segundo Apellido")]
        public string? SegundoApellido { get; set; }

        [Display(Name = "Fecha Registro")]
        public DateTime? FechaReg { get; set; }
    }
}
