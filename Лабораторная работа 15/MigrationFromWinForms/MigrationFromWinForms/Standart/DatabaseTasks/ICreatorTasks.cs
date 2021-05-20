
using System.Data.SqlClient;

namespace MigrationFromWinForms.Standart.DatabaseTasks
{
    interface ICreatorTasks
    {

       
          string AddJob();
          string AddJobStep();
          string UpdateJob();
          string JobSchedule();

    }
}
