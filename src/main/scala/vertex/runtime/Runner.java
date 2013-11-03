package vertex.runtime;

import kernel.Module;
import kernel.network.Server;

import com.google.inject.Guice;
import com.google.inject.Injector;

public class Runner {
    public static void main(String [] args) throws Exception {
        final Module module = new Module(8080, "dist");
        final Injector injector = Guice.createInjector(module);
        injector.getInstance(Server.class).run();
    }
}
