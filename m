Return-Path: <linux-kernel+bounces-21684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5431C8292C2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 04:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78DB82886AE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DC94A34;
	Wed, 10 Jan 2024 03:19:26 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB69A23D0;
	Wed, 10 Jan 2024 03:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40A3J5ST0798027, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40A3J5ST0798027
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 11:19:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Wed, 10 Jan 2024 11:19:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Jan 2024 11:19:05 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c]) by
 RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c%5]) with mapi id
 15.01.2507.035; Wed, 10 Jan 2024 11:19:05 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Larry Chiu
	<larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v16 00/13] Add Realtek automotive PCIe driver
Thread-Topic: [PATCH net-next v16 00/13] Add Realtek automotive PCIe driver
Thread-Index: AQHaP8pIztIl3bxwT0KoCDd/vjQZBrDKuEWAgAeveMA=
Date: Wed, 10 Jan 2024 03:19:05 +0000
Message-ID: <47562ec509cd400493d3bcb7f04aef0d@realtek.com>
References: <20240105112811.380952-1-justinlai0215@realtek.com>
 <3fcf7b73-95e9-486b-8c14-1f92094d1316@lunn.ch>
In-Reply-To: <3fcf7b73-95e9-486b-8c14-1f92094d1316@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> On Fri, Jan 05, 2024 at 07:27:58PM +0800, Justin Lai wrote:
> > This series includes adding realtek automotive ethernet driver and
> > adding rtase ethernet driver entry in MAINTAINERS file.
> >
> > This ethernet device driver for the PCIe interface of Realtek
> > Automotive Ethernet Switch,applicable to RTL9054, RTL9068, RTL9072,
> > RTL9075, RTL9068, RTL9071.
>=20
> You should not resend a patch series in less than 24 hours. Even when you=
 mess
> up and do a partial send. As you have seen Jiri looked at your partial pa=
tch
> series and made a comment. Which you then ignored.... That wastes
> Maintainers time, which is not a good way to get your patches reviewed an=
d
> merged.
>=20
>     Andrew

Ok, I understand, thank you for reminding me, I will not do this again next=
 time a similar situation happens.

