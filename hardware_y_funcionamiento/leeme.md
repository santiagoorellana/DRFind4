--RDFind4-- (2013-2022)
Radiogoniómetro de amplitud de cuatro antenas
El radiogoniómetro de amplitud de cuatro antenas está compuesto por los siguientes módulos:

Sistema de antenas: Cuatro antenas para cubrir la banda UHF, ortogonalmente opuestas una con respecto a la otra, de manera que cada una de las cuatro antenas dirige su máximo lóbulo hacia un punto cardinal geográfico. Las antenas deben cubrir toda la banda de recepción de manera regular y deben tener una amplitud de captación de 90 grados.

Alternador de antenas o conmutador: Contiene amplificadores de RF y filtros de banda ancha, así como el circuito de conmutación y generación de la señal de sincronía. La señal de sincronía se utiliza para indicarle al PC cuál de las antenas está conectada en cada instante de tiempo. La señal de sincronía se introduce al PC por el canal R de la entrada de audio. El conmutador debe ser un switch de diodo PIN de baja pérdida, que es un interruptor con encapsulado coaxial de RF de banda ancha. Al tratarse de diseños de diodo PIN, ofrece una velocidad de conmutación rápida de menos de 50 ns, con excelentes propiedades térmicas y circuitería de controlador compatible TTL para gestión lógica precisa. Debe ser de una entrada con 4 salidas y controlado con dos pines TTL.

Receptor: Puede ser cualquier receptor de comunicaciones con una salida de banda base. Se puede utilizar un receptor con salida de frecuencia intermedia de 10.7 Mhz y luego ponerle un convertidor a banda base. Es importante es el receptor tenga desactivado el control automático de ganancia y cualquier otra función que pueda alterar la forma de onda y amplitud de la señal recibida.

Computadora personal: Una computadora con el sistema operativo Windows XP, 7, 8 o 10 y con entrada de audio. En su interior se encuentra instalado la aplicación que recibe la señal de Banda Base y Sincronía.

Funcionamiento de la aplicación del radiogoniómetro
La aplicación recibe la señal del goniómetro en banda base de 0 a 12Khz en paralelo con la señal de sincronía, extrae las amplitudes correspondientes a cada una de las antenas y aplica el algoritmo de cálculo de marcación. Esas dos señales se obtienen por los correspondientes canales L y R de la entrada de audio del PC.
En el software, en la gráfica de Señal de RF y Sincronía, el gráfico de arriba es la señal de Banda Base arriba y el de abajo es la señal de Sincronía. Los rectángulos de color gris indican los intervalos de señal que corresponden a cada una de las antenas y el más claro indica la primera antena. Los espacios entre los intervalos son para evitar procesar el ruido introducido por los conmutadores que alternan las antenas.
Para el cálculo de marcación se guardan las amplitudes de cada antena por separado en cuatro estructuras de datos del tipo Cola Finita. La función de estas es almacenar una cantidad n de amplitudes consecutivas para que luego puedan ser utilizadas en el cálculo de marcación. Cada vez que se lee una amplitud de una antena, el valor de amplitud se coloca al inicio de la cola, y se elimina un valor de amplitud del final de la cola, es decir, el más viejo. 
Luego se calcula la media aritmética de todos los valores que se encuentran en cada una de las colas de las antenas y el resultado es utilizado para calcular la marcación. Los valores de marcación calculados son introducidos en una cola de marcaciones, que también es una cola finita. Estos valores son utilizados entonces para calcular la media aritmética y la desviación estándar de las marcaciones.
El cálculo de las marcaciones instantáneas consiste en asumir que las cuatro antenas están situadas en el centro de un sistema de coordenadas cartesiano. Las antenas A1 y A3 se encuentran en el eje Y siendo opuestas una a la otra, mientras que las antenas A2 y A4 se encuentran en el eje X, también de manera opuesta. Se calculan las componentes de un vector de la siguiente manera:

  Y = A1 – A3        X = A2 – A4

El vector representado por las componentes X e Y es la marcación instantánea del goniómetro para las amplitudes de las antenas A1, A2, A3 y A4. El ángulo del vector se calcula mediante:

  Ángulo = ArcoTangente(Y / X)

En la implementación del cálculo de la función de arco tangente, se evitan las indefiniciones y las divisiones por cero.
El módulo del vector se utiliza como un indicador de la amplitud de la señal y la calidad de la marcación. Se obtiene con:

  Módulo^2 = X2 + Y2

El alternador del radiogoniómetro cambia las antenas en el orden A1, A2, A3 y A4, considerándose esto como un ciclo de rotación. En un tiempo de 20 milisegundos el goniómetro realiza aproximadamente 5 ciclos de rotación, de los cuales solo se emplean los 4 primeros ciclos.

Diseñador y programador: Santiago A. Orellana Pérez
Email: tecnochago@gmail.com
Móvil: +53 54635944
SetV+, La Habana, Cuba, 2013-2022
