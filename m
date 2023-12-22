Return-Path: <linux-kernel+bounces-9932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9A381CD70
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B144E1F22A9E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6616425763;
	Fri, 22 Dec 2023 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="hMDkNbAo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415B82554E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1703264536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=px3/C2GAp78mWv3p8bN07M1WSx6501Th3bqcTa2ov/U=;
	b=hMDkNbAovGIvQXqMv9oaj7Q5hNQDVlxWc60o9k1oRnAISXnsGbddJaVrt1ZFF3BWojKP0L
	oP/Y05IxzcYG8Hn0HqT+hcDNx3EUNt52DH1dfnZnWQFiV6MIgpceY2GWeQKgWR5nCAUIDQ
	DLCiy18i12XBzdvl5f+dsE1pDVKJRhXF56EwoT4Wj+9eSmDgqN5bV4HuTgVZFWChSV/J1T
	5rwKqRBiA6oQZG8yg2GbSnwMl0SYwb8s76KlpZRssfnP/OrmMGAgB2L75cGKp7xUrhtw/L
	+wI3rNCNotFvEwOhQZuHF5ECOx/4IycDLXd+gaxRoZxxa1gGp6hE4BfkVNlqyg==
From: Diederik de Haas <didi.debian@cknow.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Sandy Huang <hjc@rock-chips.com>, Mark Yao <markyao0591@gmail.com>,
 Segfault <awarnecke002@hotmail.com>, Arnaud Ferraris <aferraris@debian.org>,
 Manuel Traut <manut@mecka.net>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, Manuel Traut <manut@mecka.net>
Subject:
 Re: [PATCH 4/6] arm64: dts: rockchip: Add devicetree for Pine64 Pinetab2
Date: Fri, 22 Dec 2023 18:01:54 +0100
Message-ID: <2121710.IWpXjAX0fk@bagend>
Organization: Connecting Knowledge
In-Reply-To: <20231222-pinetab2-v1-4-e148a7f61bd1@mecka.net>
References:
 <20231222-pinetab2-v1-0-e148a7f61bd1@mecka.net>
 <20231222-pinetab2-v1-4-e148a7f61bd1@mecka.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1748370.CxT9PIvavd";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT

--nextPart1748370.CxT9PIvavd
Content-Type: multipart/mixed; boundary="nextPart3145776.fJ4KNo4xjy";
 protected-headers="v1"
Content-Transfer-Encoding: 7Bit
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Diederik de Haas <didi.debian@cknow.org>
Date: Fri, 22 Dec 2023 18:01:54 +0100
Message-ID: <2121710.IWpXjAX0fk@bagend>
Organization: Connecting Knowledge
In-Reply-To: <20231222-pinetab2-v1-4-e148a7f61bd1@mecka.net>
MIME-Version: 1.0

This is a multi-part message in MIME format.

--nextPart3145776.fJ4KNo4xjy
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, 22 December 2023 12:05:44 CET Manuel Traut wrote:
> +
> +&cru {
> +       assigned-clocks = <&cru PLL_GPLL>, <&pmucru PLL_PPLL>, <&cru
> PLL_VPLL>; +       assigned-clock-rates = <1200000000>, <200000000>,
> <500000000>; +};

Attachment seem to work and for this I also have the attached patch in my 
patch set.
IIRC without it you get an error in dmesg immediately at boot up which is 
visible on the PT2 *if* you have immediate visual output (which is not (yet?) 
the case in my image/kernel).

Cheers,
  Diederik
--nextPart3145776.fJ4KNo4xjy
Content-Disposition: attachment;
 filename="0006-arm64-dts-rk3566-pinetab2-Fix-cru-assigned-clocks.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="x-UTF_8J";
 name="0006-arm64-dts-rk3566-pinetab2-Fix-cru-assigned-clocks.patch"

From d782a64f3b51ffb2f33d3ba3e11e2ebc416542e3 Mon Sep 17 00:00:00 2001
From: Jonas Karlman <jonas@kwiboo.se>
Date: Thu, 17 Aug 2023 17:52:47 +0200
Subject: [PATCH 6/8] arm64: dts: rk3566-pinetab2: Fix cru assigned clocks

Jonas Karlman provided/linked to the patch on IRC.
Seems related to upstream commit 64b69474edf3b885c19a89bb165f978ba1b4be00.

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
Link: https://github.com/Kwiboo/u-boot-rockchip/blob/rk3568-2023.10/arch/arm/dts/rk3566-pinetab2-u-boot.dtsi#L11-L15
Link: https://lore.kernel.org/all/20230110225547.1563119-2-jonas@kwiboo.se/
---
 arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi
index bbd7ed53602a..4a5bee5a28a7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi
@@ -288,8 +288,9 @@ &cpu3 {
 };
 
 &cru {
-	assigned-clocks = <&cru PLL_GPLL>, <&pmucru PLL_PPLL>, <&cru PLL_VPLL>;
-	assigned-clock-rates = <1200000000>, <200000000>, <500000000>;
+	assigned-clocks = <&pmucru CLK_RTC_32K>, <&cru PLL_GPLL>, <&pmucru PLL_PPLL>, <&cru PLL_VPLL>;
+	assigned-clock-rates = <32768>, <1200000000>, <200000000>, <500000000>;
+	assigned-clock-parents = <&pmucru CLK_RTC32K_FRAC>;
 };
 
 &csi_dphy {
-- 
2.42.0


--nextPart3145776.fJ4KNo4xjy--

--nextPart1748370.CxT9PIvavd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZYXBAgAKCRDXblvOeH7b
bhcpAQCGga/E5eb2w/0+X/AHwmyoGxkSCdFMHH5O+JASROW0NAD/cer+0/CX3l23
ubyIofrQa3gkr+ini5cyFgQy37IsKAY=
=fTG/
-----END PGP SIGNATURE-----

--nextPart1748370.CxT9PIvavd--




