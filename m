Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922907B701D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 19:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjJCRnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 13:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjJCRnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 13:43:04 -0400
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2123.outbound.protection.outlook.com [40.107.239.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75931C9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 10:43:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ry/FvKaywwPZcXe5PDTSx/HaKPLrxZdmRTLj1sC4eVGW1VnWXvZVLq23oBuALOlcipm77MZrGifeeHJ6GXBRBXOwxPziIpGOqF4Bgk1tcc/FsiaQHI6WG6AValSEQwB0kWkafjMyXnCIyW4k07o/z4fWBnqwQ5OzHXuUG8CchapW38gYtDxvoEFyHUWGPLtAjkgrlRtj3WZbl9zohGqY4kbI1XblluyOiR2tpzVEzTWAYxWu2OLkNXqRbQKh86uTx0RHHxKM+qxNQgWPlCH8dvGyVjN7WEunKLULMQAY6wKvVDRpr38rvdeGtfWZmnqLKTDs2Vazof1SPum2PiQM6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3rz0rl/9LeKhuBUHmyY9MM1X8rW1tCsPIg48+Gy15H4=;
 b=B0cKUz0Xd46avbNH90kc3tjjGn+SzspQYVIKke+/9H5F2LVp0gV/iGt9MYMpxv+kar9JRWBQxHPe02AS02o5LaZncELT46kgp+E5Tmi42VIKxBKuqDQXtyH2xmv6i1/eeuATS+duTCIyFAWcxUiNySE1m8szJbQWUEGW50jcDTG0LIANnq2qerJHIxDXTJcur/0X2ZN9zJKLGYRxlcS0siFnQtrlC8z0K+LEpyjqNGnJOwc12M9UhBgmJ6BK02+25AuOZCaXblt9b20a1y0yk1bXcy5pRgy14IlP8+zkTGTThrsMFxh6yDUxHOr5oCZwSqkYTsAYZoY5bc7f8I7nBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=globalprospectinfo.onmicrosoft.com; dmarc=pass action=none
 header.from=globalprospectinfo.onmicrosoft.com; dkim=pass
 header.d=globalprospectinfo.onmicrosoft.com; arc=none
Received: from PN2P287MB0398.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:f2::11)
 by PNXP287MB0029.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 17:42:57 +0000
