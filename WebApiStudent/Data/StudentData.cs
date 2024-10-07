using System.Data.SqlClient;
using System.Data;
using WebApiStudent.Models;

namespace WebApiStudent.Data
{
    public class StudentData
    {
        private readonly string connection;

        public StudentData(IConfiguration configuration)
        {
            connection = configuration.GetConnectionString("stringSQL")!;
            
        }

        public async Task<List<StudentModels>> GetListStudents()
        {
            var lista = new List<StudentModels>();

            using (var conn = new SqlConnection(connection))
            {
                await conn.OpenAsync();
                SqlCommand cmd = new SqlCommand("SP_GET_ESTUDIANTES", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                using (SqlDataReader rdr = await cmd.ExecuteReaderAsync())
                {
                    while (await rdr.ReadAsync())
                    {
                        lista.Add(new StudentModels
                        {
                            TipoDoc = rdr["TipoDoc"].ToString(),
                            NumeroDocumento = rdr["NumeroDocumento"].ToString(),
                            FechaNacimiento = Convert.ToDateTime(rdr["FechaNacimiento"]),
                            PrimerNombre = rdr["PrimerNombre"].ToString(),
                            SegundoNombre = rdr["SegundoNombre"].ToString(),
                            PrimerApellido = rdr["PrimerApellido"].ToString(),
                            SegundoApellido = rdr["SegundoApellido"].ToString(),
                            Direccion = rdr["Direccion"].ToString(),
                            NumeroCelular = rdr["NumeroCelular"].ToString(),
                            Email = rdr["Email"].ToString(),
                            FechaReg = Convert.ToDateTime(rdr["FechaReg"])
                        });
                    }
                }
            }
            return lista;
        }

        public async Task<List<TypeDocModels>> GetTypeDoc()
        {
            var lista = new List<TypeDocModels>();

            using (var conn = new SqlConnection(connection))
            {
                await conn.OpenAsync();
                SqlCommand cmd = new SqlCommand("SP_GET_TIPODOC", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                using (SqlDataReader rdr = await cmd.ExecuteReaderAsync())
                {
                    while (await rdr.ReadAsync())
                    {
                        lista.Add(new TypeDocModels
                        {
                            TipoDoc = rdr["TipoDoc"].ToString(),
                            Descripcion = rdr["Descripcion"].ToString()
                        });
                    }
                }
            }
            return lista;
        }

        public async Task<List<StudentModels>> GetStudentsXDoc(string numDoc)
        {
            var student = new StudentModels();
            var lista = new List<StudentModels>();

            using (var conn = new SqlConnection(connection))
            {
                await conn.OpenAsync();
                SqlCommand cmd = new SqlCommand("SP_GET_ESTUDIANTEXDOC", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                //cmd.Parameters.Add(new SqlParameter("@TipoDoc", typeDoc));
                cmd.Parameters.Add(new SqlParameter("@NumDoc", numDoc));
                //cmd.Parameters.AddWithValue("@TipoDoc", typeDoc);
                //cmd.Parameters.AddWithValue("@NumDoc", numDoc);
                using (SqlDataReader rdr = await cmd.ExecuteReaderAsync())
                {
                    if (await rdr.ReadAsync())
                    {
                        student.TipoDoc = rdr["TipoDoc"].ToString();
                        student.NumeroDocumento = rdr["NumeroDocumento"].ToString();
                        student.FechaNacimiento = Convert.ToDateTime(rdr["FechaNacimiento"]);
                        student.PrimerNombre = rdr["PrimerNombre"].ToString();
                        student.SegundoNombre = rdr["SegundoNombre"].ToString();
                        student.PrimerApellido = rdr["PrimerApellido"].ToString();
                        student.SegundoApellido = rdr["SegundoApellido"].ToString();
                        student.Direccion = rdr["Direccion"].ToString();
                        student.NumeroCelular = rdr["NumeroCelular"].ToString();
                        student.Email = rdr["Email"].ToString();
                        student.FechaReg = Convert.ToDateTime(rdr["FechaReg"].ToString());                       
                    }
                }
            }
            lista.Add(student);
            return lista;
        }

        public async Task<bool> SaveStudent(StudentModels student)
        {
            //var student = new StudentModels();

            using (var conn = new SqlConnection(connection))
            {
                SqlCommand cmd = new SqlCommand("SP_INSERT_ESTUDIANTE", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                //cmd.Parameters.Add(new SqlParameter("@TipoDoc", typeDoc));
                //cmd.Parameters.Add(new SqlParameter("@NumDoc", numDoc));
                cmd.Parameters.AddWithValue("@TipoDoc", student.TipoDoc);
                cmd.Parameters.AddWithValue("@NumDoc", student.NumeroDocumento);
                cmd.Parameters.AddWithValue("@FechaNacimiento", student.FechaNacimiento);
                cmd.Parameters.AddWithValue("@PrimerNombre", student.PrimerNombre);
                cmd.Parameters.AddWithValue("@SegundoNombre", student.SegundoNombre);
                cmd.Parameters.AddWithValue("@PrimerApellido", student.PrimerApellido);
                cmd.Parameters.AddWithValue("@SegundoApellido", student.SegundoApellido);
                cmd.Parameters.AddWithValue("@Direccion", student.Direccion);
                cmd.Parameters.AddWithValue("@NumeroCelular", student.NumeroCelular);
                cmd.Parameters.AddWithValue("@Email", student.Email);

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

        public async Task<bool> EditStudent(StudentModels student)
        {
            using (var conn = new SqlConnection(connection))
            {
                SqlCommand cmd = new SqlCommand("SP_UPDATE_ESTUDIANTE", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                //cmd.Parameters.Add(new SqlParameter("@TipoDoc", typeDoc));
                //cmd.Parameters.Add(new SqlParameter("@NumDoc", numDoc));
                cmd.Parameters.AddWithValue("@TipoDoc", student.TipoDoc);
                cmd.Parameters.AddWithValue("@NumDoc", student.NumeroDocumento);
                cmd.Parameters.AddWithValue("@FechaNacimiento", student.FechaNacimiento);
                cmd.Parameters.AddWithValue("@PrimerNombre", student.PrimerNombre);
                cmd.Parameters.AddWithValue("@SegundoNombre", student.SegundoNombre);
                cmd.Parameters.AddWithValue("@PrimerApellido", student.PrimerApellido);
                cmd.Parameters.AddWithValue("@SegundoApellido", student.SegundoApellido);
                cmd.Parameters.AddWithValue("@Direccion", student.Direccion);
                cmd.Parameters.AddWithValue("@NumeroCelular", student.NumeroCelular);
                cmd.Parameters.AddWithValue("@Email", student.Email);

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

        public async Task<bool> DeleteStudentsXDoc(string typeDoc, string numDoc)
        {
            //var student = new StudentModels();

            using (var conn = new SqlConnection(connection))
            {
                SqlCommand cmd = new SqlCommand("SP_DELETE_ESTUDIANTE", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@TipoDoc", typeDoc));
                cmd.Parameters.Add(new SqlParameter("@NumDoc", numDoc));
                //cmd.Parameters.AddWithValue("@TipoDoc", typeDoc);
                //cmd.Parameters.AddWithValue("@NumDoc", numDoc);
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
