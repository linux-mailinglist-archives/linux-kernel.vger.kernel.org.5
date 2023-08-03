Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE9276E397
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbjHCIto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjHCItm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:49:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC40EA;
        Thu,  3 Aug 2023 01:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691052573; x=1691657373; i=deller@gmx.de;
 bh=bzU/DY7mdYpfn0S9DqToc27/WAJmlqec0o1NGo7EVfE=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=mkCxQXNYajAIUDkR97qiIy9czikpQAXR/itV4cSvBGOwLcyly5kZ5r0jgeHCb5ZVyELE0UB
 LsWbiOcXNHe4YswAVh9/hOuFfPOWuuoux5vA2APANrfow/hK6gwFxV25jwcL5nq+53/fLDD1j
 Pyg6QUGLS/0TNqeeAlLE7QX2c68SA3AF/OOhxV6QHRRCiDCdLnjAyaguLtFu43yqUiyfFlOEF
 B3AfvQQkfYRzZ0LaKa5v/Aujwo7nV+c8FcLTiOtBkE8RPU7khAD4L1YfTObdnhqaJ9dq7yfwX
 f2lGUHcJ08PBh0Uy1A3KNjMEK6KsxPvygSBOjzpggrlrp7aJoPLg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.147.53]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5VD8-1plB4g3qLi-016ynS; Thu, 03
 Aug 2023 10:49:32 +0200
Message-ID: <0b4e25c8-af53-3cd3-3710-c5831752482f@gmx.de>
Date:   Thu, 3 Aug 2023 10:49:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] parisc: kernel: Add require space after that ','
Content-Language: en-US
To:     hanyu001@208suo.com, James.Bottomley@HansenPartnership.com
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_A984B205A9D93A7668CF1721A52EBA2B820A@qq.com>
 <6a7de5f72aac9c6e71a5b484e7beb6b1@208suo.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <6a7de5f72aac9c6e71a5b484e7beb6b1@208suo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:1xtQVohfU3C6Q37FxeUeo7zdXiyqT11xijhvtdiYbEiWfbxLkQy
 A871+9azgRwQpJHwmh6PfWc0bWaCj5PWB7LAG1kPUhxs8y1ixAgI2N6sTPbYXS+PETX01BR
 7+rZgqo4WWsxZRTTSzF0xhM14N6E/V19LKY1Y0onR26x6h06ebTOZ49ThSY+tHFYgqQi3lx
 MXJ6ixPyPIKLrJbG4fChg==
UI-OutboundReport: notjunk:1;M01:P0:hGTdX5chB1A=;OsEKEXnhI6c8RgaKnNBGCT/Lk82
 wrKbXomYnvkMJojhPdhhKpPbO3c1gJsxTuf4Fpzr7mZsuTllFtZKxy0i01rH4k5husC0Nnlim
 hTD7hRscI3hNoGr2PgjtfIL4uPEpBr5ETLhJZYYtAW1in1dMxhcmBH+rVNHMBLv7UYL+74OiD
 HdwLEHGJiZWg7LlIeEkad/ba6qUHYnWVvZzI7GGPA425pk5DJZ+F5DSXrTSPHmKYd3NZNtVXQ
 q7iqD14/9+gXPtN+QyFiW+3A+IZwZYOLnLiNLZpBTFvD/WFtlW+/a8G2MFAJAzpWy54VxUyfW
 SSZekDYyxMTiZ/eYtj7d1FaKA/76rVd59soUmhJ4eGAfjjzIC/AKjOYFmKNztOJCzIXNB0eDR
 fbZoWhTAzFCHQSPd7k1li2bBB8ZCbyK8Yvn+lVJup8XvVMRpc9KB1uKZfd9P79LDGowcZk71D
 F2F17H1FtubQ/ugrpkU6EKiO5d0xCMwBuA6eHz9hPiBBgg3KOu9C+nNoiq0iBWeL7pboeWeQv
 o5WxGKCE9Y9Dj8nZByoIllg1g2AFUcYAtPkufD0UFffkZnwSlx2yJoUIVW0pKoB0c6M7hTY1n
 pTV9LZFDc5x4cVHCU7SWmFUeWfjncVV6Vsc7P4XbKjcv7ehU8MpR8AO9IHlKf5X92lW908+98
 tj+aGPC84H+V0dB1VVsHOXGCZJFT7/Y4hWG32wKgA2DJsJwsRnwrAUuYWBkBPoc0RooRR8R4K
 8qCJnGl1SL4YH96km+hU2FRKo8OdUle+94Li3v1q5oafFBV+fSdkS5mnyaqNhodNr/jFpDjw0
 MF91W9uK8Wgs1L3iBMGVgMpUc4T1Kjp7vZ1H7lPdYHPlc+dMxKyozujFXDiFzeBDf3tJSi6GZ
 RO8dFjwR9vNaSEFsUEZr+L44iMzN+mNGraZnsOZHF5YXBIt6YFDg+IXA138dxTB0D8YimIAgx
 skFW9Ntw7ugjY+cJApjhIgiKa40=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8yMC8yMyAwODo0MCwgaGFueXUwMDFAMjA4c3VvLmNvbSB3cm90ZToNCj4gRml4IGNoZWNr
