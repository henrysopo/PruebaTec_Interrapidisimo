using System.ComponentModel.DataAnnotations;

namespace WebApiStudent.Models
{
    public class StudentModels
    {
        public string? TipoDoc { get; set; }

        public string? NumeroDocumento { get; set; }

        public DateTime? FechaNacimiento { get; set; }

        public string? PrimerNombre { get; set; }
        public string? SegundoNombre { get; set; }

        public string? PrimerApellido { get; set; }

        public string? SegundoApellido { get; set; }

        public string? Direccion { get; set; }

        public string? NumeroCelular { get; set; }

        public string? Email { get; set; }

        public DateTime? FechaReg { get; set; }
    }
}
