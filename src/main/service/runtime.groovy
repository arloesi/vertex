package service

import org.springframework.context.support.*
import org.hibernate.*

import kernel.source.*
import schema.Account

class Runtime {
  static main(args) {
    ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("context.xml");
    Schema schema = context.getBean("vertex.schema");

    Session session = schema.openSession();
    session.beginTransaction();

    Account account = new Account(name:"My Account");
    session.save(account);
    session.getTransaction().commit();
    session.close();

    session = schema.openSession();
    account = session.createQuery("from Account").uniqueResult();

    session.close();

    println("account: "+account.name)
  }
}