cGF0Y2ggd2FybmluZ3M6DQo+IA0KPiAuL2FyY2gvcGFyaXNjL2tlcm5lbC91bmFsaWduZWQuYzo1
MjI6IEVSUk9SOiBzcGFjZSByZXF1aXJlZCBhZnRlciB0aGF0ICcsJyAoY3R4OlZ4VikNCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IFl1IEhhbiA8aGFueXUwMDFAMjA4c3VvLmNvbT4NCg0KSGFueXUsIHRo
YW5rcyBmb3IgeW91ciBwYXRjaGVzIQ0KDQpZb3Ugc2hvdWxkIHVzZSBhbm90aGVyIGVtYWlsIHBy
b2dyYW0sIG9yIHVzZSBnaXQgc2VuZC1tYWlsIGJlY2F1c2UNCnlvdXIgZW1haWwgcHJvZ3JhbSBz
ZWVtcyB0byBjb252ZXJ0IHRhYnMgdG8gc3BhY2VzIG9yIGJyZWFrcyBsaW5lcywNCnNvIHRoYXQg
SSBjYW4ndCBjbGVhbmx5IGFwcGx5IHNvbWUgb2YgeW91ciBwYXRjaGVzLg0KDQpJJ3ZlIGFwcGxp
ZWQgdGhpcyBvbmUsIGJ1dCBwbGVhc2UgcmVzZW5kIHRoZSBvdGhlciBwYXRjaGVzIGlmIHlvdSB3
YW50Lg0KDQpIZWxnZQ0KDQo+IC0tLQ0KPiAgwqBhcmNoL3BhcmlzYy9rZXJuZWwvdW5hbGlnbmVk
LmMgfCAxNiArKysrKysrKy0tLS0tLS0tDQo+ICDCoDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlv
bnMoKyksIDggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9wYXJpc2Mva2Vy
bmVsL3VuYWxpZ25lZC5jIGIvYXJjaC9wYXJpc2Mva2VybmVsL3VuYWxpZ25lZC5jDQo+IGluZGV4
IDc1MmQwZDAuLjNkMzQ2ZjIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcGFyaXNjL2tlcm5lbC91bmFs
aWduZWQuYw0KPiArKysgYi9hcmNoL3BhcmlzYy9rZXJuZWwvdW5hbGlnbmVkLmMNCj4gQEAgLTQ3
Miw3ICs0NzIsNyBAQCB2b2lkIGhhbmRsZV91bmFsaWduZWQoc3RydWN0IHB0X3JlZ3MgKnJlZ3Mp
DQo+ICDCoMKgwqDCoCBjYXNlIE9QQ09ERV9MRFdBX0k6DQo+ICDCoMKgwqDCoCBjYXNlIE9QQ09E
RV9MRFdfUzoNCj4gIMKgwqDCoMKgIGNhc2UgT1BDT0RFX0xEV0FfUzoNCj4gLcKgwqDCoMKgwqDC
oMKgIHJldCA9IGVtdWxhdGVfbGR3KHJlZ3MsIFIzKHJlZ3MtPmlpciksMCk7DQo+ICvCoMKgwqDC
oMKgwqDCoCByZXQgPSBlbXVsYXRlX2xkdyhyZWdzLCBSMyhyZWdzLT5paXIpLCAwKTsNCj4gIMKg
wqDCoMKgwqDCoMKgwqAgYnJlYWs7DQo+IA0KPiAgwqDCoMKgwqAgY2FzZSBPUENPREVfU1RIOg0K
PiBAQCAtNDgxLDcgKzQ4MSw3IEBAIHZvaWQgaGFuZGxlX3VuYWxpZ25lZChzdHJ1Y3QgcHRfcmVn
cyAqcmVncykNCj4gDQo+ICDCoMKgwqDCoCBjYXNlIE9QQ09ERV9TVFc6DQo+ICDCoMKgwqDCoCBj
YXNlIE9QQ09ERV9TVFdBOg0KPiAtwqDCoMKgwqDCoMKgwqAgcmV0ID0gZW11bGF0ZV9zdHcocmVn
cywgUjIocmVncy0+aWlyKSwwKTsNCj4gK8KgwqDCoMKgwqDCoMKgIHJldCA9IGVtdWxhdGVfc3R3
KHJlZ3MsIFIyKHJlZ3MtPmlpciksIDApOw0KPiAgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsNCj4g
DQo+ICDCoCNpZmRlZiBDT05GSUdfNjRCSVQNCj4gQEAgLTQ4OSwxMiArNDg5LDEyIEBAIHZvaWQg
aGFuZGxlX3VuYWxpZ25lZChzdHJ1Y3QgcHRfcmVncyAqcmVncykNCj4gIMKgwqDCoMKgIGNhc2Ug
T1BDT0RFX0xEREFfSToNCj4gIMKgwqDCoMKgIGNhc2UgT1BDT0RFX0xERF9TOg0KPiAgwqDCoMKg
wqAgY2FzZSBPUENPREVfTEREQV9TOg0KPiAtwqDCoMKgwqDCoMKgwqAgcmV0ID0gZW11bGF0ZV9s
ZGQocmVncywgUjMocmVncy0+aWlyKSwwKTsNCj4gK8KgwqDCoMKgwqDCoMKgIHJldCA9IGVtdWxh
dGVfbGRkKHJlZ3MsIFIzKHJlZ3MtPmlpciksIDApOw0KPiAgwqDCoMKgwqDCoMKgwqDCoCBicmVh
azsNCj4gDQo+ICDCoMKgwqDCoCBjYXNlIE9QQ09ERV9TVEQ6DQo+ICDCoMKgwqDCoCBjYXNlIE9Q
Q09ERV9TVERBOg0KPiAtwqDCoMKgwqDCoMKgwqAgcmV0ID0gZW11bGF0ZV9zdGQocmVncywgUjIo
cmVncy0+aWlyKSwwKTsNCj4gK8KgwqDCoMKgwqDCoMKgIHJldCA9IGVtdWxhdGVfc3RkKHJlZ3Ms
IFIyKHJlZ3MtPmlpciksIDApOw0KPiAgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsNCj4gIMKgI2Vu
ZGlmDQo+IA0KPiBAQCAtNTAyLDI0ICs1MDIsMjQgQEAgdm9pZCBoYW5kbGVfdW5hbGlnbmVkKHN0
cnVjdCBwdF9yZWdzICpyZWdzKQ0KPiAgwqDCoMKgwqAgY2FzZSBPUENPREVfRkxEV1M6DQo+ICDC
oMKgwqDCoCBjYXNlIE9QQ09ERV9GTERXWFI6DQo+ICDCoMKgwqDCoCBjYXNlIE9QQ09ERV9GTERX
U1I6DQo+IC3CoMKgwqDCoMKgwqDCoCByZXQgPSBlbXVsYXRlX2xkdyhyZWdzLEZSMyhyZWdzLT5p
aXIpLDEpOw0KPiArwqDCoMKgwqDCoMKgwqAgcmV0ID0gZW11bGF0ZV9sZHcocmVncywgRlIzKHJl
Z3MtPmlpciksIDEpOw0KPiAgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsNCj4gDQo+ICDCoMKgwqDC
oCBjYXNlIE9QQ09ERV9GTEREWDoNCj4gIMKgwqDCoMKgIGNhc2UgT1BDT0RFX0ZMRERTOg0KPiAt
wqDCoMKgwqDCoMKgwqAgcmV0ID0gZW11bGF0ZV9sZGQocmVncyxSMyhyZWdzLT5paXIpLDEpOw0K
PiArwqDCoMKgwqDCoMKgwqAgcmV0ID0gZW11bGF0ZV9sZGQocmVncywgUjMocmVncy0+aWlyKSwg
MSk7DQo+ICDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOw0KPiANCj4gIMKgwqDCoMKgIGNhc2UgT1BD
T0RFX0ZTVFdYOg0KPiAgwqDCoMKgwqAgY2FzZSBPUENPREVfRlNUV1M6DQo+ICDCoMKgwqDCoCBj
YXNlIE9QQ09ERV9GU1RXWFI6DQo+ICDCoMKgwqDCoCBjYXNlIE9QQ09ERV9GU1RXU1I6DQo+IC3C
oMKgwqDCoMKgwqDCoCByZXQgPSBlbXVsYXRlX3N0dyhyZWdzLEZSMyhyZWdzLT5paXIpLDEpOw0K
PiArwqDCoMKgwqDCoMKgwqAgcmV0ID0gZW11bGF0ZV9zdHcocmVncywgRlIzKHJlZ3MtPmlpciks
IDEpOw0KPiAgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsNCj4gDQo+ICDCoMKgwqDCoCBjYXNlIE9Q
Q09ERV9GU1REWDoNCj4gIMKgwqDCoMKgIGNhc2UgT1BDT0RFX0ZTVERTOg0KPiAtwqDCoMKgwqDC
oMKgwqAgcmV0ID0gZW11bGF0ZV9zdGQocmVncyxSMyhyZWdzLT5paXIpLDEpOw0KPiArwqDCoMKg
wqDCoMKgwqAgcmV0ID0gZW11bGF0ZV9zdGQocmVncywgUjMocmVncy0+aWlyKSwgMSk7DQo+ICDC
oMKgwqDCoMKgwqDCoMKgIGJyZWFrOw0KPiANCj4gIMKgwqDCoMKgIGNhc2UgT1BDT0RFX0xEQ0Rf
SToNCg0K
