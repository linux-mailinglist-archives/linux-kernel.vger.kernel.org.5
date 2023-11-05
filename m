Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4517E163B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 21:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjKEUIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 15:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjKEUIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 15:08:48 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E06E0
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 12:08:44 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 3BFAA2C04A9;
        Mon,  6 Nov 2023 09:08:41 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1699214921;
        bh=g6RXCo04frUesFvf/QIvpgpd8aabW7MEvFEC8JNSWKU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=LmpeRzV740tcUNijBXiYgYT3QqkGxa5VWMp7A3GNHLnzUBzNJG49BLn0xaM1rRNDC
         7rb+IdGv2G1d2LBhj62sRiIncR711VDVnvPfOaVvDYng/xzDKQMxicGlR9SBTX/Imr
         3AJNuiA6nWzp3nTWWyAFw48DLLEUQw8J0klAUGsXPD8hs26KTWhlinR4FxlQrHxyRI
         +oeDz17XZVzh0XNhp84hRUWpDGA6t+n83pRZpPHQ+U8qjkZqS/ZdgmUUDO9n88yvYM
         gTNB5/JvDNrTEZcLQatA+b8eoasA1IeQTrbdPI4rgJRbo0aMDduDWFMyHRHQTidkyK
         AUGY5HTa5NoJw==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6547f6490001>; Mon, 06 Nov 2023 09:08:41 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 6 Nov 2023 09:08:40 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.039; Mon, 6 Nov 2023 09:08:40 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     kernel test robot <lkp@intel.com>
CC:     "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: drivers/mux/adg792a.c:134:34: warning: 'adg792a_of_match' defined
 but not used
Thread-Topic: drivers/mux/adg792a.c:134:34: warning: 'adg792a_of_match'
 defined but not used
