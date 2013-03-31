package service

import org.hibernate.cfg.*
import schema.Account

class Runtime {
	static main(args) {
    def properties = [
      "hibernate.dialect":"org.hibernate.dialect.DerbyDialect",
      "hibernate.connection.driver_class":"org.apache.derby.jdbc.EmbeddedDriver",
      "hibernate.connection.url":"jdbc:derby:.data/content;create=true",
      "hibernate.hbm2ddl.auto":"create-drop",
      "hibernate.show_sql":"true"]

    def config = new Configuration()
    properties.each { k, v -> config.setProperty(k, v) }
    config.addAnnotatedClass(Account)

    def factory = config.buildSessionFactory()

    def session = factory.openSession()
    session.beginTransaction()
    session.save(new Account(name:"My Account"))
    session.transaction.commit()
    session.close()

    session = factory.openSession()
    def account = session.createQuery("from Account").uniqueResult()

		println("account: "+account.name)
    session.close()
	}
}