import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class Primeira {
    public static void main(String[] args) {
        int n;
        Scanner s = new Scanner(System.in);
        n = s.nextInt();
        List<Aviao> avioes = new ArrayList<Aviao>();
        int temp;
        for(int i = 0; i < n; i++) {
            temp = s.nextInt();
            avioes.add(new Aviao("Aviao " + i, temp));
        }

        int m, k;
        m = s.nextInt();
        k = s.nextInt();
    }
}

class Producer implements Runnable {
    public void run() {

    }
}

class Consumer implements Runnable {
    public void run() {

    }
}

class Pista {
    Producer p;
    Consumer c;
}

class Aviao {
    String nome;
    int horaSaida;

    public Aviao(String s, int n) {
        this.nome = s;
        this.horaSaida = n;
    }
}