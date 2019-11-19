import java.util.Vector

public class SafeVector<E> {

    Vector<E> vec = new Vector<E>();
    
    public synchronized E get(int n) {
        return this.vec.get(n);
    }

    public synchronized void set(E e, int n) {
        this.vec.set(n, e);
    }

    public synchronized void swap(int n1, int n2) {
        E e1 = this.vec.get(n1);
        E e2 = this.vec.get(n2);
        this.vec.set(n1, e2);
        this.vec.set(n2, e1);
    }
}