#!/usr/bin/env python3
import re
import json
import pymysql
import argparse

# TODO: Either parameterize these when we get more issues
issue = 'first_issue'
# The stat IDs map to an entry in bxt_ranking_categories with a ram_address
# that matches an the value in sram.asm/sram_int.asm
stat1 = 5
stat2 = 39
stat3 = 41

message_pattern = re.compile(r'NEWS_TITLE\s+EQUS\s+"\\"(.*?)\\""')
charmap_pattern = re.compile(r'charmap\s+\"(.+?)\",\s+\$([0-9a-f]{2})')

langs = {
    'jp': { 'suffix': '' },
    'en': { 'suffix': '_en' },
    'es': { 'suffix': '_es' },
    'de': { 'suffix': '_de' },
    'fr': { 'suffix': '_fr' },
    'it': { 'suffix': '_it' },
}

def load_charmap(suffix):
    charmap = {}
    with open(f'pokecrystal/charmap{suffix}.asm') as file:
        for line in file:
            m = charmap_pattern.search(line.strip())
            if m:
                charmap[m.group(1)] = int(m.group(2), 16)
    return charmap

def load_message(suffix):
    charmap = {}
    with open(f'news{suffix}/{issue}{suffix}.asm') as file:
        for line in file:
            m = message_pattern.search(line.strip())
            if m:
                # REON service automatically appends the '@' (0x50)
                return m.group(1).strip('@')
    return None

def encode_text(message, charmap):
    encoded = bytearray()
    length = len(message)
    idx = 0
    while idx < length:
        sub = message[idx]

        if idx < length -1:
            if sub == '<':
                end = message.index('>', idx)
                sub = message[idx:end]
                idx = end
            elif (sub == "'" or message[idx+1] == "'") and message[idx:idx+2] in charmap:
                sub = message[idx:idx+2]
                idx +=1

        char = charmap[sub]
        encoded.append(char)
        idx += 1
    return encoded

def load_news_file(suffix):
    with open(f'{issue}{suffix}.bin', mode='rb') as news:
        return news.read()

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('-c', '--config', default='config.json')
    args = parser.parse_args()

    with open(args.config, 'r') as file:
        config = json.load(file)

    for k, v in langs.items():
        v['charmap'] = load_charmap(v['suffix'])
        message = load_message(v['suffix'])
        v['message'] = encode_text(message, v['charmap'])
        v['news'] = load_news_file(v['suffix'])

    port = 3306
    host = config['mysql_host']
    if ':' in host:
        parts = host.split(':')
        host, port = parts[0], int(parts[1])

    conn = pymysql.connect(host=host, port=port,
                           user=config['mysql_user'],
                           password=config['mysql_password'],
                           database=config['mysql_database'],
                           charset='utf8mb4')

    with conn:
        with conn.cursor() as cursor:
            sql = (
                "INSERT INTO bxt_news (ranking_category_1,ranking_category_2,ranking_category_3,"
                "message_j,message_e,message_d,message_f,message_i,message_s,news_binary_j,"
                "news_binary_e,news_binary_d,news_binary_f,news_binary_i,news_binary_s) VALUES "
                "(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s);"
            )
            cursor.execute(sql, (
                stat1, stat2, stat3,
                langs['jp']['message'],
                langs['en']['message'],
                langs['de']['message'],
                langs['fr']['message'],
                langs['it']['message'],
                langs['es']['message'],
                langs['jp']['news'],
                langs['en']['news'],
                langs['de']['news'],
                langs['fr']['news'],
                langs['it']['news'],
                langs['es']['news'],
            ))
        conn.commit()
