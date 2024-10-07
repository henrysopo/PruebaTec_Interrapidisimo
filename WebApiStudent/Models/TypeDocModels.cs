using System.ComponentModel.DataAnnotations;

namespace WebApiStudent.Models
{
    public class TypeDocModels
    {
        [Required]
        [Display(Name = "Tipo Documento")]
        public string? TipoDoc { get; set; }

        [Required]
        [Display(Name = "Descripcion")]
        public string? Descripcion { get; set; }
    }
}
