using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SqlAdminUtility.classes
{
    public class JobSchedule
    {
        public string Name { get; set; }
        public int FreqType { get; set; }
        public string ActiveStartTime { get; set; }
        public JobSchedule(string name, int freqType, string activeStartTime)
        {
            Name = name;
            FreqType = freqType;
            ActiveStartTime = activeStartTime;
        }
    }
}
