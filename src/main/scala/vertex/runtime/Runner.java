package vertex.runtime;

import com.google.inject.Guice;
import com.google.inject.Injector;

import kernel.network.Server;

public class Runner {
    public static void main(String [] args) throws Exception {
        final Injector injector = Guice.createInjector(
            new Module(), new kernel.network.Module(8080, "dist"));
        injector.getInstance(Server.class).run();
    }
}