Received: from PN2P287MB0398.INDP287.PROD.OUTLOOK.COM
 ([fe80::543e:619e:90c9:a8c]) by PN2P287MB0398.INDP287.PROD.OUTLOOK.COM
 ([fe80::543e:619e:90c9:a8c%4]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 17:42:57 +0000
From:   Ellie Madison <EllieMadison@globalprospectinfo.onmicrosoft.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: vger Construction Purchasing and Procurement List
Thread-Topic: vger Construction Purchasing and Procurement List
Thread-Index: AQHZ9iELiZCZYlcFs0K5ajRuW+c/Vg==
Date:   Tue, 3 Oct 2023 17:42:57 +0000
Message-ID: <e50383f3-6dda-0f7c-e911-b9a167a68478@globalprospectinfo.onmicrosoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none
 header.from=globalprospectinfo.onmicrosoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN2P287MB0398:EE_|PNXP287MB0029:EE_
x-ms-office365-filtering-correlation-id: 62bb784d-28b2-4949-4393-08dbc4382e32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QZMKLz54ZvURZ5GjNC5Mtxp93aQ7jJJY66loEhTtBN4kVJsWNdLymWdGCUeOO3X12N1MyY2H4xTr3LM9svByTT9hcOVxoOzowEY+NpogyQMIeNoRuDHZ7xOB1lW0p7tNOdhG6k3z5Qd/DOALJ1IeDe1twjTMvnbm8ZaTN6jlfNH4lsqFwivVEwjzEcAHM4bDY1ogFX7qM59PXu209z5rb5YS49zT1EC0bECrhV+OH2ROpygTHBjrtB5djr6xtRhjTI+qIwWses2yXr9zo6QnW8Mcv+sFqpjA1ROp4X+c7lxu/1z63y1JX5ia38aWt/gXkH54TOshyl355NSCzOL5lfExzOMxBd79VE05XQcu/ny41TAViwLgbDis7DhgkrveFoog/HZt4F41Bg2VE1YsctK4jwWfUfoHG09qHi5+h2oAZ6mPTR2SGSaYGh/+4EtnU1krIQepCrpm07gDLpHyDZCZ30hJPOXqO9n4Hs8JI3t34YRbFeRdPKHzaXEIexRoEfg6L/Mels/KsRiv+mcAaDZi7z4Uf3I3oL2F+YHjaZ5kbjFfeBB0Lhkmok/8FPZR9T5fP2/GvMNmCkFWqYc56vitRRQKsPTUeMNQNDXqJTCH3aNL057S5xySLwhnJDlcvyc2pVu/sQPwn7B+yLsUaGmyh+/LXBuRJLWPqIdPBq+GzduCrfshekVTD4/sEHPRRen78s84JDRfRJByyYNEJ5ZeWcQeFkc3Bzs55oE/mTyPu/DTTVRkn3u3NZkhdBB8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2P287MB0398.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39850400004)(366004)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(53546011)(6506007)(71200400001)(6486002)(478600001)(2616005)(6512007)(83380400001)(26005)(66946007)(91956017)(2906002)(41300700001)(76116006)(8676002)(316002)(8936002)(6916009)(5660300002)(66476007)(66556008)(66446008)(64756008)(38100700002)(38070700005)(122000001)(31696002)(86362001)(66899024)(31686004)(13220200019)(437434003)(581174003)(6396002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWFsTW92REloYTFpbVdXWkx2V292ZFNETXZOMG1SRVdsUktYaTczRXNtY1Ay?=
 =?utf-8?B?ZmVneUp1MmRzMEtLNE9kYlllczg4aENIMUE5N2VtQVM3YkYwRE1wTHRLQ1NB?=
 =?utf-8?B?RDcyUTRabmdlT1Z1NHdSQ1lkOENWSFNQRDJpZWJMTkoxZXNNSVErM3JvL3J1?=
 =?utf-8?B?ck9kYW9NU1ZmVmZjSm5GMDdBcHB4MEM1L2lWMzVad25xdWxmTFBFRDZYVVNv?=
 =?utf-8?B?VXBJZzNTdW1BR3RsRFVBNDhxdlJXT0JuMS9mOFBxK0twbWd0UjFWdzNLZ1dv?=
 =?utf-8?B?SFhDc0tnclFjajVhYUNGYWQ5cUFETEgrQUp5cVh6Ri9OaTVPSFh5UXpnY2JQ?=
 =?utf-8?B?WVIrd0xWY3VjWGJKQmErODNOdGg5aEV4UlF1NnBUaWtWVXJmcGhKNzlGV2ZP?=
 =?utf-8?B?Q2kvcnpCM3dRc2JGcmY5VzRPbmE5SlpydWh5dkhRWFIzWS9iaWIrUTFKcHE2?=
 =?utf-8?B?a3dUdkpCdkFlVFZieklYVC84djh5cjZSUGdCSlhnRU1JV3E5S1RlWExiOWUv?=
 =?utf-8?B?ZjlDTlFTek1LVjBhejNwTVNqclA1MXFiL0R5TDRhNGNwOFd3RHMzdk1WQXZr?=
 =?utf-8?B?d2ZlaUNYRFZTV2FSaXZ0ejJZTVVNYTJDNXJGU2FMbkwrUGk1VkZCTVdyYUtN?=
 =?utf-8?B?b1BDQVUwdU1BakJHZnNXOUxqNlI1S0VTY0hKVVE5aFduWkcrUy91V1FkY2kw?=
 =?utf-8?B?K29zZEhJakpJR2I0VmttUXBsbGt3akliSHN1NFBXVVVmRjliN0VKN3U5alJl?=
 =?utf-8?B?bE0vM0luZE55YkZMVy9kY1ljTkEzUW55NlkrZ3g3aVM1cDJiSnFDN2s2UjBm?=
 =?utf-8?B?S2tJR2IwNnZoV2VLKytXNXhBbkU5QWtsMnNHcGk0dksvcDVQNWRUYUd4a0FY?=
 =?utf-8?B?eTF2emFmcGdTVTZwTHZtNnVvUVB5YUdJcWdWRUtqRHZLZTJDUFVoeEVWcU4r?=
 =?utf-8?B?d0xCcXFRamxNUFNXdDJIdThKRlVwbGJlY3h6VTgvUFp1OHJ2Z1FTQ05reW1L?=
 =?utf-8?B?V3FsYWJMMlQwQ05pZnNtODJPeXhqQ2hMYUhwL2o1QldhZ2lXR1hWTU9TMTlw?=
 =?utf-8?B?M1J4anBXMW5DV3FkOFpLSmJEeC90RDhLTE1uVFNRblNVazZhbTlLdHRHYlpj?=
 =?utf-8?B?a2xoejVaYmd2NzFNWkVMZ2Nia04reEd6ekJRbHY3VytRMnMzaGd4R0pyUVBL?=
 =?utf-8?B?bmtBTGlEajk4ZXhkOTF2Mjl1d2dHcWlnOVZlVHFzQ293U1loZkdRbG5iUUxP?=
 =?utf-8?B?QVNsMFFUQXRRUXVzbm9UTUdLeHpkaG1uaWxQNEhHT2RoR3Q1NVJSYUdRK3Q1?=
 =?utf-8?B?M0ErK2ZJazNXOEN4UHVTSjROUkkrWnRHdm4yUDRsNWlqdW8wZEZPV2orWlc4?=
 =?utf-8?B?OFNIbTAxZFpBLzlTYWd6ak1pSTVZMWwrNFRjSTBCYnVHSkFHV2VPVWV5S3FQ?=
 =?utf-8?B?Z0ZGVGgwYnpGbDhvTGtpUkZDbmRSYzdIT1ZzMzZNVFF4STZyTGJ6TTlVNUV5?=
 =?utf-8?B?T3dLd3VnYy9tNkRPUTFpSGJ6Q1pTbGFGaW9RYXZrc2JURmE3L1ZZQ0pCREFx?=
 =?utf-8?B?VjFiZlRIdi9abGdNbjdKTm4yL3hYcit2akRZNHZqVkgzVTkrQmxrVmJLbC96?=
 =?utf-8?B?WXF3TkVLSFptVVl5aDQxWVFoYTc2Umk4QzJRWS9pZ3pZN2Vub2hKeXpURnp5?=
 =?utf-8?B?V0k4NDBEcjdSVWhIb1YybUtZL3RUaXR0WDZXUEs4aERrdE5PaGNCN0tMd1ht?=
 =?utf-8?B?WGNSWTYzM2dpVGdxSHptM3FoSFBrbWhFVWpxdzd0aHVMWlY5ZDJ2QS9VbE5k?=
 =?utf-8?B?QVUvUFNqWDZlTkFHQjhnMyt4QWpzcFJ1QVhHVmpxeGxFSVlqa0xDRUJEOWxK?=
 =?utf-8?B?QklibFZuRVgyRVVQTmxaMlBYYlVlVVFrMDB5enBjR1RxdGFpaUtieFRDWUpL?=
 =?utf-8?B?bk9lMXZvdjVka05zcVQzMUVaUGQ0d0VIdXZHcDN1NDJRY2JPdWxkZmJITnQz?=
 =?utf-8?B?L2MvOUxteWdOZkxveEhvcDcwWkJJVTI3VE5DTjR2bWpyMUg4S2I1Ty9sazhK?=
 =?utf-8?B?MFJzK1locE9Lc0cwcll4TWlKQW9CMFM2TU1LcDlFOVNUNlI0ZDFuZXNhK09j?=
 =?utf-8?B?SENJZUk4WFdLaG9RTWJTaUVmK3NObnFELytkNkp5cnBVM2JNcFpjaC9XVUdW?=
 =?utf-8?Q?SU2MtsMgq5bCH0WcYhDRNjEOOcSbbM7+q0mrITtCm6ov?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <777A24F7CBE17E458C8CE4E3AD7C4057@INDP287.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: globalprospectinfo.onmicrosoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN2P287MB0398.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bb784d-28b2-4949-4393-08dbc4382e32
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 17:42:57.5006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: db40464e-9457-4711-afa4-9dcb114e15d9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hkVk6QqPnqN0GCwc5WZx6Zey1oJRZt3jl7MJRvNm32O6eIVMD7JRzdOjvJXorLyHZIQTVDIvkaSwMXO6h09+FJSTZnT+4o2EQ4rpsExpS4UTsdl7Eh6astqVk0hY3rn4fg3ansLv5M//XyxYo1F4bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXP287MB0029
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_50,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkp1c3Qgd2FudGVkIHRvIG1ha2Ugc3VyZSB5b3UgcmVjZWl2ZWQgbXkgbGFzdCBlbWFp
bCByZWdhcmRpbmcgYSANCmN1c3RvbWl6ZWQgbGlzdCBvZiBDb25zdHJ1Y3Rpb24gbWFuYWdlcnMs
IFB1cmNoYXNpbmcgYW5kIFByb2N1cmVtZW50IA0KbWFuYWdlcnMsIE1haW50ZW5hbmNlIE1hbmFn
ZXJzLCBIVkFDIGNvbnRyYWN0b3JzLCBBcmNoaXRlY3RzIGV0Yy4gSeKAmW0gDQpsb29raW5nIHRv
IGZpbmQgdGhlIHJpZ2h0IHBlcnNvbiB3aG8gbG9va3MgYWZ0ZXIgeW91ciBtYXJrZXRpbmcgYW5k
IGxlYWQgDQpnZW5lcmF0aW9uLg0KDQpXZSBoZWxwIGNvbXBhbmllcyBncm93IHNhbGVzIHJldmVu
dWUgd2l0aCBvdXIgaGlnaGx5IHRhcmdldGVkIGVtYWlsIA0KbGlzdHMgZGlyZWN0bHkgc291cmNl
ZC4NCg0KUGxlYXNlIGxldCB1cyBrbm93IHlvdXIgdGFyZ2V0IGluZHVzdHJpZXMgYW5kIGpvYiB0
aXRsZXMgc28gd2UgY2FuIHNlbmQgDQp5b3UgdGhlIG51bWJlcnMgb2YgY29udGFjdHMuDQoNClJl
Z2FyZHMsDQpFbGxpZQ0KDQpFbGxpZSBNYWRpc29ufCBNYXJrZXRpbmcgQ29uc3VsdGFudA0KDQoN
Ck9uIDI3LTAyLTIwMjMgMTE6NDMsIEVsbGllIE1hZGlzb24gd3JvdGU6DQoNCkhpLA0KDQpXb3Vs
ZCB5b3UgYmUgaW50ZXJlc3RlZCBpbiBhY3F1aXJpbmcgYW4gdXBkYXRlZCBlbWFpbC9jb250YWN0
IGRhdGFiYXNlIA0KZm9yIHlvdXIgbWFya2V0aW5nIGFuZCBzYWxlcyBjYW1wYWlnbnM/DQoNCiDC
oMKgwqDCoMKgwqDCoCBDb25zdHJ1Y3Rpb24gbWFuYWdlcnMNCiDCoMKgwqDCoMKgwqDCoCBQdXJj
aGFzaW5nIGFuZCBQcm9jdXJlbWVudCBtYW5hZ2Vycw0KIMKgwqDCoMKgwqDCoMKgIE1haW50ZW5h
bmNlIE1hbmFnZXJzDQogwqDCoMKgwqDCoMKgwqAgRmFjaWxpdGllcywgSFZBQyBjb250cmFjdG9y
cw0KIMKgwqDCoMKgwqDCoMKgIEJ1aWxkaW5nIE1hbmFnZXJzDQogwqDCoMKgwqDCoMKgwqAgQ29u
c3RydWN0aW9uIG1hbmFnZXJzDQogwqDCoMKgwqDCoMKgwqAgQXJjaGl0ZWN0cw0KIMKgwqDCoMKg
wqDCoMKgIENvbnN0cnVjdGlvbiBTdXBlcmludGVuZGVudA0KIMKgwqDCoMKgwqDCoMKgIFByb2pl
Y3QvY29uc3RydWN0aW9uIG9wZXJhdGlvbnMNCg0KV2UgY2FuIHN1cHBseSBjb250YWN0cyBvZiB2
YXJpb3VzIGpvYiByb2xlcyBmcm9tIHNldmVyYWwgaGllcmFyY2hpZXMgLSANCmZvciBleDogQyBT
dWl0LCBWUHMsIERpcmVjdG9ycywgTWFuYWdlcnMsIGFuZCBzdGFmZuKApg0KDQpJbmR1c3RyaWVz
Og0KSW5mb3JtYXRpb24gVGVjaG5vbG9neSB8RmluYW5jZSB8QWR2ZXJ0aXNpbmcgJiBNYXJrZXRp
bmcgfENvbnN0cnVjdGlvbiANCmFuZCBSZWFsIGVzdGF0ZSB8Q2hhcml0eSBhbmQgTkdP4oCZcyB8
RWR1Y2F0aW9uIHxQdWJsaXNoaW5nIHxSZXRhaWwgfCANCkNvbnN1bWVyIHwgTWFudWZhY3R1cmlu
ZyB8R292ZXJubWVudCAmIHB1YmxpYyBhZ2VuY2llcyB8RWxlY3Ryb25pY3MgYW5kIA0KVGVsZWNv
bW11bmljYXRpb25zIHxJbmR1c3RyeSBhc3NvY2lhdGlvbnMgfEhlYWx0aGNhcmUgfCBIb3NwaXRh
bGl0eSANCnxMZWdhbCBTZXJ2aWNlcyB8Rm9vZCAmIEJldmVyYWdlcyB8TWVkaWEgJiBFbnRlcnRh
aW5tZW50IHxFbmVyZ3kgYW5kIA0KY2hlbWljYWxzIHxBZXJvc3BhY2UgYW5kIERlZmVuc2UgfFRy
YW5zcG9ydGF0aW9uIGFuZCBMb2dpc3RpY3MgRVRDLg0KDQpXZSB3b3VsZCBiZSBoYXBweSB0byBj
dXN0b21pemUgeW91ciBsaXN0IGFjY29yZGluZ2x5IGZvciBhbnkgb3RoZXIgDQpyZXF1aXJlbWVu
dHMgdGhhdCB5b3UgaGF2ZS4NCg0KQXBwcmVjaWF0ZSB5b3VyIHJlc3BvbnNlLg0KDQoNClJlZ2Fy
ZHMsDQpFbGxpZQ0KDQpFbGxpZSBNYWRpc29ufCBNYXJrZXRpbmcgQ29uc3VsdGFudA0KDQpSZXBs
eSBvbmx5IG9wdC1vdXQgaW4gdGhlIHN1YmplY3QgbGluZSB0byByZW1vdmUgZnJvbSB0aGUgbWFp
bGluZyBsaXN0Lg0KDQo=
