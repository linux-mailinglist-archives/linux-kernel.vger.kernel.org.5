Return-Path: <linux-kernel+bounces-13177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 522558200C0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 18:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D345D1F222DE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 17:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCBB12B84;
	Fri, 29 Dec 2023 17:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="gJbGmcgu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1388212B72;
	Fri, 29 Dec 2023 17:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1703870279; x=1704475079; i=wahrenst@gmx.net;
	bh=EB6S7+Rh5b+7EqTGMxgab2w+onEbSJoo5Vn0fmC6ifY=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=gJbGmcgu9goHb4BTzAr77EGkV/Xc4bHf6QdliFV+YhRsYFzVROJ2AxuaDFCqU6Ii
	 aCwg+6VTLjWtZIfKcdzbE7qdl7ZwgReEl7ZHq1vOCcxUjH8qFy7fZQhM93cGehcE1
	 3RPA3DGqkKM200HhR+aIlWtVoZZLeayyrHgalOotUjLZbVx/Johut0sT1jwAq+Btp
	 6jrscH2Z0woKSLoqrFAgydlh1AHg/OxDRuBvrljOOq05Cn+/Vvc3RIBkpU81df9/z
	 FNK87xu3drpSL3zbJcR+RiMEQaC+Rfn1g6k6SApHwiclq4LtPQr6wNIi5EvJfpYFo
	 m9KYnzv6qgGmJi/hFg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJE27-1rYJAq04wl-00Kl5N; Fri, 29
 Dec 2023 18:17:59 +0100
Message-ID: <ab993f3d-142c-4094-9320-772e1e3aad41@gmx.net>
Date: Fri, 29 Dec 2023 18:17:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] arm64: dts: imx93-var-som: Add Variscite
 VAR-SOM-MX93
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20231227170919.8771-1-othacehe@gnu.org>
 <20231227170919.8771-3-othacehe@gnu.org>
 <d378ad67-2a75-4a14-a131-7eb91de9ad3d@gmx.net> <87plypqi2d.fsf@gnu.org>
 <4e3a0328-0ae7-40fa-b37d-16b661e28a1e@gmx.net> <87zfxtosyy.fsf@gnu.org>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <87zfxtosyy.fsf@gnu.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hTMINXcXHvytF1vhaglgsPQlqUp3zCTSoR7xaA+wXt1Zf3NMbBQ
 4wy8YBn73t1+PCVCQVyVQSead/TCunmiJeVKiUhTDXIanget5euyGFl8ONJBR9O0yAtN1/+
 9nfPG4vCSkqxbgo6/d7c14/WMDZG/Dumt2tL5XtB8oGbE7x1O5K/siuVwLqpnTOpmFFGeTS
 JEiKgQ6ZHXF/x5xPk+6iw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NQIdbz97cZU=;EQ0dCoaZ0GyLvbLCDJMb/Iqn2EH
 RhsFD0DCopL8pOJJs/YWQdmFDkSgwgy6Vdy9qSMQY3zEyI/i2WZ16pzJD1mlh0JIvLAFt8QgY
 vGTX2cZFQvYe9DZp7S1rz1gOhdbBQlsIGQtVBi2h/SOMNnQOZxla1AodzIsY59Z95AASTrJnN
 9Pks2bLAQ69A84yY8EOzuYKMXSllyB2m3YqZoMzahk8lQyoC7EJcr+W3UroeDCnQPrxLuD0JR
 qUrDTKduG8UWZbPLgPfd0dtxGFIs0aAx5ppAW6PyVUKDBEmKfIyMcagkZBOB4Xjdk0DEirPeW
 /XN7z3OL57JPYOk5/PWVgY4v4gMzDAq0UBB4yY2xhKPhqkwRlQ/o3AZTYDQk0FX+qVacu/xx5
 OdoFgR/x/tpARg+YA8/ZHTreahf+5uj2K7NnrYz4AhWVKl23//L/m1gF7GjIgJhrTvNcFLCvK
 6yU7RIIkFH0ymaXuEh8ar5Gel8Hinx5zOTqSDigKTqoReHvYn9aTskBVWhItKvf33wt6AOjZL
 tB0ttUt8nz4NxvQnU3kq1QkuiZLwGkhOeA69Xz4vnEsnG2F7U/+iHTUsjthCh+2vhBE9SgL41
 2FKnh1iXgTp4MmsYqrhAuTfUGu7H3YDXhwaXb2iwYcxaKKQhplSpA2M2pQ0oQH+xSmZUCyLZe
 39mSB/xJN4kH7xYfutRk3UiGjqzY3q6ZqLRBA1eVmK0mOA+s+XOa4YS0bMagQkDMzasavVYvP
 wNkRToVFhMAuti7CLxP+SF76KY+s5bI4TnqHKLBzTyGa/2Y0ioIb5+CFbJ5y+LodofSeeXW3N
 1daTE7dtUyzxANoC6FYKLNfD0lgB2hM4KgL6uACndSzzaGd1QfLMP8ef6MqdXiCc235FTKAYM
 aAdmKILYNurb+W1sO8y3sGdunhaM5xSjqt/kNJMOe4nSDwhdJ3SlBz2Pp66DuGXdQCmrUDhAf
 NhJ5AGXiuJOL8Lb6UoM63qUz/oWG4pqAa9gbvNF4XPAO4Vg/

Hi,

Am 29.12.23 um 17:48 schrieb Mathieu Othacehe:
> Hey,
>
>> I also saw in the other Symphony DTS a LED for heartbeat. Is it usable,=
 too?
> Yes, I will add it to in v5.
>
>> According to the datasheet the SOM expose 7 UARTs, but only the debug
>> UART is enable. What is the reason for this?
> So those 7 UARTs are:
>
> UART1: console
> UART2: used by the microphone
> UART3: used by the resistive touch
> UART4: used by the ethernet/resistive touch
> UART5: on J18.4,6,8,10 (used by BT)
> UART6: on J18.7 and J18.9 (available)
> UART7: on J18.3 and J18.5 (used by the M33 firmware)
>
> I will enable UART6, and add a mention about UART7, something like:
>
> /* J18.7, J18.9 */
> &lpuart6 {
> 	pinctrl-names =3D "default";
> 	pinctrl-0 =3D <&pinctrl_uart6>;
> 	status =3D "okay";
> };
>
> /* J18.3, J18.5 - used by M33 firmware */
> &lpuart7 {
> 	pinctrl-names =3D "default";
> 	pinctrl-0 =3D <&pinctrl_uart7>;
> 	status =3D "disabled";
> };
in case this is used by the M33 firmware, this applies to all i.MX93 so
we don't need this. Just enable UART6 and keep UART7.
>> Btw the commit log mentions a Wifi (via SDIO?) and audio interface. Thi=
s
>> is currently not supported by Linux?
> I am not sure about that, and I would prefer to study that a bit later
> on if that's OK :) I can remove it from the commit log as this is
> misleading as not already supported / tested.
This sounds good. No need to have it all at first.
>
> Thanks,
>
> Mathieu
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


