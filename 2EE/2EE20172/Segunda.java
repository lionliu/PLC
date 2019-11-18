import java.util.concurrent.atomic.AtomicInteger;
import java.util.Random;

public class Segunda {
    public static void main(String[] args) {

    }
}

class ContaCompartilhadaAtomica {

    public AtomicInteger saldo;
    public Random random = new Random();

    public ContaCompartilhadaAtomica(int saldo) {
        this.saldo = new AtomicInteger(saldo);
    }

    public void deposita() {
        int valorCreditado = random.nextInt();
        this.saldo.getAndAdd(valorCreditado);
    }

    public void retira() {
        int valorDebitado = random.nextInt();
        // Provavelmente tá errado pq não esperaria outra thread notificar quando é possivel realizar o debito.
        if((this.saldo.get() - valorDebitado) >= 0) {
            this.saldo.getAndAdd(-valorDebitado);
        }
    }
}