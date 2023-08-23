Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFAF785874
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbjHWNBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbjHWNBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:01:37 -0400
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2096.outbound.protection.outlook.com [40.107.239.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C87E50
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:01:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BESyXQtcfvLUud2GT6H1NQHkJGyqX4FuTzr3/JKnJCkV273IhAREi6lyM1gKiTY5cVVsU8iU748LuMxGxpe9tCdS8hQbPswQwv0t+z9gf04E6Pte74PfAQe0n0AKE82PUwksZsLGq11Pde/hPorw0KX4CLnpP6DsjwKNBrKqt/7+org8WxaJ7ELraK1AffUe77WvFuX1kdklpyr5BKu3nF+7KT+9GDJieQBLukdMAd+kTDYKfaxBM2SBckDxeRoJOdYNZ7DlJJQcpTq9fg+TXLFMl9xdXHIQIaB50iAIvAzjxV2kY2exBQpte/0ccuYSWe9OiYjyk8TBGRFW3erFQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0P6iypVdP5pMKU8RDXXpjXnG8q7w/OJovGgVaW16pY=;
 b=XO8hj5QOoambKx+Z8YVdCfDQHuc6tLvH5jQk2SwbS0ZwDFh90jwUZvKh7PoL6pWc2DG6jSJssDoytuEELZZ4Lr3b0m4t+tR11ycFVXynuihfXPfV8tM/5v6fpuMKPQNa0a6Bsh1Hy1d9dc9oYxCGScTZ9b+mmGPShiwzC1+0sejxyybwmN0zPlq4fZxcETEDh3SQYir+xhDSGFvQ8KJxNGORWBTJRqjgFX+tj3HKx0qfIgNWWbcjVHlqCjw80Rft1Iz1GgPWNRhhdorhfBGEMiby47AcOCDBz6Bt+clSm3bb7g2uXNToDfnz2MdYCQEjTblIPKnTrfUE8PZ5Y6c6rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marketsdatainfousa.onmicrosoft.com; dmarc=pass action=none
 header.from=marketsdatainfousa.onmicrosoft.com; dkim=pass
 header.d=marketsdatainfousa.onmicrosoft.com; arc=none
Received: from PN0P287MB0603.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:166::10)
 by PN3P287MB1135.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:173::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 13:01:30 +0000
