using System.Data.SqlClient;
using System.Data;
using WebApiStudent.Models;

namespace WebApiStudent.Data
{
    public class CourseData
    {
        private readonly string connection;

        public CourseData(IConfiguration configuration)
        {
            connection = configuration.GetConnectionString("stringSQL")!;

        }
        public async Task<List<CourseModels>> GetListCourses()
        {
            var lista = new List<CourseModels>();

            using (var conn = new SqlConnection(connection))
            {
                await conn.OpenAsync();
                SqlCommand cmd = new SqlCommand("SP_GET_MATERIAS", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                using (SqlDataReader rdr = await cmd.ExecuteReaderAsync())
                {
                    while (await rdr.ReadAsync())
                    {
                        lista.Add(new CourseModels
                        {
                            Id = Convert.ToInt32(rdr["Id"]),
                            Nombre = rdr["Nombre"].ToString(),
                            Descripcion = rdr["Descripcion"].ToString(),
                            Docente = rdr["Docente"].ToString(),
                            FechaReg = Convert.ToDateTime(rdr["FechaReg"])
                        });
                    }
                }
            }
            return lista;
        }

        public async Task<List<CourseModels>> GetListCoursesXEst(string numDoc)
        {
            //var course = new CourseModels();
            var lista = new List<CourseModels>();

            using (var conn = new SqlConnection(connection))
            {
                await conn.OpenAsync();
                SqlCommand cmd = new SqlCommand("SP_GET_MATXEST", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@NumDoc", numDoc));
                using (SqlDataReader rdr = await cmd.ExecuteReaderAsync())
                {
                    while (await rdr.ReadAsync())
                    {
                        lista.Add(new CourseModels
                        {
                            Id = Convert.ToInt32(rdr["Id"]),
                            Nombre = rdr["Nombre"].ToString(),
                            Descripcion = rdr["Descripcion"].ToString(),
                            Docente = rdr["Docente"].ToString(),
                            FechaReg = Convert.ToDateTime(rdr["FechaReg"])
                        });
                    }
                }
            }
            return lista;
        }

        public async Task<List<string>> GetStudentXCouses(Int32 idCourse)
        {
            var lista = new List<string>();

            using (var conn = new SqlConnection(connection))
            {
                await conn.OpenAsync();
                SqlCommand cmd = new SqlCommand("SP_GET_ESTUDIANTESXMAT", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@IdMateria", idCourse));
                using (SqlDataReader rdr = await cmd.ExecuteReaderAsync())
                {
                    while (await rdr.ReadAsync())
                    {
                        string? item = rdr["nombreCompleto"].ToString();
                        if (!string.IsNullOrEmpty(item))
                        {
                            lista.Add(item);
                        }
                    }
                }
            }
            return lista;
        }

        public async Task<bool> InsertCoursesXEst(string numDoc, string idMateria)
        {
            using (var conn = new SqlConnection(connection))
            {
                SqlCommand cmd = new SqlCommand("SP_INSERT_MATXEST", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@NumDoc", numDoc));
                cmd.Parameters.Add(new SqlParameter("@IdMateria", idMateria));

                try
                {
                    await conn.OpenAsync();
                    return await cmd.ExecuteNonQueryAsync() > 0 ? true : false;
                }
                catch (Exception exec)
                {
                    return false;
                }

            }
        }

        public async Task<bool> DeleteCourseXDoc(int id, string numDoc)
        {
            using (var conn = new SqlConnection(connection))
            {
                SqlCommand cmd = new SqlCommand("SP_DELETE_MATXEST", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@id", id));
                cmd.Parameters.Add(new SqlParameter("@numDoc", numDoc));
                try
                {
                    await conn.OpenAsync();
                    return await cmd.ExecuteNonQueryAsync() > 0 ? true : false;
                }
                catch (Exception)
                {
                    return false;
                }
            }
        }
    }
}
