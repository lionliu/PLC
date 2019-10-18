import java.util.concurrent.CountDownLatch;

public class Main {
    public static void main(String[] args) {
        int n = 10;
        CountDownLatch cdl = new CountDownLatch(n);
        (new Thread(new Producer(cdl, n))).start();

    }
}

class Producer implements Runnable{
    CountDownLatch cdl;
    int n;

    public Producer(CountDownLatch cdl, int n) {
        this.cdl = cdl;
        this.n = n;
    }

    public void run() {
        for(int i = 0; i < n; i++) {
            this.cdl.countDown();
            try {
                Thread.sleep(random.nextInt(500));
            } catch (InterruptedException e) {
            }
        }
    }
}

class Consumer implements Runnable{
    CountDownLatch cdl;

    public Consumer(CountDownLatch cdl) {
        this.cdl = cdl;
    }
}