using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SqlAdminUtility.classes
{
    public class JobManager
    {
        public Guid JobId { get; set; }
        public string Name { get; set; }
        public bool Enabled { get; set; }
        public string Description { get; set; }
        public string Category { get; set; }

        public JobManager(Guid jobId, string name, bool enabled, string description, string category)
        {
            JobId = jobId;
            Name = name;
            Enabled = enabled;
            Description = description;
            Category = category;
        }

        public bool EmailNotify { get; set; }
    }
}