Received: from PN0P287MB0603.INDP287.PROD.OUTLOOK.COM
 ([fe80::3374:c0ec:d451:429]) by PN0P287MB0603.INDP287.PROD.OUTLOOK.COM
 ([fe80::3374:c0ec:d451:429%4]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 13:01:30 +0000
From:   Claire Davis <Claire.Davis@marketsdatainfousa.onmicrosoft.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: vger Electrical decision makers
Thread-Topic: vger Electrical decision makers
Thread-Index: AQHZ1cHvMB7KmaAwM02RjgL6W26kyw==
Date:   Wed, 23 Aug 2023 13:01:30 +0000
Message-ID: <7c79998f-d227-8a32-fb41-fcbeabc4e8e5@marketsdatainfousa.onmicrosoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none
 header.from=marketsdatainfousa.onmicrosoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB0603:EE_|PN3P287MB1135:EE_
x-ms-office365-filtering-correlation-id: 432992de-c26d-43a3-6a47-08dba3d911f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z9A1a8uB2mNhyuPaNkaU0Vvp/XuCzvYzpg90Ikesh84C8Wkt2w/i+ioiq8tVU61YgexljteL+12GB3qzjYE6cVb2wRDEuv+8a5raefNEHYre72NtQEs+1nRXFMZIwwvwrJ2RXM7ey/pZBj86antP6Jpmf5wGjX8T1fQKul2zI2v+r6Qo2ZKOZRVYleI3/SjAz90au7OPtAd04brY3hlID5VhvteJeRprS0qf8fSByN4gBzOCm3P+SBeoHmMMIJ75ei7bCif4GjZEreCt7uXBCoRlQweXwc7UgMWQZ0WBQ8TX9m3xr9T8ubd+UORQBQoQRrISpzT29blfcK3uZb3uGKaHaaKgTuKtzJMSOOIUk2lao3jnJMb1sZzp5XvI3UT/rBSph266tC+pnrhnZw1Oa1ukeASH8kV4D4kPGDk31thTjuiAE0Mx7XYibuEIXOaSZFCsVrfB3R7/lHysvZPZ4+7jgTH2pMGS8egS+H0xY34rmO9nrLEp/TbhHD/unnu6TKe4u7WR59o07d5pS035PLXuQ/GB8w7hdF++njdbW0hMOaLlu/K5OeEO0S/CDQoJK2yUjwVTNHEHCI6JkzSem45gEoUafkNxBWMcwpims8U0DS8IKL9o/pQhzpK2iwV09VqGBwex8HUGQqkKngEDq99Q21F77AhRl/kI5wx+5A359sgmgPF+t40jrnShEmtjeQP1A6xoWXLkOOsEj4SqkRYfF4tZ9GhMxFwhSADWHV3q8NA+Gpk/zQf3KDEombtX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB0603.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(136003)(39850400004)(1800799009)(186009)(451199024)(31696002)(86362001)(66899024)(5660300002)(2616005)(8936002)(8676002)(53546011)(2906002)(83380400001)(478600001)(6506007)(6486002)(71200400001)(66946007)(76116006)(66446008)(316002)(6916009)(66476007)(64756008)(66556008)(41300700001)(6512007)(91956017)(31686004)(38070700005)(38100700002)(122000001)(3480700007)(13220200019)(437434003)(581174003)(6396002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEVMSHBHY0FldHlHWE1FRTN2aHJSSWpOQjlnUThCaklhcVgxRzd6elZZeHE2?=
 =?utf-8?B?VGY4bWNLUFBJRm1zclUvaXVOa1EwNzQvVitLNW4rMmF2c29pZlFWeE1peS9U?=
 =?utf-8?B?Y2xVMTF6eWJFTHRWNjZSd2tCRWpCbGpHaGhqWlNVYVBqVy9pcktsTG9GRloz?=
 =?utf-8?B?U3VJZU95c3JzNldmRmRkM0Nmc1B6UUFQd2Zua0RpRk5QSndDbnVpUGZtclEv?=
 =?utf-8?B?c1JDRnA5aVlPY3FNTUdsTlBWdnRTNXpRUzlVUVRDWXpybVpVRVo1U1dqTFZp?=
 =?utf-8?B?MUVQNGRVQVlmQnNpS3lCUHlXelk4WmtubzZDT2hGaklYT1RiMEVvMGgwYmdy?=
 =?utf-8?B?NmpQRXROYm9GMmZRb0FtbnhzM0JpZ0Q0ODhYODRJSGtiRlZKRVVNSGhDcWUx?=
 =?utf-8?B?Q09yNVJObk5ULzNQaTBISW5KWnlzQnV6My9KOHFqLzBLREQxTm9wQ3A1dGFF?=
 =?utf-8?B?YXVidFJDNldaZFBPZTliNllhTU9ibS9RVWxDOGxscW9PS1VMVERkK3JBOXRB?=
 =?utf-8?B?dVZqQys5a0xNRUtHSDdNWEFTa3MyVi9XYlY5QnV5RXJhMVhjMVNUZGJ6dDVD?=
 =?utf-8?B?L2FibW9vRjhMTTFxZ1dkVTAzN1FHMjJhd2Fta0xUZDlRb2dYVnl0SDlxaGJN?=
 =?utf-8?B?MlIxZkZycER5ZURCZ0c0S3prOGF3d21HYzRiZ2hQSjR0WHJiSVI2WUxEVWhq?=
 =?utf-8?B?d3JNVGNUbG9hYlZwQUVpalArZmRMU0pkdXpaQTJ2ZzQ2anFlYzdGRFFDZjVH?=
 =?utf-8?B?U2EzcWRNRW1tYzN4MHVXRmM3clNNcFJ4SWszOFJxdmRTREFrZHd2bHV0WWwr?=
 =?utf-8?B?SWNLdGxxU3ZxODNhaENRbngyUEhiU3hKbnF0Y3hMS2JnS0FFRlZKSkdQMko4?=
 =?utf-8?B?Q29IQUErV1FLQmIxTDMrVWhLak9UTEc2MnhYVG9rM2dWeWlPOVpCQ1hlSWRk?=
 =?utf-8?B?SkYwT3lmQmVoYk9Id2lZUG43RWxWMmo4bll6ZnBjTElWM25VYXpzTm9YbEJm?=
 =?utf-8?B?bm41TGtMU2ZoQVNNMTdYditVU3M3Y1pPMVJIR05DWkk4YjVRN0JWZVNlT0M1?=
 =?utf-8?B?bkNucFFhV3Fra283aFNVQ0ZjemEvZHpIdFVIWG5PZTMwNEdvNWlTTStPRTNw?=
 =?utf-8?B?VkoxMVBPeVhIYXRMSXBRRFRDbHRFdFlJeDNTV0NuUVIybkVkeFdBdll1eEdl?=
 =?utf-8?B?aFowa3ltR2tPMllTSDRRejRTNUt4MUwrM3Ixa0JaOVNHa2ZRZS93MnZtTVp3?=
 =?utf-8?B?aHo4bmVQUW9xeEp1Z2p5MXhuRnpWQ3YyMk85dndyTGJaME83eVNweS9yWVpx?=
 =?utf-8?B?bXQ2N21iWGxpNldWYTQvaXJ0M21hT3FKRzBZc0h5TWYwdDdheFJEUTNSTEtl?=
 =?utf-8?B?UW9MM2h0S3lwYW5HUlU4T3k1OHozY01rZ0x2NVRRSG16VHRzR0ZOODAwRXRQ?=
 =?utf-8?B?WnVSTTIwTVFIVDdBRURwOCthZ2lhTUROV05yS2JPcXVVbHVCdlV4QnFjcVJx?=
 =?utf-8?B?a1ZSdVZaemxTRXZUVG1ZTXJmUC9qQnBzd1lpQnpwcVZlSUo1SCszNlUraVIw?=
 =?utf-8?B?ZzhpRlNyOHIrWW1pVjRVa3dyUDNvWU8yY1F0ZHVueFNEdHRidEczUkR0MTZw?=
 =?utf-8?B?clVQQndFaDFheDU0RlN1eUVjM2xuNCs4UE8rL05ZRVNtaUxLYlppdmcrdFFF?=
 =?utf-8?B?ZEpsYUxlZ3Z5bFlTS0JuZFZ5ajMwN3YyS1FoMTVkQkdTWUFKODBRWGhyWnBL?=
 =?utf-8?B?bU5FdXZsd0VkdGFOOXlMeGdaUEVmZjhsdXJ3Y0Z2b2RKVUxCUmEvRHhvZG5o?=
 =?utf-8?B?aEJMOVgyaE5WbzVwUkkzTnZMSEdBa1lJdlZxY2Z2Rmo4OTJ6ay8vSUxPLytk?=
 =?utf-8?B?bGtHWXowaGNtU0U5dW9uS01jSVBBVTJJRW1WMmVORUJENWRiVitKZmp3ZWQz?=
 =?utf-8?B?ZUU2OHNyN09JeG1raFRDOXR2YStkN28zUEZFMXcwVnJzQjYrelRPNWN4ME5R?=
 =?utf-8?B?UDV5MlhnUTQ4T1cxd0pSN2JaSzVUcWJBNDZURG4rVzE4UzNEVGRQTjk2U0Fy?=
 =?utf-8?B?RW9FTWFoaXhMMVY1bkZSalRpd3JGTU53anE4eFRUSmtlZ01FdGZTejJiSEdh?=
 =?utf-8?B?TWlxVnp6ZTlsU2dvcjI1dkh2eUpTd3IvMW1jb3NsVk5wSFNXbnlabk94VCtJ?=
 =?utf-8?B?UDFRdlhYT1ZlbzFhTmpNS2IvaXFacmU5MExPYkFpMnIwTXBCbFM1bkw1bFFO?=
 =?utf-8?B?UGs2UGJjLzBqakdSdjFtUFFhd1ByUnJvT01Dd3dnaHRKVzdseFkwV0lSTVpv?=
 =?utf-8?Q?VjKJCHr3WNCCGVKmp2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D8A694A593577479EDB6EEB1D0876C2@INDP287.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marketsdatainfousa.onmicrosoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB0603.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 432992de-c26d-43a3-6a47-08dba3d911f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 13:01:30.6706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 62dfda68-9244-4547-9a56-5a49125b28f2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dVZHbKuvZR1tj/QV34Ki3vz/EYJHgUPE28J0qtdK8tZ7oUVMuzpm3KbMiqqvXyLGfYYvCKDXeV9QxcZzvZYGJTwGsTK97s5ZoL4YUq5GkoErcCVjooUcqN8OF0YDucKGKnLILXlBy0LZpV2ITzdvlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1135
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkp1c3Qgd2FudGVkIHRvIG1ha2Ugc3VyZSB5b3UgcmVjZWl2ZWQgbXkgbGFzdCBlbWFp
bCByZWdhcmRpbmcgYSANCmN1c3RvbWl6ZWQgbGlzdCBvZiBUZWNobm9sb2d5IG9mZmljZXIsIElu
Zm9ybWF0aW9uIHNlY3VyaXR5IG9mZmljZXIsIA0KRWxlY3RyaWNhbCBFbmdpbmVlciAmIEVsZWN0
cmljaWFuIGV0YyBjb250YWN0cy4gSeKAmW0gbG9va2luZyB0byBmaW5kIHRoZSANCnJpZ2h0IHBl
cnNvbiB3aG8gbG9va3MgYWZ0ZXIgeW91ciBwcm9zcGVjdGluZyBhbmQgbGVhZCBnZW5lcmF0aW9u
Lg0KDQpXZSBoZWxwIGNvbXBhbmllcyBncm93IHNhbGVzIHdpdGggb3VyIGhpZ2hseSB0YXJnZXRl
ZCBlbWFpbCBsaXN0cy4NCg0KUGxlYXNlIGxldCB1cyBrbm93IHlvdXIgdGFyZ2V0IGluZHVzdHJp
ZXMgYW5kIGpvYiB0aXRsZXMgc28gd2UgY2FuIHNlbmQgDQp5b3UgdGhlIG51bWJlcnMgb2YgY29u
dGFjdHMuDQoNClJlZ2FyZHMsDQpDbGFpcmUNCg0KT24gMjAtMDMtMjAyMyAxMTo0MywgQ2xhaXJl
IERhdmlzIHdyb3RlOg0KDQpIaSwNCg0KV291bGQgeW91IGJlIGludGVyZXN0ZWQgaW4gcmVhY2hp
bmcgb3V0IHRvIHRvcCBsZXZlbCBJVCBhbmQgRWxlY3RyaWNhbCANCmRlY2lzaW9ucyBtYWtlcnPC
oCB0byBwcm9tb3RlL3NlbGwgeW91ciBwcm9kdWN0cyBhbmQgc2VydmljZXM/DQoNCiDCoMKgwqAg
Q1ZEIFRlY2hub2xvZ3kgb2ZmaWNlcg0KIMKgwqDCoCBJVCBPcGVyYXRpb25zDQogwqDCoMKgIENW
RCBJbmZvcm1hdGlvbiBzZWN1cml0eSBvZmZpY2VyDQogwqDCoMKgIEVsZWN0cmljYWwgc2Vydmlj
ZSBUZWNoDQogwqDCoMKgIFNlbmlvciBFbGVjdHJpY2FsIEVuZ2luZWVyDQogwqDCoMKgIEVsZWN0
cmljaWFuDQogwqDCoMKgIEFkbWluDQogwqDCoMKgIE93bmVycy9DRU8vUHJlc2lkZW50cyBldGMN
Cg0KV2Ugd291bGQgYmUgaGFwcHkgdG8gY3VzdG9taXplIHlvdXIgbGlzdCBhY2NvcmRpbmdseSBm
b3IgYW55IG90aGVyIA0KcmVxdWlyZW1lbnRzIHRoYXQgeW91IGhhdmUuIFBsZWFzZSBsZXQgbWUg
a25vdyBpbmR1c3RyaWVzIGFuZCBqb2IgdGl0bGVzIA0KeW91IHRhcmdldCBzbyBpIGNhbiBnZXQg
YmFjayB0byB5b3Ugd2l0aCBhZGRpdGlvbmFsIGluZm9ybWF0aW9uLg0KDQpSZWdhcmRzLA0KQ2xh
aXJlDQoNCkNsYWlyZSBEYXZpcyB8IE1hcmtldGluZyBDb25zdWx0YW50DQoNClJlcGx5IG9ubHkg
b3B0LW91dCBpbiB0aGUgc3ViamVjdCBsaW5lIHRvIHJlbW92ZSBmcm9tIHRoZSBtYWlsaW5nIGxp
c3QuDQo=
