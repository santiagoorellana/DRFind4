--RDFind4-- (2013-2022)

Application and components for Four Antenna Amplitude Radio Direction Finder
For Delphi 6 and 7
This application is a simple sample of the use of the components.
To see details about how it works...

______________________________________

Four-antenna amplitude direction finder
The four-antenna amplitude direction finder is composed of the following modules:

Antenna system: Four antennas to cover the UHF band, orthogonally opposite each other, so that each of the four antennas directs its maximum lobe towards a geographic cardinal point. The antennas must cover the entire reception band on a regular basis and must have a pickup width of 90 degrees.

Antenna alternator or switch: Contains RF amplifiers and broadband filters, as well as the switching circuit and generation of the synchronization signal. The synchronization signal is used to tell the PC which of the antennas is connected at each instant of time. The sync signal is input to the PC through the R channel of the audio input. The switch shall be a low-loss PIN diode switch, which is a broadband RF coaxial encapsulated switch. Being PIN diode designs, they offer a fast switching speed of less than 50 ns, with excellent thermal properties and TTL compatible driver circuitry for precise logic management. It should be single input with 4 outputs and controlled with two TTL pins.

Receiver: This can be any communications receiver with a baseband output. You can use a receiver with an intermediate frequency output of 10.7 Mhz and then put a baseband converter on it. It is important that the receiver has automatic gain control disabled and any other function that may alter the waveform and amplitude of the received signal.

Personal Computer: A computer with Windows XP, 7, 8 or 10 operating system and with audio input. Inside it is installed the application that receives the Base Band and Synchronization signal.

How the radio direction finder app works
The application receives the baseband goniometer signal from 0 to 12Khz in parallel with the synchronization signal, extracts the amplitudes corresponding to each of the antennas and applies the bearing calculation algorithm. These two signals are obtained by the corresponding L and R channels of the PC audio input.
In the software, in the RF Signal and Sync graph, the top graph is the Baseband signal up and the bottom graph is the Sync signal. The gray rectangles indicate the signal intervals corresponding to each of the antennas and the lighter one indicates the first antenna. The spaces between the slots are to avoid processing noise introduced by the switches that toggle the antennas.

For the bearing calculation, the amplitudes of each antenna are stored separately in four data structures of the Finite Tail type. The function of these is to store a number n of consecutive amplitudes so that they can later be used in the bearing calculation. Each time an amplitude is read from an antenna, the amplitude value is placed at the start of the queue, and an amplitude value at the end of the queue, ie the oldest, is removed.
Then the arithmetic mean of all the values ​​found in each of the antenna tails is calculated and the result is used to calculate the bearing. The computed bearing values ​​are entered into a bearing queue, which is also a finite queue. These values ​​are then used to calculate the arithmetic mean and standard deviation of the bearings.

The calculation of the instantaneous bearings consists in assuming that the four antennas are located in the center of a Cartesian coordinate system. Antennas A1 and A3 are on the Y axis opposite each other, while antennas A2 and A4 are on the X axis, also opposite each other. The components of a vector are calculated as follows:

  Y = A1 – A3        X = A2 – A4
  
The vector represented by the X and Y components is the instantaneous bearing of the goniometer for the amplitudes of the antennas A1, A2, A3 and A4. The angle of the vector is calculated by:

  Angle = ArcTangent(Y / X)

In the implementation of the calculus of the arctangent function, uncertainties and divisions by zero are avoided.
The modulus of the vector is used as an indicator of the amplitude of the signal and the quality of the bearing. It is obtained with:

  Modulus^2 = X2 + Y2

The DF alternator changes the antennas in the order A1, A2, A3 and A4, this being considered as one cycle of rotation. In a time of 20 milliseconds, the goniometer performs approximately 5 rotation cycles, of which only the first 4 cycles are used.

Designer and programmer: Santiago A. Orellana Pérez
Email: tecnochago@gmail.com
Mobile: +53 54635944
SetV+, Havana, Cuba, 2013-2022