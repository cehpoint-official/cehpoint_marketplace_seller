// ignore_for_file: file_names
// This file is used to store data, which will be displayed on app
// Storing / Modifying data here, will make changes reflect in whole app.

class SELECTION {
  static String email = "";
  static List<String> servicesList = [
    'Electricity',
    'Water Supply',
    'Gas Supply',
    'Internet/Wi-Fi',
    'Cable TV',
    'Phone Connectivity',
    'Security Personnel',
    'CCTV Surveillance',
    'Alarm System',
    'Heating',
    'Air Conditioning',
    'Ventilation',
    'Furnished',
    'Unfurnished',
    'Partially Furnished',
    'Kitchen Appliances',
    'Modular Kitchen',
    'Covered Parking',
    'Open Parking',
    'Visitor Parking',
    'Garden',
    'Balcony',
    'Terrace',
    'Wheelchair Accessible',
    'Elevator/Lift',
    'Basement Storage',
    'Attic Storage',
    'Home Office',
    'Gym/Fitness Room',
    'Home Theater',
    'Swimming Pool',
    'Clubhouse',
    'Playground',
    '24/7 Maintenance',
    'On-Site Maintenance Staff',
    'Smart Home Features',
    'Solar Panels',
    'Rainwater Harvesting',
  ];
  static List<List<String>> banksList = [
    ['Absa Bank Tanzania', 'Available'],
    ['African Banking Corporation Tanzania Limited', 'Available'],
    ['Akiba Commercial Bank', 'Available'],
    ['Amana Bank', 'Available'],
    ['Azania Bank', 'Available'],
    ['Bank of Africa Tanzania Limited', 'Available'],
    ['Bank of Baroda Tanzania Limited', 'Available'],
    ['Bank of India (Tanzania)', 'Available'],
    ['Canara Bank Tanzania Limited', 'Available'],
    ['China Dasheng Bank Limited', 'Available'],
    ['Citibank Tanzania', 'Available'],
    ['CRDB Bank', 'Available'],
    ['DCB Commercial Bank', 'Available'],
    ['Diamond Trust Bank Tanzania', 'Available'],
    ['Ecobank Tanzania', 'Available'],
    ['Equity Bank (Tanzania)', 'Available'],
    ['Exim Bank (Tanzania)', 'Available'],
    ['GTBank Tanzania', 'Available'],
    ['Habib African Bank', 'Available'],
    ['I&M Bank (Tanzania)', 'Available'],
    ['ICBank Tanzania', 'Available'],
    ['KCB Bank Tanzania', 'Available'],
    ['Letshego Bank Tanzania', 'Available'],
    ['Mkombozi Commercial Bank', 'Available'],
    ['Mwalimu Commercial Bank', 'Available'],
    ['National Bank of Commerce (Tanzania)', 'Available'],
    ['National Microfinance Bank', 'Available'],
    ['NCBA Bank Tanzania', 'Available'],
    ['People\'s Bank of Zanzibar', 'Available'],
    ['Stanbic Bank Tanzania Limited', 'Available'],
    ['Standard Chartered Bank Tanzania', 'Available'],
    ['Tanzania Commercial Bank', 'Available'],
    ['UBA Bank Tanzania', 'Available'],
    ['Mwanga Hakika Bank', 'Available'],
    ['First Housing Company Tanzania Limited', 'Available'],
    ['Tanzania Mortgage Refinance Company', 'Available'],
    ['Tanzania Agricultural Development Bank', 'Available'],
    ['TIB Development Bank', 'Available'],
    ['Kilimanjaro Cooperative Bank', 'Available'],
    ['Maendeleo Bank Plc', 'Available'],
    ['Mufindi Community Bank Plc (MuCoBa)', 'Available'],
    ['Tandahimba Community Bank Limited', 'Available'],
    ['Uchumi Commercial Bank Limited', 'Available'],
    ['AccessBank Tanzania', 'Available'],
    ['Finca Microfinance Bank (Tanzania)', 'Available'],
    ['VisionFund Tanzania Microfinance Bank', 'Available'],
    ['Yetu Microfinance Bank PLC', 'Available'],
    ['Y9 Microfinance|Y9 Microfinance Bank PLC', 'Available'],
    ['UOB Global Capital Finance Limited', 'Available'],
  ];

  static List<String> fetchServicesList() {
    return List.from(servicesList);
  }

  static String fetchEmail() {
    return email;
  }

  static void setEmail(String value) {
    email = value;
  }

  static List<List<String>> fetchBanksList() {
    return List.from(banksList);
  }
}
