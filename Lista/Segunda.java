import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
import java.util.concurrent.atomic.AtomicBoolean;

// TODO: Fazer consumidores como os jogadores e um produtor de cadeiras. Na primeira rodada, criar N consumidores e produzir N-1 cadeiras, e a cada rodada ir decrementando o N, até que reste 1 jogador. 
// O produtor pode gerar um atomic integer = (qt jogadores-1), sendo que cada jogador(consumidor) subtrai 1 do valor e coloca a flag sentado = 1
public class Segunda {
    public static void main(String[] args) {
        UtilidadePublica up = new UtilidadePublica();
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

            while(!up.isAllCadeirasOcupadas(j.cadeiras)) {
                // Enquanto todas as cadeiras não estiverem ocupadas o jogo vai rolando
                
            }

            up.reiniciaJogo(j.cadeiras, j.jogadores);
        }
        System.out.println(j.jogadores.get(0) + " ganhou");
    }

}

// Vai ser um consumidor
class Jogador implements Runnable{

    public String name;
    public Boolean sentado;
    public Jogo j;
    UtilidadePublica up;

    public Jogador(String n, Jogo j){
        this.name = n;
        this.j = j;
    }

    public void run() {
        // Roda o run até que ele sente ou todas as cadeiras estejam ocupadas
        while(!(this.sentado) && !this.up.isAllCadeirasOcupadas(this.j.cadeiras)) {
            for(int i = 0; i < this.j.cadeiras.size(); i++) {
                // Se a caderia não estiver ocupada,ocupa ela
                if(!this.j.cadeiras.get(i).get()) {
                    this.j.cadeiras.get(i).set(true);
                    this.sentado = true;
                }
            }
        }
    }

    public String toString() {
        return this.name;
    }


}

class UtilidadePublica {
    public boolean isAllCadeirasOcupadas(List<AtomicBoolean> cadeiras) {
        for (int i = 0; i < cadeiras.size(); i++) {
            System.out.println(i);
            if (!cadeiras.get(i).get()) {
                return false;
            }
        }
        return true;
    }
    public void reiniciaJogo(List<AtomicBoolean> cadeiras, List<Jogador> jogadores) {
        // remove uma cadeira
        cadeiras.remove(0);
        // Tira os jogadores das cadeiras.
        for(int i = 0; i < cadeiras.size(); i++) {
            cadeiras.get(i).set(false);
        }
        for (int i = 0; i < jogadores.size(); i++) {

            if(!jogadores.get(i).sentado) {
                // Remove o jogador em pé
                System.out.println(jogadores.get(i).name + " foi eliminado");
                jogadores.remove(i);
            }
            // coloca os jogadores de pé de volta
            jogadores.get(i).sentado = false;
        }
    }
}

class Producer implements Runnable {

    private Jogo j;

    public Producer(Jogo j) {
        this.j = j;
    }

    public void run() {
        // Gerar N-1 cadeiras
        synchronized(j.cadeiras) {
            for (int i = 0; i < (j.N - 1); i++) {
                j.cadeiras.add(new AtomicBoolean());
            }
        }
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
}