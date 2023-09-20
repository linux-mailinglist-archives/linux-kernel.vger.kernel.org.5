Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC707A8092
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbjITMiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbjITMh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:37:56 -0400
Received: from cstnet.cn (smtp85.cstnet.cn [159.226.251.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F4BD8;
        Wed, 20 Sep 2023 05:37:49 -0700 (PDT)
Received: from wangchen20$iscas.ac.cn ( [222.95.63.58] ) by
 ajax-webmail-APP-13 (Coremail) ; Wed, 20 Sep 2023 20:37:36 +0800
 (GMT+08:00)
X-Originating-IP: [222.95.63.58]
Date:   Wed, 20 Sep 2023 20:37:36 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5rGq6L6w?= <wangchen20@iscas.ac.cn>
To:     "Emil Renner Berthing" <emil.renner.berthing@canonical.com>
Cc:     "Chen Wang" <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, conor@kernel.org, devicetree@vger.kernel.org,
        guoren@kernel.org, jszhang@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        xiaoguang.xing@sophgo.com, "Inochi Amaoto" <inochiama@outlook.com>
Subject: Re: Re: Re: [PATCH v2 09/11] riscv: dts: add initial SOPHGO SG2042
 SoC device tree
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.15 build 20230321(1bf45b10)
 Copyright (c) 2002-2023 www.mailtech.cn cnic.cn
In-Reply-To: <CAJM55Z_zgk+MAjymrzbNJadzJAxZDtZgoZ_kAbcEMOyLuk4OcA@mail.gmail.com>
References: <cover.1695189879.git.wangchen20@iscas.ac.cn>
 <ffe6a61a8879232aea7b86ff8aee5d681c6bd287.1695189879.git.wangchen20@iscas.ac.cn>
 <CAJM55Z-SYmGL-BjNi6EUKOrq34H=p1hRaRfkjGvBOqoKfacM1g@mail.gmail.com>
 <389a43ee.298cc.18ab27f3440.Coremail.wangchen20@iscas.ac.cn>
 <CAJM55Z_zgk+MAjymrzbNJadzJAxZDtZgoZ_kAbcEMOyLuk4OcA@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <5b888208.29977.18ab2988d67.Coremail.wangchen20@iscas.ac.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: twCowABHT5+Q5wpliVQMAA--.4340W
X-CM-SenderInfo: 5zdqwuhkhqji46lvutnvoduhdfq/1tbiAxIABmUKxXhbngADsD
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jmd0OyAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCiZndDsg5Y+R5Lu25Lq6OiAiRW1pbCBSZW5uZXIg
QmVydGhpbmciIDxlbWlsLnJlbm5lci5iZXJ0aGluZ0BjYW5vbmljYWwuY29tPgomZ3Q7IOWPkemA
geaXtumXtDogMjAyMy0wOS0yMCAyMDozMjoxNyAo5pif5pyf5LiJKQomZ3Q7IOaUtuS7tuS6ujog
Iuaxqui+sCIgPHdhbmdjaGVuMjBAaXNjYXMuYWMuY24+LCAiRW1pbCBSZW5uZXIgQmVydGhpbmci
IDxlbWlsLnJlbm5lci5iZXJ0aGluZ0BjYW5vbmljYWwuY29tPgomZ3Q7IOaKhOmAgTogIkNoZW4g
V2FuZyIgPHVuaWNvcm54d0BnbWFpbC5jb20+LCBhb3VAZWVjcy5iZXJrZWxleS5lZHUsIGNoYW8u
d2VpQHNvcGhnby5jb20sIGNvbm9yQGtlcm5lbC5vcmcsIGRldmljZXRyZWVAdmdlci5rZXJuZWwu
b3JnLCBndW9yZW5Aa2VybmVsLm9yZywganN6aGFuZ0BrZXJuZWwub3JnLCBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnLCBsaW51eC1yaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnLCBwYWxtZXJA
ZGFiYmVsdC5jb20sIHBhdWwud2FsbXNsZXlAc2lmaXZlLmNvbSwgeGlhb2d1YW5nLnhpbmdAc29w
aGdvLmNvbSwgIklub2NoaSBBbWFvdG8iIDxpbm9jaGlhbWFAb3V0bG9vay5jb20+CiZndDsg5Li7
6aKYOiBSZTogUmU6IFtQQVRDSCB2MiAwOS8xMV0gcmlzY3Y6IGR0czogYWRkIGluaXRpYWwgU09Q
SEdPIFNHMjA0MiBTb0MgZGV2aWNlIHRyZWUKJmd0OyAKJmd0OyDmsarovrAgd3JvdGU6CiZndDsg
Jmd0OwomZ3Q7ICZndDsgJmd0OyAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCiZndDsgJmd0OyAmZ3Q7
IOWPkeS7tuS6ujogIkVtaWwgUmVubmVyIEJlcnRoaW5nIiA8ZW1pbC5yZW5uZXIuYmVydGhpbmdA
Y2Fub25pY2FsLmNvbT4KJmd0OyAmZ3Q7ICZndDsg5Y+R6YCB5pe26Ze0OiAyMDIzLTA5LTIwIDE5
OjMyOjE5ICjmmJ/mnJ/kuIkpCiZndDsgJmd0OyAmZ3Q7IOaUtuS7tuS6ujogIkNoZW4gV2FuZyIg
PHVuaWNvcm54d0BnbWFpbC5jb20+LCBhb3VAZWVjcy5iZXJrZWxleS5lZHUsIGNoYW8ud2VpQHNv
cGhnby5jb20sIGNvbm9yQGtlcm5lbC5vcmcsIGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnLCBl
bWlsLnJlbm5lci5iZXJ0aGluZ0BjYW5vbmljYWwuY29tLCBndW9yZW5Aa2VybmVsLm9yZywganN6
aGFuZ0BrZXJuZWwub3JnLCBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmcsIGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcsIGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmcs
IHBhbG1lckBkYWJiZWx0LmNvbSwgcGF1bC53YWxtc2xleUBzaWZpdmUuY29tLCByb2JoK2R0QGtl
cm5lbC5vcmcsIHhpYW9ndWFuZy54aW5nQHNvcGhnby5jb20KJmd0OyAmZ3Q7ICZndDsg5oqE6YCB
OiAiQ2hlbiBXYW5nIiA8d2FuZ2NoZW4yMEBpc2Nhcy5hYy5jbj4sICJJbm9jaGkgQW1hb3RvIiA8
aW5vY2hpYW1hQG91dGxvb2suY29tPgomZ3Q7ICZndDsgJmd0OyDkuLvpopg6IFJlOiBbUEFUQ0gg
djIgMDkvMTFdIHJpc2N2OiBkdHM6IGFkZCBpbml0aWFsIFNPUEhHTyBTRzIwNDIgU29DIGRldmlj
ZSB0cmVlCiZndDsgJmd0OyAmZ3Q7CiZndDsgJmd0OyAmZ3Q7IENoZW4gV2FuZyB3cm90ZToKJmd0
OyAmZ3Q7ICZndDsgJmd0OyBNaWxrLVYgUGlvbmVlciBtb3RoZXJib2FyZCBpcyBwb3dlcmVkIGJ5
IFNPUEhPTidzIFNHMjA0Mi4KJmd0OyAmZ3Q7ICZndDsKJmd0OyAmZ3Q7ICZndDsgSGksCiZndDsg
Jmd0OyAmZ3Q7CiZndDsgJmd0OyAmZ3Q7IEknbSBqdXN0IHdvbmRlcmluZyB3aGF0IGlzIHRoZSBy
ZWxhdGlvbiBiZXR3ZWVuIFNPUEhPTiBhbmQgU09QSEdPPwomZ3Q7ICZndDsgJmd0OyBJIHRoaW5r
IG1vc3Qgb2YgdGhlIGNvbnRlbnQgcmVmZXJzIHRvIHRoZSBTb0MgYXMgU29waGdvIFNHMjA0MiBv
ciBTT1BIR08KJmd0OyAmZ3Q7ICZndDsgU0cyMDQyLCBidXQgaGVyZSB5b3UncmUgdXNpbmcgU09Q
SE9OLgomZ3Q7ICZndDsKJmd0OyAmZ3Q7ICJTT1BIR08iIGlzIHRoZSBjb21wYW55IG5hbWUsICJT
T1BIT04iIGlzIHRoZSBicmFuZCBuYW1lLiBUaGUgd2hvbGUgbmFtZSBvZiBTRzIwNDIgaXMgIlNP
UEhPTiBTRzIwNDIiLgomZ3Q7IAomZ3Q7IEFoLCBzbyBpbiB0aGlzIGNhc2UgKGFuZCBuZXh0IHBh
dGNoKSBpdCBzaG91bGQgYmUgZWl0aGVyICIuLnBvd2VyZWQgYnkgU09QSEdPJ3MKJmd0OyBTRzIw
NDIiIG9yICIuLnBvd2VyZWQgYnkgdGhlIFNPUEhPTiBTRzIwNDIiLCByaWdodD8KClllcywgIHlv
dSBhcmUgcmlnaHQsIEkgd2lsbCBjb3JyZWN0IHRoaXMgaW4gbmV4dCBwYXRjaCwgdGhhbmtzIGZv
ciB5b3VyIGNhcmVmdWxuZXNzLCBJJ20gbmVhcmx5IGNvbmZ1c2VkIGJ5IHRoaXMgdG9vIDpcCgom
Z3Q7IAomZ3Q7ICZndDsKJmd0OyAmZ3Q7ICZndDsKJmd0OyAmZ3Q7ICZndDsgQWxzbyBpdCB3b3Vs
ZCBiZSBncmVhdCBpZiB5b3UgY291bGQgZGVjaWRlIGlmIGl0J3Mgc3BlbGxlZCBTT1BIR08gb3Ig
U29waGdvIGFuZAomZ3Q7ICZndDsgJmd0OyBiZSBjb25zaXN0ZW50IGluIGFsbCB0aGVzZSBwYXRj
aGVzLgomZ3Q7ICZndDsKJmd0OyAmZ3Q7IFRoYW5rcywgSSB3aWxsIGRvdWJsZSBjaGVjayB0aGlz
IGluIG5leHQgcmV2aXNpb24uCiZndDsgJmd0OwomZ3Q7ICZndDsgJmd0OwomZ3Q7ICZndDsgJmd0
OyAvRW1pbAomZ3Q7ICZndDsgJmd0OwomZ3Q7ICZndDsgJmd0OyAmZ3Q7CjwvaW5vY2hpYW1hQG91
dGxvb2suY29tPjwvd2FuZ2NoZW4yMEBpc2Nhcy5hYy5jbj48L3VuaWNvcm54d0BnbWFpbC5jb20+
PC9lbWlsLnJlbm5lci5iZXJ0aGluZ0BjYW5vbmljYWwuY29tPjwvaW5vY2hpYW1hQG91dGxvb2su
Y29tPjwvdW5pY29ybnh3QGdtYWlsLmNvbT48L2VtaWwucmVubmVyLmJlcnRoaW5nQGNhbm9uaWNh
bC5jb20+PC93YW5nY2hlbjIwQGlzY2FzLmFjLmNuPjwvZW1pbC5yZW5uZXIuYmVydGhpbmdAY2Fu
b25pY2FsLmNvbT4=
