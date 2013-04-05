package service

import org.springframework.context.support.*
import schema.Account

class Runtime {
  static main(args) {
    def context = new ClassPathXmlApplicationContext("context.xml");
    def schema = context.getBean("vertex.schema");

    def session = schema.openSession();
    session.beginTransaction();

    def account = new Account(name:"My Account");
    session.save(account);
    session.getTransaction().commit();
    session.close();

    session = schema.openSession();
    account = session.createQuery("from Account").uniqueResult();

    session.close();

    println("account: "+account.name)
  }
}