Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2689178DE76
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242223AbjH3TDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244344AbjH3NAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:00:16 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D6A132
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:00:13 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-72-ghgLKwR4MNqb2ZVtsa0Jyw-1; Wed, 30 Aug 2023 14:00:08 +0100
X-MC-Unique: ghgLKwR4MNqb2ZVtsa0Jyw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 30 Aug
 2023 14:00:06 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 30 Aug 2023 14:00:06 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Masahiro Yamada' <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
CC:     "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH] kbuild: single-quote the format string of printf
Thread-Topic: [PATCH] kbuild: single-quote the format string of printf
Thread-Index: AQHZ2zYMiPMplwqfeUe66jkcyc3HB7ACzGyA
Date:   Wed, 30 Aug 2023 13:00:06 +0000
Message-ID: <231e031b803041e0ba248d1efbc98dfd@AcuMS.aculab.com>
References: <20230829113531.4004730-1-masahiroy@kernel.org>
 <ZO3d7DrfKfsDXqa5@bergen.fjasle.eu>
 <CAK7LNATvUo7gKFG9NjtJarTBM508ntf2v6yo5tXsmDoMcUrJVA@mail.gmail.com>
In-Reply-To: <CAK7LNATvUo7gKFG9NjtJarTBM508ntf2v6yo5tXsmDoMcUrJVA@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Li4uDQo+IEFsbCBvZiAiXFxuIiwgIlxuIiwgJ1xuJyBhcmUgdGhlIHNhbWUuDQoNCmFuZCBcXG4g
KHdpdGhvdXQgYW55IHF1b3RlIGNoYXJhY3RlcnMgYXQgYWxsKS4NCg0KUGVyc29uYWxseSBJJ2Qg
dXNlICdmb3JtYXQnIGZvciBwcmludGYuDQpUbyBtYWtlIGl0IG9idmlvdXMgdGhhdCBub3RoaW5n
IGlzIHRvIGJlIGV4cGFuZGVkLg0KQnV0IGl0IGlzbid0IHJlYWxseSB3b3J0aCBjaGFuZ2luZyBl
eGlzdGluZyAnc3R1ZmYnLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2Vz
aWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVL
DQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

