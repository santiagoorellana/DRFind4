--RDFind4-- (2013-2022)
Radiogoni�metro de amplitud de cuatro antenas
El radiogoni�metro de amplitud de cuatro antenas est� compuesto por los siguientes m�dulos:

Sistema de antenas: Cuatro antenas para cubrir la banda UHF, ortogonalmente opuestas una con respecto a la otra, de manera que cada una de las cuatro antenas dirige su m�ximo l�bulo hacia un punto cardinal geogr�fico. Las antenas deben cubrir toda la banda de recepci�n de manera regular y deben tener una amplitud de captaci�n de 90 grados.

Alternador de antenas o conmutador: Contiene amplificadores de RF y filtros de banda ancha, as� como el circuito de conmutaci�n y generaci�n de la se�al de sincron�a. La se�al de sincron�a se utiliza para indicarle al PC cu�l de las antenas est� conectada en cada instante de tiempo. La se�al de sincron�a se introduce al PC por el canal R de la entrada de audio. El conmutador debe ser un switch de diodo PIN de baja p�rdida, que es un interruptor con encapsulado coaxial de RF de banda ancha. Al tratarse de dise�os de diodo PIN, ofrece una velocidad de conmutaci�n r�pida de menos de 50 ns, con excelentes propiedades t�rmicas y circuiter�a de controlador compatible TTL para gesti�n l�gica precisa. Debe ser de una entrada con 4 salidas y controlado con dos pines TTL.

Receptor: Puede ser cualquier receptor de comunicaciones con una salida de banda base. Se puede utilizar un receptor con salida de frecuencia intermedia de 10.7 Mhz y luego ponerle un convertidor a banda base. Es importante es el receptor tenga desactivado el control autom�tico de ganancia y cualquier otra funci�n que pueda alterar la forma de onda y amplitud de la se�al recibida.

Computadora personal: Una computadora con el sistema operativo Windows XP, 7, 8 o 10 y con entrada de audio. En su interior se encuentra instalado la aplicaci�n que recibe la se�al de Banda Base y Sincron�a.

Funcionamiento de la aplicaci�n del radiogoni�metro
La aplicaci�n recibe la se�al del goni�metro en banda base de 0 a 12Khz en paralelo con la se�al de sincron�a, extrae las amplitudes correspondientes a cada una de las antenas y aplica el algoritmo de c�lculo de marcaci�n. Esas dos se�ales se obtienen por los correspondientes canales L y R de la entrada de audio del PC.
En el software, en la gr�fica de Se�al de RF y Sincron�a, el gr�fico de arriba es la se�al de Banda Base arriba y el de abajo es la se�al de Sincron�a. Los rect�ngulos de color gris indican los intervalos de se�al que corresponden a cada una de las antenas y el m�s claro indica la primera antena. Los espacios entre los intervalos son para evitar procesar el ruido introducido por los conmutadores que alternan las antenas.
Para el c�lculo de marcaci�n se guardan las amplitudes de cada antena por separado en cuatro estructuras de datos del tipo Cola Finita. La funci�n de estas es almacenar una cantidad n de amplitudes consecutivas para que luego puedan ser utilizadas en el c�lculo de marcaci�n. Cada vez que se lee una amplitud de una antena, el valor de amplitud se coloca al inicio de la cola, y se elimina un valor de amplitud del final de la cola, es decir, el m�s viejo. 
Luego se calcula la media aritm�tica de todos los valores que se encuentran en cada una de las colas de las antenas y el resultado es utilizado para calcular la marcaci�n. Los valores de marcaci�n calculados son introducidos en una cola de marcaciones, que tambi�n es una cola finita. Estos valores son utilizados entonces para calcular la media aritm�tica y la desviaci�n est�ndar de las marcaciones.
El c�lculo de las marcaciones instant�neas consiste en asumir que las cuatro antenas est�n situadas en el centro de un sistema de coordenadas cartesiano. Las antenas A1 y A3 se encuentran en el eje Y siendo opuestas una a la otra, mientras que las antenas A2 y A4 se encuentran en el eje X, tambi�n de manera opuesta. Se calculan las componentes de un vector de la siguiente manera:

  Y = A1 � A3        X = A2 � A4

El vector representado por las componentes X e Y es la marcaci�n instant�nea del goni�metro para las amplitudes de las antenas A1, A2, A3 y A4. El �ngulo del vector se calcula mediante:

  �ngulo = ArcoTangente(Y / X)

En la implementaci�n del c�lculo de la funci�n de arco tangente, se evitan las indefiniciones y las divisiones por cero.
El m�dulo del vector se utiliza como un indicador de la amplitud de la se�al y la calidad de la marcaci�n. Se obtiene con:

  M�dulo^2 = X2 + Y2

El alternador del radiogoni�metro cambia las antenas en el orden A1, A2, A3 y A4, consider�ndose esto como un ciclo de rotaci�n. En un tiempo de 20 milisegundos el goni�metro realiza aproximadamente 5 ciclos de rotaci�n, de los cuales solo se emplean los 4 primeros ciclos.

Dise�ador y programador: Santiago A. Orellana P�rez
Email: tecnochago@gmail.com
M�vil: +53 54635944
SetV+, La Habana, Cuba, 2013-2022
