import java.util.Random;

public class Primeira {
    public static void main(String[] args) {
        
    }
}

class ContaCompartilhada {

    public int saldo;
    public Random random = new Random();

    public void deposita() {
        int valorCreditado = random.nextInt();
        synchronized(this) {
             this.saldo += valorCreditado;
             this.notify();
        }
    }

    public void retira() {
        int valorDebitado = random.nextInt();

        synchronized(this) {
            while((this.saldo - valorDebitado) < 0) {
                try {
                    this.wait();
                } catch (Exception e) {}
            }
            this.saldo -= valorDebitado;
        }
    }
}