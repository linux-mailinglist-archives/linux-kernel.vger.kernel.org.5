Return-Path: <linux-kernel+bounces-17643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3472E825085
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38DD2835E3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B64225D0;
	Fri,  5 Jan 2024 09:04:16 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ACF20DC9;
	Fri,  5 Jan 2024 09:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40593vvY62289953, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40593vvY62289953
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jan 2024 17:03:57 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 5 Jan 2024 17:03:58 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 5 Jan 2024 17:03:57 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::5d58:7838:d352:d6b8]) by
 RTEXDAG02.realtek.com.tw ([fe80::5d58:7838:d352:d6b8%5]) with mapi id
 15.01.2375.007; Fri, 5 Jan 2024 17:03:57 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "andrew@lunn.ch"
	<andrew@lunn.ch>, Ping-Ke Shih <pkshih@realtek.com>,
        Larry Chiu
	<larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v15 00/13] Add Realtek automotive PCIe driver
Thread-Topic: [PATCH net-next v15 00/13] Add Realtek automotive PCIe driver
Thread-Index: AQHaP7SM8GO6j+AK30Kd5CM5HjcV9rDK7Efg
Date: Fri, 5 Jan 2024 09:03:57 +0000
Message-ID: <bcf4a475cb8c4e57920521ac290d0077@realtek.com>
References: <20240105085236.376732-1-justinlai0215@realtek.com>
In-Reply-To: <20240105085236.376732-1-justinlai0215@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
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

> Subject: [PATCH net-next v15 00/13] Add Realtek automotive PCIe driver
>=20
> This series includes adding realtek automotive ethernet driver and adding
> rtase ethernet driver entry in MAINTAINERS file.
>=20
> This ethernet device driver for the PCIe interface of Realtek Automotive
> Ethernet Switch,applicable to RTL9054, RTL9068, RTL9072, RTL9075, RTL9068=
,
> RTL9071.
>=20
Sorry, this series of patches has not been sent completely, I will re-send =
it again.