Thread-Index: AQHaD6V1uBpGUb6bDkuY7FNjKTV7n7BrToMA
Date:   Sun, 5 Nov 2023 20:08:40 +0000
Message-ID: <726dbd21-15b7-4afc-9c6e-7121d5ee5589@alliedtelesis.co.nz>
References: <202311051347.7J6bthD7-lkp@intel.com>
In-Reply-To: <202311051347.7J6bthD7-lkp@intel.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AEED9D15F3936D43AF2B46EF6EBA4E17@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=L6ZjvNb8 c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=62ntRvTiAAAA:8 a=VwQbUJbxAAAA:8 a=i3X5FwGiAAAA:8 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8 a=W2WdRe_UxMzz2S3kzvEA:9 a=QEXdDO2ut3YA:10 a=pToNdpNmrtiFLRE6bQ9Z:22 a=AjGcO6oz07-iQ99wixmX:22 a=mmqRlSCDY2ywfjPLJ4af:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiA1LzExLzIzIDE4OjAyLCBrZXJuZWwgdGVzdCByb2JvdCB3cm90ZToNCj4gSGkgQ2hyaXMs
DQo+DQo+IEZpcnN0IGJhZCBjb21taXQgKG1heWJlICE9IHJvb3QgY2F1c2UpOg0KPg0KPiB0cmVl
OiAgIGh0dHBzOi8vc2Nhbm1haWwudHJ1c3R3YXZlLmNvbS8/Yz0yMDk4OCZkPXM2TEg1WTdIaUNK
MWI2LTRvUC0tRk1QX05Jb0tva01EM2lPbmE4d3RNdyZ1PWh0dHBzJTNhJTJmJTJmZ2l0JTJla2Vy
bmVsJTJlb3JnJTJmcHViJTJmc2NtJTJmbGludXglMmZrZXJuZWwlMmZnaXQlMmZ0b3J2YWxkcyUy
ZmxpbnV4JTJlZ2l0IG1hc3Rlcg0KPiBoZWFkOiAgIGFlYTZiZjkwOGQ3MzBiMDFiZDI2NGE4ODIx
MTU5ZGI5NDYzYzExMWMNCj4gY29tbWl0OiBlOWU0MDU0M2FkNWIzOGI4NDg4Nzk3NjgzNTlmZDEz
NjUwNTI5OTYxIHNwaTogQWRkIGdlbmVyaWMgU1BJIG11bHRpcGxleGVyDQo+IGRhdGU6ICAgMyB5
ZWFycywgOSBtb250aHMgYWdvDQo+IGNvbmZpZzogaTM4Ni1yYW5kY29uZmlnLTAwNC0yMDIzMTEw
MSAoaHR0cHM6Ly9zY2FubWFpbC50cnVzdHdhdmUuY29tLz9jPTIwOTg4JmQ9czZMSDVZN0hpQ0ox
YjYtNG9QLS1GTVBfTklvS29rTUQzbk9qYTV3dE5nJnU9aHR0cHMlM2ElMmYlMmZkb3dubG9hZCUy
ZTAxJTJlb3JnJTJmMGRheS1jaSUyZmFyY2hpdmUlMmYyMDIzMTEwNSUyZjIwMjMxMTA1MTM0NyUy
ZTdKNmJ0aEQ3LWxrcCU0MGludGVsJTJlY29tJTJmY29uZmlnKQ0KPiBjb21waWxlcjogZ2NjLTEy
IChEZWJpYW4gMTIuMi4wLTE0KSAxMi4yLjANCj4gcmVwcm9kdWNlICh0aGlzIGlzIGEgVz0xIGJ1
aWxkKTogKGh0dHBzOi8vc2Nhbm1haWwudHJ1c3R3YXZlLmNvbS8/Yz0yMDk4OCZkPXM2TEg1WTdI
aUNKMWI2LTRvUC0tRk1QX05Jb0tva01EM25HbGJaa3VZQSZ1PWh0dHBzJTNhJTJmJTJmZG93bmxv
YWQlMmUwMSUyZW9yZyUyZjBkYXktY2klMmZhcmNoaXZlJTJmMjAyMzExMDUlMmYyMDIzMTEwNTEz
NDclMmU3SjZidGhENy1sa3AlNDBpbnRlbCUyZWNvbSUyZnJlcHJvZHVjZSkNCj4NCj4gSWYgeW91
IGZpeCB0aGUgaXNzdWUgaW4gYSBzZXBhcmF0ZSBwYXRjaC9jb21taXQgKGkuZS4gbm90IGp1c3Qg
YSBuZXcgdmVyc2lvbiBvZg0KPiB0aGUgc2FtZSBwYXRjaC9jb21taXQpLCBraW5kbHkgYWRkIGZv
bGxvd2luZyB0YWdzDQo+IHwgUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50
ZWwuY29tPg0KPiB8IENsb3NlczogaHR0cHM6Ly9zY2FubWFpbC50cnVzdHdhdmUuY29tLz9jPTIw
OTg4JmQ9czZMSDVZN0hpQ0oxYjYtNG9QLS1GTVBfTklvS29rTUQzaW1rWjhzc1pRJnU9aHR0cHMl
M2ElMmYlMmZsb3JlJTJla2VybmVsJTJlb3JnJTJmb2Uta2J1aWxkLWFsbCUyZjIwMjMxMTA1MTM0
NyUyZTdKNmJ0aEQ3LWxrcCU0MGludGVsJTJlY29tJTJmDQo+DQo+IEFsbCB3YXJuaW5ncyAobmV3
IG9uZXMgcHJlZml4ZWQgYnkgPj4pOg0KPg0KPj4+IGRyaXZlcnMvbXV4L2FkZzc5MmEuYzoxMzQ6
MzQ6IHdhcm5pbmc6ICdhZGc3OTJhX29mX21hdGNoJyBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1
bnVzZWQtY29uc3QtdmFyaWFibGU9XQ0KPiAgICAgICAxMzQgfCBzdGF0aWMgY29uc3Qgc3RydWN0
IG9mX2RldmljZV9pZCBhZGc3OTJhX29mX21hdGNoW10gPSB7DQo+ICAgICAgICAgICB8ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn4NCj4NCj4NCj4gdmlt
ICsvYWRnNzkyYV9vZl9tYXRjaCArMTM0IGRyaXZlcnMvbXV4L2FkZzc5MmEuYw0KPg0KPiBhZmRh
MDhjNGNhYTk0OCBkcml2ZXJzL211eC9tdXgtYWRnNzkyYS5jIFBldGVyIFJvc2luIDIwMTctMDUt
MTQgIDEzMw0KPiBhZmRhMDhjNGNhYTk0OCBkcml2ZXJzL211eC9tdXgtYWRnNzkyYS5jIFBldGVy
IFJvc2luIDIwMTctMDUtMTQgQDEzNCAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQg
YWRnNzkyYV9vZl9tYXRjaFtdID0gew0KPiBhZmRhMDhjNGNhYTk0OCBkcml2ZXJzL211eC9tdXgt
YWRnNzkyYS5jIFBldGVyIFJvc2luIDIwMTctMDUtMTQgIDEzNSAgCXsgLmNvbXBhdGlibGUgPSAi
YWRpLGFkZzc5MmEiLCB9LA0KPiBhZmRhMDhjNGNhYTk0OCBkcml2ZXJzL211eC9tdXgtYWRnNzky
YS5jIFBldGVyIFJvc2luIDIwMTctMDUtMTQgIDEzNiAgCXsgLmNvbXBhdGlibGUgPSAiYWRpLGFk
Zzc5MmciLCB9LA0KPiBhZmRhMDhjNGNhYTk0OCBkcml2ZXJzL211eC9tdXgtYWRnNzkyYS5jIFBl
dGVyIFJvc2luIDIwMTctMDUtMTQgIDEzNyAgCXsgfQ0KPiBhZmRhMDhjNGNhYTk0OCBkcml2ZXJz
L211eC9tdXgtYWRnNzkyYS5jIFBldGVyIFJvc2luIDIwMTctMDUtMTQgIDEzOCAgfTsNCj4gYWZk
YTA4YzRjYWE5NDggZHJpdmVycy9tdXgvbXV4LWFkZzc5MmEuYyBQZXRlciBSb3NpbiAyMDE3LTA1
LTE0ICAxMzkgIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIGFkZzc5MmFfb2ZfbWF0Y2gpOw0KPiBh
ZmRhMDhjNGNhYTk0OCBkcml2ZXJzL211eC9tdXgtYWRnNzkyYS5jIFBldGVyIFJvc2luIDIwMTct
MDUtMTQgIDE0MA0KPg0KPiA6Ojo6OjogVGhlIGNvZGUgYXQgbGluZSAxMzQgd2FzIGZpcnN0IGlu
dHJvZHVjZWQgYnkgY29tbWl0DQo+IDo6Ojo6OiBhZmRhMDhjNGNhYTk0ODk1MTE1NTdkZWY1MWUz
MjJhNWYyMTQyYTJmIG11eDogYWRnNzkyYTogYWRkIG11eCBjb250cm9sbGVyIGRyaXZlciBmb3Ig
QURHNzkyQS9HDQo+DQo+IDo6Ojo6OiBUTzogUGV0ZXIgUm9zaW4gPHBlZGFAYXhlbnRpYS5zZT4N
Cj4gOjo6Ojo6IENDOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24u
b3JnPg0KDQpJJ20gZ29ubmEgZ28gYWhlYWQgYW5kIHBsZWFkIGlubm9jZW50IG9uIHRoaXMgb25l
Lg0KDQo+
