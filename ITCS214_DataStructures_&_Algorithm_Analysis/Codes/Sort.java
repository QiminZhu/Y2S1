public class Sort {

    public static int[] Insertion(int[] a, int n) {
        for (int i = 1; i < n; i++) {
            int key = a[i];
            int j = i - 1;
            while (j >= 0 && a[j] > key) {
                a[j+1] = a[j];  // Shift
                j = j - 1;
            }
            a[j+1] = key;
        }
        return a;
    }

    public static int[] Selection(int[] a, int n) {
        
        for (int i = 0; i < n-1; i++) {
            int m = i;
            for (int j = i+1; j < n; j++) {
                if (a[j] < a[m]) {
                    m = j;
                }
            }
            if (m != i) {
                int tmp = a[m];
                a[m] = a[i];
                a[i] = tmp; 
            }
        }
        return a;
    }
    
    public static int[] Bubble(int[] a, int n) {
        for (int i = 0; i < n-1; i++) {
            boolean swapped = false;
            for (int j = 0; j < n-1-i; j ++) {
                if (a[j] > a[j+1]) {
                    int tmp = a[j];
                    a[j] = a[j+1];
                    a[j+1] = tmp;
                    swapped = true;
                }
            }
            if (!swapped) {
                break;
            }
        }
        return a;
    }

    public static int[] Shell(int[] a, int n) {
        int g = n/2;
        while (g >= 1) {
            for (int i = g; i < n; i++) {
                int key = a[i];
                int j = i;
                while (j >= g && a[j-g] > key) {
                    a[j] = a[j-g];
                    j = j - g;
                }
                a[j] = key;
            }
            g = g / 2;
        }

        return a;
    }

    public static void main(String[] args) {
        
        // 1. Insertion Sort
        int[] arr1 = {3, 5, 7, 2, 3};
        System.out.print("Insertion Before: ");
        for (int num: arr1) { System.out.print(num + " "); }
        
        Insertion(arr1, arr1.length);
        System.out.print("\nInsertion After: ");
        for (int num: arr1) { System.out.print(num + " "); }

        System.out.println("");

        // 2. Selection Sort
        int[] arr2 = {3, 5, 7, 2, 3};
        System.out.print("\nSelection Before: ");
        for (int num: arr2) { System.out.print(num + " "); }

        Selection(arr2, arr2.length);
        System.out.print("\nSelection After: ");
        for (int num: arr2) { System.out.print(num + " "); }

        System.out.println("");

        // 3. Bubble Sort
        int[] arr3 = {3, 5, 7, 2, 3};
        System.out.print("\nBubble Before: ");
        for (int num: arr3) { System.out.print(num + " "); }
        
        Bubble(arr3, arr3.length);
        System.out.print("\nBubble After: ");
        for (int num: arr3) { System.out.print(num + " "); }

        System.out.println("");

        // 4. Shell Sort
        int[] arr4 = {3, 5, 7, 2, 3};
        System.out.print("\nShell Before: ");
        for (int num: arr4) { System.out.print(num + " "); }
        
        Shell(arr4, arr4.length);
        System.out.print("\nShell After: ");
        for (int num: arr4) { System.out.print(num + " "); }

        System.out.println("");
    }
}