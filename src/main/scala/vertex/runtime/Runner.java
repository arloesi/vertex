package vertex.runtime;

import com.google.inject.Injector;
import kernel.network.Server;
import static com.google.inject.Guice.createInjector;

public class Runner {
    public static void main(String [] args) throws Exception {
        final Injector injector = createInjector(
            new Module(), new kernel.runtime.Module(),
            new kernel.network.Module(8080));
        injector.getInstance(Server.class).run();
    }
}
