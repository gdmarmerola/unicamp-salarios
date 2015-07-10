from cStringIO import StringIO
from pdfminer.pdfinterp import PDFResourceManager, PDFPageInterpreter
from pdfminer.converter import TextConverter
from pdfminer.layout import LAParams
from pdfminer.pdfpage import PDFPage

def convert(fname, pages=None):
    if not pages:
        pagenums = set()
    else:
        pagenums = set(pages)

    output = StringIO()
    manager = PDFResourceManager()
    converter = TextConverter(manager, output, laparams=LAParams())
    interpreter = PDFPageInterpreter(manager, converter)

    infile = file(fname, 'rb')
    for page in PDFPage.get_pages(infile, pagenums):
        interpreter.process_page(page)
    infile.close()
    converter.close()
    text = output.getvalue()
    output.close
    return text

fname = "remuneracao.pdf"

#converter pdf para texto
text = convert(fname)

#strings problemáticas
text = text.replace(",", ".")
text = text.replace("Remunera\xc3\xa7\xc3\xa3o\nL\xc3\xadquida", "Remuneracao Liquida")
text = text.replace("Remunera\xc3\xa7\xc3\xa3o\nBruta", "Remuneracao Bruta")
text = text.replace("Descontos\nLegais", "Descontos Legais")

#quebrar em páginas
pages = text.split("MENSAL JUNHO/2015")

pages.pop(0)

tabela = dict()

#criar dict() com colunas do pdf
for i, page in enumerate(pages):

    columns = page.split("\n\n")

    for element in columns:

        values = element.split("\n")

        if len(values) > 1:

            header = unicodedata.normalize('NFKD', values[0].decode("utf-8")).encode('ascii','ignore')

            try:
                tabela[header].extend(values[1:])
            except KeyError:
                tabela[header] = values[1:]

#criar arquvo .txt no formato de tabela para ser lido no R
processed_string = "{}\t{}\t{}\t{}\t{}\t{}\n".format(tabela.keys()[0],
                                                     tabela.keys()[1],
                                                     tabela.keys()[2],
                                                     tabela.keys()[3],
                                                     tabela.keys()[4],
                                                     tabela.keys()[5])

for i in range(len(tabela[tabela.keys()[0]])):
    
    processed_string += "{}\t{}\t{}\t{}\t{}\t{}\n".format(tabela[tabela.keys()[0]][i],
                                                          tabela[tabela.keys()[1]][i],
                                                          tabela[tabela.keys()[2]][i],
                                                          tabela[tabela.keys()[3]][i],
                                                          tabela[tabela.keys()[4]][i],
                                                          tabela[tabela.keys()[5]][i])

#salvar processed_string...

