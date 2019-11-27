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

        
        j.iniciaJogo();

        
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
        this.sentado = false;
    }

    public void run() {
        // Roda o run até que ele sente ou todas as cadeiras estejam ocupadas
        j.playGame(this);
    }

    public String toString() {
        return this.name;
    }


}

// class Producer implements Runnable {

//     private Jogo j;

//     public Producer(Jogo j) {
//         this.j = j;
//     }

//     public void run() {
//         j.createChairs();
//     }
// }

class Jogo {


    public List<AtomicBoolean> cadeiras = new ArrayList<AtomicBoolean>();
    public List<Jogador> jogadores = new ArrayList<Jogador>();
    public int N;
    // public Thread produtor;
    // public Producer p;

    public Jogo(int n) {
        this.N = n;
        // this.p = new Producer(this);
        generateNJogadores();
        // this.produtor = new Thread(this.p);
        // Provavelmente não será necessário uma thread para o produtor, pois ela produzirá as cadeiras apenas uma vez.
        // Logo só precisa chamar a função que o Producer chamaria.
        createChairs();
    }

    private void generateNJogadores() {
        // List<Jogador> l = new ArrayList<Jogador>();

        for(int i = 0; i < this.N; i++) {
            this.jogadores.add(new Jogador("Jogador " + i, this));
        }
        
    }

    // take
    public synchronized void playGame(Jogador jogador) {
        // Só começa a jogar depois de todas as cadeiras serem criadas
        while(this.cadeiras.size() != (this.N-1)) {
            try {
                wait();
            } catch(Exception e) {}
        }

        // O jogador só para se já estiver sentado ou se todas as cadeiras estiverem ocupadas
        while (!jogador.sentado) {
            // System.out.println("não estou sentado ou alguma cadeira está vaga");
            for (int i = 0; i < this.cadeiras.size(); i++) {
                // Se a caderia não estiver ocupada,ocupa ela
                if (!this.cadeiras.get(i).get()) {
                    // System.out.println(jogador.name + " sentou na cadeira " + i);
                    this.cadeiras.get(i).set(true);
                    jogador.sentado = true;
                    // System.out.println(this.isAllCadeirasOcupadas());
                    break;
                }
            }
            if(this.isAllCadeirasOcupadas()) {
                break;
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
        // System.out.println("Checando se " + this.cadeiras.size() + " cadeiras estao ocupadas");
        for (int i = 0; i < this.cadeiras.size(); i++) {
            // System.out.println(i);
            if (!this.cadeiras.get(i).get()) {
                // System.out.println("uma cadeira não está ocupada");
                return false;
            }
        }
        return true;
    }

    public synchronized void iniciaJogo() {
        while(jogadores.size() > 1) {
            System.out.println("Iniciando uma rodada");
            // Inicializa os jogadores
            for(int i = 0; i < this.jogadores.size(); i++) {
                // System.out.println(this.jogadores.get(i).name + " começou a jogar");
                (new Thread(this.jogadores.get(i))).start();
            }

            // Enquanto todas as cadeiras não estiverem ocupadas, o jogo continua.
            while (!this.isAllCadeirasOcupadas()) {
                try {
                    wait();
                } catch (Exception e) {
                }
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

            System.out.println("O " + jogadores.get(eliminado).name + " foi eliminado");
            jogadores.remove(eliminado);
            this.N--;
            System.out.println();
            // remove uma cadeira
            cadeiras.remove(0);

            
            // System.out.println("Jogadores restantes");
            // for(int i = 0; i < jogadores.size(); i++) {
            //     System.out.println(jogadores.get(i).name);
            // }
            // System.out.println();
        }

        

        System.out.println("O " + this.jogadores.get(0).name + " foi o vencedor!");
        
    }
}