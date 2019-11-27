import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
import java.util.concurrent.atomic.AtomicBoolean;


public class Segunda {
    public static void main(String[] args) {
        int qtJogadores;
        Scanner s = new Scanner(System.in);
        qtJogadores = s.nextInt();
        Jogo j = new Jogo(qtJogadores);


        while(j.N > 1) {

            // Inicializa o jogo;
            (new Thread(j.p)).start();
            for(int i = 0; i < j.jogadores.size(); i++) {
                (new Thread(j.jogadores.get(i))).start();
            }

            while(!j.isAllCadeirasOcupadas()) {
                // Enquanto todas as cadeiras não estiverem ocupadas o jogo vai rolando
                
            }

            j.reiniciaJogo(j.cadeiras, j.jogadores);
        }
        System.out.println(j.jogadores.get(0) + " ganhou");
    }

}

// Vai ser um consumidor
class Jogador implements Runnable{

    public String name;
    public Boolean sentado;
    public Jogo j;

    public Jogador(String n, Jogo j){
        this.name = n;
        this.j = j;
    }

    public void run() {
        // Roda o run até que ele sente ou todas as cadeiras estejam ocupadas
        j.playGame(this);
    }

    public String toString() {
        return this.name;
    }


}

class Producer implements Runnable {

    private Jogo j;

    public Producer(Jogo j) {
        this.j = j;
    }

    public void run() {
        j.createChairs();
    }
}

class Jogo {


    public List<AtomicBoolean> cadeiras;
    public List<Jogador> jogadores;
    public int N;
    public Producer p;

    public Jogo(int n) {
        this.N = n;
        this.p = new Producer(this);
        this.jogadores = generateNJogadores();
    }

    List<Jogador> generateNJogadores() {
        List<Jogador> l = new ArrayList<Jogador>();

        for(int i = 0; i < this.N; i++) {
            l.add(new Jogador("Jogador " + i, this));
        }
        return l;
    }

    // take
    public synchronized void playGame(Jogador jogador) {
        // Só começa a jogar depois de todas as cadeiras serem criadas
        while(this.cadeiras.size() != (this.N-1)) {
            try {
                wait();
            } catch(Exception e) {}
        }

        while (!(jogador.sentado) && !this.isAllCadeirasOcupadas()) {
            for (int i = 0; i < this.cadeiras.size(); i++) {
                // Se a caderia não estiver ocupada,ocupa ela
                if (!this.cadeiras.get(i).get()) {
                    this.cadeiras.get(i).set(true);
                    jogador.sentado = true;
                }
            }
        }

        notifyAll();

    }

    // put
    public synchronized void createChairs() {
        for (int i = 0; i < (this.N - 1); i++) {
            this.cadeiras.add(new AtomicBoolean());
        }
        // Notifica aos jogadores que as cadeira estão disponiveis
        notifyAll();
    }

    public synchronized boolean isAllCadeirasOcupadas() {
        while (this.cadeiras.size() != (this.N - 1)) {
            try {
                wait();
            } catch (Exception e) {
            }
        }

        for (int i = 0; i < this.cadeiras.size(); i++) {
            System.out.println(i);
            if (!this.cadeiras.get(i).get()) {
                return false;
            }
        }
        return true;
    }

    public synchronized void reiniciaJogo(List<AtomicBoolean> cadeiras, List<Jogador> jogadores) {

        while(this.isAllCadeirasOcupadas()) {
            try {
                wait();
            } catch (Exception e) {}
        }


        int eliminado = 0;
        
        // Tira os jogadores das cadeiras.
        for (int i = 0; i < cadeiras.size(); i++) {
            cadeiras.get(i).set(false);
        }
        for (int i = 0; i < jogadores.size(); i++) {

            if (!jogadores.get(i).sentado) {
                // Remove o jogador em pé
                eliminado = i;
            } else {
                // coloca os jogadores de pé de volta
                jogadores.get(i).sentado = false;
            }
            
        }

        System.out.println(jogadores.get(eliminado).name + " foi eliminado");
        jogadores.remove(eliminado);
        this.N--;
        // remove uma cadeira
        cadeiras.remove(0);

        if(jogadores.size() == 1) {
            System.out.println(this.jogadores.get(0).name + "ganhou");
        } else {
            // TODO: Fazer reinicio do jogo aqui
        }
    }
}