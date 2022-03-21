# This will be automated eventually- being lazy for now
pandoc -s -c main.css -A footer.html -H main_header.html README.md -o index.html
cd Crypto && ./build.sh && cd ../ 
cd DifferentialPrivacyMain/ && ./build.sh && cd ../
cd Talks_and_Conferences && ./build.sh && cd ../
# cd ConcentrationInequalities/ && ./build && cd ../
# cd MeetingNotes/ && ./build && cd ../

# cd GraduateSchoolCourses/ && ./build.sh && cd ../ 
# # cd Scratch/ && ./build && cd ../
# cd PrivateVoting  && ./build && cd ../


