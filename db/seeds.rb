doctor = Doctor.new(
  name: 'Dr. Jeremy Alford',
  bio: 'Experienced doctor specializing in internal medicine'
)

doctor.build_social_medium(
  facebook: 'https://facebook.com/doctorspage',
  twitter: 'https://twitter.com/doctorspage',
  instagram: 'https://instagram.com/doctorspage'
)

doctor.build_location(
  address: '123 Main Street',
  city: 'Cityville',
  state: 'State',
  zip_code: 12345
)

doctor.build_payment(
  consultation_fee: 150
)

doctor.image.attach(io: File.open('public/images/jeremy-alford.jpg'), filename: 'jeremy-alford.jpg')

doctor.save!

doctor1 = Doctor.new(
  name: 'Dr. Usman Yousaf',
  bio: 'Experienced doctor specializing in human anatomy'
)

doctor1.build_social_medium(
  facebook: 'https://facebook.com/doctorspage',
  twitter: 'https://twitter.com/doctorspage',
  instagram: 'https://instagram.com/doctorspage'
)

doctor1.build_location(
  address: '1333 Main Street',
  city: 'San Fransisco',
  state: 'State',
  zip_code: 56789
)

doctor1.build_payment(
  consultation_fee: 250
)

doctor1.image.attach(io: File.open('public/images/usman-yousaf.jpg'), filename: 'usman-yousaf.jpg')

doctor1.save!

doctor2 = Doctor.new(
  name: 'Dr. Ani Kolleshi',
  bio: 'Experienced Psychiatry doctor with abundance of experience'
)

doctor2.build_social_medium(
  facebook: 'https://facebook.com/doctorspage',
  twitter: 'https://twitter.com/doctorspage',
  instagram: 'https://instagram.com/doctorspage'
)

doctor2.build_location(
  address: '4653 Main Street',
  city: 'New York',
  state: 'State',
  zip_code: 33333
)

doctor2.build_payment(
  consultation_fee: 100
)

doctor2.image.attach(io: File.open('public/images/ani-kolleshi.jpg'), filename: 'ani-kolleshi.jpg')

doctor2.save!