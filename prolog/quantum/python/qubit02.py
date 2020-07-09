# reading results from a run on an IBM q-computer

# run with: python qubit02.py `cat my_token.txt`

import sys
from qiskit import *

def set_up(token):
   IBMQ.save_account(token, overwrite=True)
   IBMQ.load_account()
   provider = IBMQ.get_provider(hub='ibm-q')
   return provider

def build_circuit(n):
   q = QuantumRegister(n)
   c = ClassicalRegister(n)
   circ = QuantumCircuit(q, c)

   for i in range(n):
      circ.h(q[i])

   circ.measure(q,c)
   print('Quantum Circuit')
   print(circ)
   return circ

def run_program(circuit, provider, backend):
   qcomputer = provider.get_backend(backend)
   job = execute(circuit, qcomputer, shots=1000)

   bits = job.result().get_counts()
   return bits

if __name__ == '__main__':
   token = sys.argv[1]
   backend = sys.argv[2]     # e.g.: ibmq_16_melbourne
   print('Running qcircuit with token', '<not tellin>')
   provider = set_up(token)
   circ = build_circuit(3)
   rv = run_program(circ, provider, backend)
   print('Result is', rv)

# $ python qubit02.py `cat my_token.txt` ibmq_16_melbourne
