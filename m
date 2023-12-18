Return-Path: <linux-kernel+bounces-2949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28628816518
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 03:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D87F1281AB6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 02:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA9D7483;
	Mon, 18 Dec 2023 02:51:22 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10F36FCB;
	Mon, 18 Dec 2023 02:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BI2opalF3102410, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BI2opalF3102410
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 10:50:51 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 18 Dec 2023 10:50:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 18 Dec 2023 10:50:50 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Mon, 18 Dec 2023 10:50:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zenm Chen <zenmchen@gmail.com>,
        "Jes.Sorensen@gmail.com"
	<Jes.Sorensen@gmail.com>
CC: "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com"
	<rtl8821cerfe2@gmail.com>,
        "Larry.Finger@lwfinger.net"
	<Larry.Finger@lwfinger.net>
Subject: RE: [PATCH v3] wifi: rtl8xxxu: Add additional USB IDs for RTL8192EU devices
Thread-Topic: [PATCH v3] wifi: rtl8xxxu: Add additional USB IDs for RTL8192EU
 devices
Thread-Index: AQHaMOTRtIFu/98Os0G2P5EnNLaRJ7CuV8rQ
Date: Mon, 18 Dec 2023 02:50:50 +0000
Message-ID: <28fdf59235e34c089482dd9cbab55446@realtek.com>
References: <20231217123017.1982-1-zenmchen@gmail.com>
In-Reply-To: <20231217123017.1982-1-zenmchen@gmail.com>
Accept-Language: en-US, zh-TW
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback



> -----Original Message-----
> From: Zenm Chen <zenmchen@gmail.com>
> Sent: Sunday, December 17, 2023 8:30 PM
> To: Jes.Sorensen@gmail.com
> Cc: kvalo@kernel.org; linux-wireless@vger.kernel.org; linux-kernel@vger.k=
ernel.org; Ping-Ke Shih
> <pkshih@realtek.com>; rtl8821cerfe2@gmail.com; Larry.Finger@lwfinger.net;=
 Zenm Chen <zenmchen@gmail.com>
> Subject: [PATCH v3] wifi: rtl8xxxu: Add additional USB IDs for RTL8192EU =
devices
>=20
> Add additional USB IDs found in the vendor driver from
> https://github.com/Mange/rtl8192eu-linux-driver to support more
> RTL8192EU devices.
>=20
> Signed-off-by: Zenm Chen <zenmchen@gmail.com>

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>



