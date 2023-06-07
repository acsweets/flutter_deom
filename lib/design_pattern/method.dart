import 'package:style/design_pattern/visitor_pattern/visitor.dart';

class Method{




  // static List<Employee> mockEmployee(){
  //   List<Employee> empList =[];
  //
  //   CommonEmployee zhangSan =  CommonEmployee();
  //
  //   zhangSan.setJob("编写Java程序，绝对的蓝领、苦工加搬运工");
  //   zhangSan.setName("张三"); zhangSan.setSalary(1800);
  //   zhangSan.setSex(Employee.male); empList.add(zhangSan);
  //
  //
  //   CommonEmployee liSi =  CommonEmployee();
  //   liSi.setJob("页面美工，审美素质太不流行了！");
  //   liSi.setName("李四");
  //   liSi.setSalary(1900); liSi.setSex(Employee.female);
  //   empList.add(liSi);
  //
  //   Manager wangWu =  Manager();
  //   wangWu.setName("王五");
  //   wangWu.setPerformance("基本上是负值，但是我会拍马屁呀");
  //   wangWu.setSalary(18750);
  //   wangWu.setSex(Employee.male);
  //   empList.add(wangWu);
  //   return empList;
  // }
  //
  // static void readMember(){
  //   mockEmployee().forEach((element) {
  //     element.report();
  //   });
  // }

  static List<Employee> mockEmployee(){
    List<Employee> empList =[];

    CommonEmployee zhangSan =  CommonEmployee();

    zhangSan.setJob("编写Java程序，绝对的蓝领、苦工加搬运工");
    zhangSan.setName("张三"); zhangSan.setSalary(1800);
    zhangSan.setSex(Employee.male); empList.add(zhangSan);


    CommonEmployee liSi =  CommonEmployee();
    liSi.setJob("页面美工，审美素质太不流行了！");
    liSi.setName("李四");
    liSi.setSalary(1900); liSi.setSex(Employee.female);
    empList.add(liSi);

    Manager wangWu =  Manager();
    wangWu.setName("王五");
    wangWu.setPerformance("基本上是负值，但是我会拍马屁呀");
    wangWu.setSalary(18750);
    wangWu.setSex(Employee.male);
    empList.add(wangWu);
    return empList;
  }

  static void readMember(){
    IVisitor visitor =  Visitor();
    mockEmployee().forEach((element) {
      element.accept(visitor);
    });
    print("总薪水"+"${visitor.getTotalSalary()}");
  }

}
