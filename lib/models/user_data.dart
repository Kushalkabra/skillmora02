class UserData {
  static String userName = 'Vishnu Prajapati';
  static String aboutText = 'Passionate software developer with expertise in mobile app development using Flutter and native Android. Strong problem-solving skills and experience in creating user-friendly applications.';
  
  static List<Map<String, String>> careerPreferences = [
    {'Preferred Work Location': 'Vadodara'},
    {'Preferred Salary': '2,80,000 / Annum'},
    {'Resume Headline': 'Full Stack Developer'},
  ];
  
  static List<String> skills = ['Javascript', 'HTML5', 'CSS'];
  
  static List<Map<String, String>> languages = [
    {'English': 'Expert'},
    {'Hindi': 'Expert'},
  ];

  // Add Project data
  static List<Map<String, dynamic>> projects = [
    {
      'title': 'Job Portal App',
      'description': 'A mobile application for job seekers built with Flutter and Firebase',
      'duration': 'Jan 2024 - Present',
      'technologies': ['Flutter', 'Firebase', 'Provider'],
      'link': 'github.com/username/job-portal'
    },
    {
      'title': 'E-commerce Platform',
      'description': 'Full-stack web application with React and Node.js',
      'duration': 'Aug 2023 - Dec 2023',
      'technologies': ['React', 'Node.js', 'MongoDB'],
      'link': 'github.com/username/ecommerce'
    },
  ];

  // Add Work Experience data
  static List<Map<String, dynamic>> workExperience = [
    {
      'role': 'Software Engineer Intern',
      'company': 'Google',
      'duration': 'Summer 2023',
      'location': 'Mountain View, CA',
      'description': 'Worked on Android development team to implement new features and improve app performance.',
      'achievements': [
        'Improved app performance by 40%',
        'Implemented new UI components',
        'Collaborated with design team'
      ]
    },
    {
      'role': 'Frontend Developer',
      'company': 'Microsoft',
      'duration': 'Jan 2023 - June 2023',
      'location': 'Remote',
      'description': 'Developed and maintained web applications using React.',
      'achievements': [
        'Led team of 3 developers',
        'Reduced loading time by 50%',
        'Implemented responsive design'
      ]
    },
  ];

  // Add these new data structures to UserData class
  static List<Map<String, dynamic>> education = [
    {
      'degree': 'Computer Science',
      'institution': 'Stanford University',
      'year': '2019 - 2023',
      'grade': 'CGPA: 3.8/4.0',
    },
    {
      'degree': 'High School',
      'institution': 'Lincoln High School',
      'year': '2015 - 2019',
      'grade': 'Major: Science',
    },
  ];

  static List<Map<String, dynamic>> certificates = [
    {
      'title': 'AWS Certified Developer',
      'issuer': 'Amazon Web Services',
      'date': 'Jan 2023',
      'url': 'aws.com/cert/123',
    },
    {
      'title': 'Flutter Development',
      'issuer': 'Google',
      'date': 'Mar 2023',
      'url': 'google.com/cert/456',
    },
  ];
} 