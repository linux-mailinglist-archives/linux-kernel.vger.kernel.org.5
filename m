Return-Path: <linux-kernel+bounces-21757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432508293D6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69AC31C256E3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 06:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913E9364CF;
	Wed, 10 Jan 2024 06:50:05 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9561381B9;
	Wed, 10 Jan 2024 06:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40A6nXNo9900522, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40A6nXNo9900522
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 14:49:34 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Wed, 10 Jan 2024 14:49:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Jan 2024 14:49:33 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c]) by
 RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c%5]) with mapi id
 15.01.2507.035; Wed, 10 Jan 2024 14:49:33 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>, Ping-Ke Shih
	<pkshih@realtek.com>,
        Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v16 13/13] MAINTAINERS: Add the rtase ethernet driver entry
Thread-Topic: [PATCH net-next v16 13/13] MAINTAINERS: Add the rtase ethernet
 driver entry
Thread-Index: AQHaP8vQTB7kTA8Rr0mZDOjtA/EuGLDKkyQAgAgPPVA=
Date: Wed, 10 Jan 2024 06:49:33 +0000
Message-ID: <29d0a5e51b2e4237aa85badf2358d350@realtek.com>
References: <20240105112811.380952-1-justinlai0215@realtek.com>
 <20240105113257.381090-1-justinlai0215@realtek.com>
 <20240105113257.381090-9-justinlai0215@realtek.com>
 <ZZfrauRNNJsUGCRr@nanopsycho>
In-Reply-To: <ZZfrauRNNJsUGCRr@nanopsycho>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

> Fri, Jan 05, 2024 at 12:32:57PM CET, justinlai0215@realtek.com wrote:
> >Add myself and Larry Chiu as the maintainer for the rtase ethernet drive=
r.
> >
> >Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> >---
> > MAINTAINERS | 7 +++++++
> > 1 file changed, 7 insertions(+)
> >
> >diff --git a/MAINTAINERS b/MAINTAINERS
> >index 53b7ca804465..239aae94dc0f 100644
> >--- a/MAINTAINERS
> >+++ b/MAINTAINERS
> >@@ -18476,6 +18476,13 @@ L:    linux-remoteproc@vger.kernel.org
> > S:    Maintained
> > F:    drivers/tty/rpmsg_tty.c
> >
> >+RTASE ETHERNET DRIVER
> >+M:    Justin Lai <justinlai0215@realtek.com>
> >+M:    Larry Chiu <larry.chiu@realtek.com>
> >+L:    netdev@vger.kernel.org
> >+S:    Maintained
>=20
> Quoting the beginning of the file:
>            Supported:   Someone is actually paid to look after this.
>            Maintained:  Someone actually looks after it.
>=20
> I guess it should be "Supported" in your case.

Thanks, I'll confirm this part.
>=20
>=20
> >+F:    drivers/net/ethernet/realtek/rtase/
> >+
> > RTL2830 MEDIA DRIVER
> > M:    Antti Palosaari <crope@iki.fi>
> > L:    linux-media@vger.kernel.org
> >--
> >2.34.1
> >
> >

