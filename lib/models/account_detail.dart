
class AccountDetail {
  // CUSTOMER
  String? id;
  String? customerNo;
  String? salutation;
  String? name;
  String? firstName;
  String? lastName;
  String? otherName;
  String? shortName;
  String? gender;
  String? dob;
  String? nationality;
  String? maritalStatus;
  String? bvn;
  String? address1Line1;
  String? address1Line2;
  String? address1Line3;
  String? address1Line4;
  String? address;
  String? postCode;
  String? city;
  String? lgaOfResidence;
  String? state;
  String? country;
  String? townOfOrigin;
  String? lgaOfOrigin;
  String? stateOfOrigin;
  bool? resident;
  String? address2Line1;
  String? address2Line2;
  String? address2Line3;
  String? address2Line4;
  String? address2;
  String? language;
  String? religion;
  String? residentType;
  String? dateStartStayinAddress;
  String? lengthofStayinAddress;

  // NEXT OF KIN
  String? nokTitle;
  String? nokFirstName;
  String? nokLastName;
  String? nokOtherName;
  String? nokRelationship;
  String? nokPhoneNo;
  String? nokEmailAddress;
  String? nokAddress;
  String? nokZipCode;
  String? nokCity;
  String? nokState;

  // EMPLOYMENT
  String? employmentStatus;
  String? natureofEmployment;
  String? employerName;
  String? occupationCode;
  String? occupationDesc;
  String? employerAddress;
  String? employerZipCode;
  String? employerCity;
  String? employerState;
  String? officeEmail;
  String? officePhoneNo;
  String? employmentStartDate;
  double? grossAnnualIncome;
  String? customerType;
  String? staffId;
  String? memberShipNo;

  // GAURDIAN
  String? guardian;
  dynamic guardianNo;
  String? guardianRelationship;

  // CUSTOMER
  String? defaultAccountNo;
  String? phoneRef;
  String? email;
  String? education;
  String? profession;
  String? industry;
  String? industrySeg;
  String? region;
  String? mothersMaidenName;
  String? relationShipDept;
  String? relationshipMan;
  String? altRelationshipMan;
  String? status;
  String? notes;
  String? natureOfBuss;
  String? typeOfBuss;
  double? paidUpShareCap;
  String? shareHoldstruc;
  int? staffStrength;
  String? bankers;
  double? marketShare;
  String? fiscalPeriod;
  int? noOfBranch;
  int? industryRank;
  String? agentType;
  String? isGroupLeader;
  String? isGroupMember;
  String? groupLeaderNo;
  String? infoShareConsentLevel;
  String? accessLevel;
  String? blockStatus;
  String? blockReason;
  String? accountPurpose;
  String? verificationStatus;
  String? verificationRemarks;
  String? verificationDate;
  List? kycdocs;
  List? signatorys;
  List? directors;
  String? branch;
  bool? member;
  bool? minor;
  bool? staff;
  bool? agent;
  bool? restricted;
  bool? blocked4Transactions;
  bool? pep;
  int? verified;
  String? tin;
  String? incomeTaxNo;
  String? vatregNo;
  String? pepremarks;
  String? rcno;

  AccountDetail(
      {this.accessLevel,
      this.accountPurpose,
      this.address,
      this.address1Line1,
      this.address1Line2,
      this.address1Line3,
      this.address1Line4,
      this.address2Line1,
      this.address2Line2,
      this.address2Line3,
      this.address2Line4,
      this.address2,
      this.agent,
      this.agentType,
      this.altRelationshipMan,
      this.bankers,
      this.salutation,
      this.blockReason,
      this.blockStatus,
      this.blocked4Transactions,
      this.branch,
      this.bvn,
      this.city,
      this.country,
      this.customerNo,
      this.customerType,
      this.dateStartStayinAddress,
      this.defaultAccountNo,
      this.directors,
      this.dob,
      this.education,
      this.email,
      this.employerAddress,
      this.employerCity,
      this.employerName,
      this.employerState,
      this.employerZipCode,
      this.employmentStartDate,
      this.employmentStatus,
      this.firstName,
      this.fiscalPeriod,
      this.gender,
      this.grossAnnualIncome,
      this.groupLeaderNo,
      this.guardian,
      this.guardianNo,
      this.guardianRelationship,
      this.id,
      this.tin,
      this.incomeTaxNo,
      this.industry,
      this.industryRank,
      this.industrySeg,
      this.infoShareConsentLevel,
      this.isGroupLeader,
      this.isGroupMember,
      this.kycdocs,
      this.language,
      this.lastName,
      this.lengthofStayinAddress,
      this.lgaOfOrigin,
      this.lgaOfResidence,
      this.maritalStatus,
      this.marketShare,
      this.member,
      this.memberShipNo,
      this.minor,
      this.mothersMaidenName,
      this.name,
      this.nationality,this.natureOfBuss,this.natureofEmployment,this.noOfBranch,this.nokAddress,this.nokCity,this.nokEmailAddress,this.nokFirstName,this.nokLastName,this.nokOtherName,this.nokPhoneNo,this.nokRelationship,
      this.nokState,this.nokTitle,this.nokZipCode,this.notes,this.occupationCode,this.occupationDesc,this.officeEmail,this.officePhoneNo,this.otherName,this.paidUpShareCap,this.pep,
      this.pepremarks,this.phoneRef,this.postCode,this.profession,this.rcno,this.region,this.relationShipDept
      });
}
