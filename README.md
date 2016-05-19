#TRABALHO FINAL DE REDES DE COMPUTADORES I - 2016/1

O trabalho consiste em desenvolver um simulador de rede. O simulador
deve receber como parâmetros de execução o nome de um arquivo de
descrição de topologia (conforme formato especificado), um nó origem,
um nó destino e uma mensagem. O simulador deve apresentar na saída as
mensagens enviadas pelos nós e roteadores da topologia conforme o
formato estabelecido, considerando o envio de um ping (ICMP Echo
Request) do nó origem até o nó destino contendo a mensagem indicada
por parâmetro. O simulador deverá realizar a transmissão da mensagem
através do ping respeitando a topologia da rede e necessidade de
fragmentação da mensagem conforme o MTU das interfaces de rede. O
simulador considera o MTU somente para fragmentar o campo de dados do
datagrama IP (cabeçalhos não são considerados no valor do MTU).

##Formato do arquivo de descrição de topologia

	#NODE
	<node_name>,<MAC>,<IP>,<MTU>,<gateway>
	#ROUTER
	<router_name>,<num_ports>,<MAC0>,<IP0>,<MTU0>,...,<MACn>,<IPn>,<MTUn>
	#ROUTERTABLE
	<router_name>,<net_dest>,<nexthop>,<port>

##Formato de saída

	Pacotes ARP Request: <src_name> box <src_name> : ARP - Who has <dst_IP>? Tell <src_IP>;
	Pacotes ARP Reply: <src_name> => <dst_name> : ARP - <src_IP> is at <src_MAC>;
	Pacotes ICMP Echo Request: <src_name> => <dst_name> : ICMP - Echo (ping) request (src=<src_IP> dst=<dst_IP> ttl=<TTL> data=<msg>);
	Pacotes ICMP Echo Reply: <src_name> => <dst_name> : ICMP - Echo (ping) reply (src=<src_IP> dst=<dst_IP> ttl=<TTL> data=<msg>);
	Processamento final do ICMP Echo Request/Reply no nó: <dst_name> rbox <dst_name> : Received <msg>;

##Modo de execução do simulador

```sh
simulador <topologia> <origem> <destino> <mensagem>
```

##Detalhes do simulador:

- TTL inicial dos pacotes IP deve ser igual a 8

- A topologia somente utilizará redes usando o modelo de classes (A, B
ou C), isto é, não serão utilizadas subredes

- A topologia não apresentará erros de configuração (loops, endereços
errados)

- o simulador deve ser executado a partir de um terminal por linha de
comando de acordo com o exemplo apresentado - não deve ser necessário
utilizar uma IDE para executar o simulador!!!

- O simulador pode ser implementado em qualquer linguagem

- A entrada e saída devem respeitar EXATAMENTE os formatos
apresentados

- O formato de saída é baseado na linguagem MsGenny. Sugere-se
verificar se a saída está correta através desse
[site](https://sverweij.github.io/mscgen_js. Usar o cabeçalho)
*wordwraparcs=true,hscale=2.0;* para facilitar a visualização.
