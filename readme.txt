Congratulations on making it to this stage of the evaluation. You are obviously very talented as very few people make it to this stage. As we’ve stated earlier, the companies we represent receive 100s of resumes for any given role and it is through these difficult assignments where you can differentiate yourself and be noticed. After completion of this final “real scenario” assignment - there will be a quick technical interview on your delivery then you are ready to be hired.
The project is scoped to be simple and reasonable in size to enable you to demonstrate your enterprise- class skills. Though this is a fictitious example, this scenario is very similar to what you may encounter in your job.
Instructions
Try to complete as much as possible within the given time frame. If you need more time, please ask for an extension. You must complete full-functionality of the application with industry-level coding style/commenting. Unfinished assignments will not be considered.
Please note that you are expected to work on the assignment independently. Discussing assignment details with colleagues or any indication of outside help will be considered cheating.
Please do not expect too much hand-holding as this is an evaluation assignment.
Read the complete assignment before you start. Understand clearly what is required so that your work will be appropriate and easier.
Preconditions
1. You should work on local machine.
2. Use one major mobile technology for development out of either: iOS or Android:
1. iOS
1. Swift (preferable) or Objective-C. 2. XCode 7 or Later.
3. iOS 8 and above.
4. CocoaPods if necessary.
5. Unit Test.
2. Android
1. Java 8.
 
   
2. API 16 and above.
3. Android Studio 1.5 or Later. 4. Gradle.
5. Unit Test.
3. Do not use any proprietary technologies or tools that are not available for evaluation.
4. Feel free to use any open source/free framework to aim in the application development.
5. Do not replace any of the minimum required technologies/tools listed above.
6. THE DELIVERY WILL NOT BE EVALUATED IF YOU FAIL TO FOLLOW ANY OF THE ITEMS ABOVE.
Objective
A hospital needs an effective way to control its medication administration time, to guarantee that all of its patients will take their medicines at the right time. With this in mind, the director realized the hospital needs a mobile application to be used by all the nurses, making the medication administration easily to be remembered.
Functional Specifications:
You need to create the required application with the following functional requirements:
1. The application allows add new nurses:
1. Email required field (up to 254 characters) 2. Password required field (up to 32 characters)
2. The application allows login:
1. Email required field (up to 254 characters) 2. Password required field (up to 32 characters)
3. (Requires Login) The application allows add new patients:
1. Email required field (up to 254 characters)
2. Full Name required field (up to 128 characters)
3. Phone number required field (up to 32 characters)
4. After the operation has been completed the added patient will be associated to current logged nurse
4. The application allows add new medicines:
1. Name required field (up to 254 characters)
2. Duplicated names are not allowed and must be validated (case insensitive).
   5. The nurse can list all the patients associated to him.
6. The nurse can see details of a patient by selecting the patient on the list, the application must show the patient’s information as well as any medication he/she needs to take.
7. The systems allows a nurse to control his/her medication administration time schedule. For any available patient, he/she can schedule one or more medications by add the following information:
1. Medicine
2. Schedule time (hh:mm AM/PM) 3. Dosage (ml or pills)
4. Priority
1. High
2. Medium 3. Low
Non Functional Specifications:
1. All the information must be persisted locally.
2. The sensitive data must be encrypted.
3. An email value is used as unique identifier for both, nurses and patients.
4. A patient can never be associated with more than one nurse per time, to avoid possible double dose errors.
5. The list of all medicines must be available to all users (nurses).
6. The application is supposed to run as a “sandbox environment” - one nurse data cannot influence
another nurse's’ data, ever.
7. The scheduled repeating alarm must run in time, even if the application is in background.
8. The scheduled repeating alarm must always prioritize the medicine with the highest level, e.g if two patients need take their medication and patient A has medicine level High and patient B has medicine level Medium/Low, the shows the patient A medications first.
Deliverables
Application Demo:
Record the video demonstration of your work using a screencast tool like screencast-o-matic (or any other tool you prefer) commenting on the execution of all components. Save the video to your local machine and include it with the delivery package.
Readme Document:
Create a manual steps with the following information:
1. Steps to install and configure any pre requisites for the development environment.
      
2. Steps to prepare the source code to build properly.
3. Any assumptions made and missing requirements that are not covered in the requirements. 4. Any feedback you wish to give about improving the assignment.
Design Document:
A document (PDF preferred) containing the following information and diagrams:
1. List of technologies and design patterns used.
2. Explanation of the architecture/design implementation and reasons of various choices.
3. Diagrams for component interaction, activity, sequence and/or classes of the important components.
To be evaluated
You must be able to demonstrate that you can work in an enterprise environment, with modern project development methodologies and with outstanding quality.
1. Efficacy of your submission: fundamentally how well your solution is able to achieve the assignment objective and solve the stated problem.
2. Code quality
1. Code modularity.
2. Application organization across files and within each file - please ensure you follow the framework standards.
3. Code documentation - balancing between self documenting code and comments.
4. Unit and integration testing.
5. Exception handling where available and expected in the frameworks you’re using.
6. For any technology used, the correct usage of that technology based on established best practices.
3. Design
1. Clarity and completeness of the readme and design documents.
2. Fitness of solution to problem.
3. Efficiency of communication flows between frontend and backend.
4. Functional completeness
5. Scoring ratio matrix (out of 10), all of these are individually mandatory so don’t skip any:
1. Design quality = 2.
2. Code quality = 3.
  3.
3. Docs and demo quality = 2.
4. Specifications compliance = 3.
6. The application must be compiling with successful unit testing execution, covering the requirements.
Delivery / What to submit
Please, read and follow this section carefully. Any delivery that does not follow this section will score much less or simply won’t be evaluated.
First of all, review Delivery Instructions (Sent to your personal mail), which describes general delivery process. Delivery for this assignment should consist of: Archive named <your_name>_MobileDeveloper_<technology>.zip containing the following.
1. Source Code.
2. Video recording.
3. Readme.txt containing the instructions to configure and run the application, assumptions and feedback.
4. Design.pdf containing architecture as well as designing information and diagrams.
Structure of the resulting zip file should be of the following format:
<your_name>_MobileDeveloper_Android or <your_name>_MobileDeveloper_iOS <your_name>_MobileDeveloper\Readme.txt <your_name>_MobileDeveloper\Design.pdf <your_name>_MobileDeveloper\Source\ <<< containing the complete source code <your_name>_MobileDeveloper\Demo\ <<< containing the video recording