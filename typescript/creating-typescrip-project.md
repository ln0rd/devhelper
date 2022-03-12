Como você já deve saber, o TypeScript vem crescendo bastante ultimamente, então é primordial que você conheça e saiba como começar um projeto nessa linguagem.

Felizmente, o TypeScript é não nenhum bicho de sete cabeças. Pelo contrário, essa linguagem não passa de JavaScript com algumas funcionalidades a mais. Ao longo desse artigo você verá o quão simples é começar um projeto nessa linguagem.

Eu irei utilizar o gerenciador de pacotes Yarn. Fique a vontade para utilizar qualquer um que você preferir.

Tudo o que eu fizer ficará disponível nesse repositório no GitHub: https://github.com/juanbelieni/typescript-iniciantes

Então, vamos começar.
Iniciando o projeto com o Yarn

Crie uma nova pasta e navegue até ela:

mkdir typescript-iniciantes
cd typescript-iniciantes

Inicie o projeto com Yarn:

```
yarn init -y
```

Após esses passos, um arquivo package.json vai aparecer na raiz do projeto com um conteúdo parecido com esse:

```
{
"name": "typescript-iniciantes",
"version": "1.0.0",
"main": "index.js",
"license": "MIT"
}
```

Agora, vamos adicionar o TypeScript.
Adicionando e configurando o TypeScript

Antes de adicionarmos o pacote, temos que ter em mente que o TypeScript é uma ferramenta de desenvolvimento. Em produção, o TypeScript é compilado diretamente para JavaScript.

Portanto, iremos adicionar o TypeScript como um pacote de desenvolvimento:

```
yarn add -D typescript
```

Após isso, temos que criar um arquivo chamado tsconfig.json, usando o comando:

```
yarn tsc --init
```

Ao abrir esse arquivo, é possível ver uma infinidade de opções. Mas calma! Vamos mexer em apenas duas por agora, já que não é o nosso foco nos aventurar por todas as possibilidades que o TypeScript nos oferece.

Continuando, localize no arquivo tsconfig.json as opções outDir e rootDir. Elas são importantes pois vão definir em qual pasta vai estar o código em TypeScript e em qual pasta ele vai ser compilado em JavaScript. Substitua os valores padrões pelos seguintes valores:

```
"outDir": "./build",
"rootDir": "./src",
```

Dessa maneira, o código em TypeScript deverá estar localizado na pasta src. Após compilado o código irá estar disponível na pasta build.

Se quiser fazer um teste, crie um arquivo index.ts dentro da pasta src contendo um console.log('Olá TypeScript') e execute o seguinte comando para ver a mágica acontecer:

```
yarn tsc
```

Criando os scripts build, start e dev

Até agora apenas adicionamos o TypeScript, porém ainda é necessário criar três scripts importantes para qualquer projeto nessa linguagem.
Esses scripts vão estar localizados no package.json:

```
{
"name": "typescript-iniciantes",
"version": "1.0.0",
"main": "index.js",
"license": "MIT",
"scripts": {

},
"devDependencies": {
"typescript": "^3.9.7"
}
}
```

Para executá-los, basta escrever yarn <script> ou npm run <script>, se você estiver usando NPM.
Os scripts build e start

Eles vão servir para compilar o código em JavaScript e executá-lo após isso.

```
"scripts": {
"build": "tsc",
"start": "node build/index.js"
},
```

O script dev

Esse script vai servir para que, quando estivermos no ambiente de desenvolvimento, não precisemos compilar o código toda vez que fizermos alguma alteração.

Para isso, vamos usar um pacote chamado ts-node-dev:

```
yarn add -D ts-node-dev
```

E após isso, basta adicionar o script com a flag --ignore-watch node_modules para que ele ignore a pasta node_modules:

```
"scripts": {
"build": "tsc",
"start": "node build/index.js",
"dev": "ts-node-dev --ignore-watch node_modules src/index.ts"
},
```

Começando o desenvolvimento

Agora que já configuramos tudo que era necessário, já podemos começar a desenvolver. Eu irei criar uma rota bem simples em Express para servir de exemplo. Para isso, eu irei adicionar o Express e o seu pacote de tipos:

```
yarn add express
yarn add -D @types/express
```

No arquivo src/ìndex.ts:

```
import express from 'express';

const app = express();
app.use(express.json());

interface RequestBody {
name: string;
}

app.post('/', (request, response) => {
const user = request.body as RequestBody;

return response.send({
message: `Hello ${user.name}`,
});
});

app.listen(3000, () => console.log('Listening 3000'));
```
