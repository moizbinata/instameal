import 'package:flutter/cupertino.dart';

class University {
  int branches;
  String numb;
}

class PrivateUniversity extends University {
  getBranch(branches) {
    if (branches > 0) return branches;
  }

  setBranches() {
    if (branches > 0) branches = branches;
  }

  showBranch(branch, numb) {
    print("The university Name is :$branch");
    print("Number of branch :$numb");
  }
}

class UniversityTest extends PrivateUniversity {
  PrivateUniversity privateUniversity = PrivateUniversity();
}

void main(List<String> args) {
  UniversityTest universityTest = UniversityTest();
  universityTest.showBranch("Aman UNiversity", 10);
}
