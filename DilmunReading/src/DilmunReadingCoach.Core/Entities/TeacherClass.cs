using System;

namespace DilmunReadingCoach.Core.Entities;

public class TeacherClass
{
    public Guid TeacherId { get; set; }
    public Guid ClassroomId { get; set; }
    public Classroom? Classroom { get; set; }
}

