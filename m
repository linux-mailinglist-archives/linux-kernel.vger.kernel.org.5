Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194017F4FD6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343732AbjKVSpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjKVSpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:45:14 -0500
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F56A92;
        Wed, 22 Nov 2023 10:45:09 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 97D56120059;
        Wed, 22 Nov 2023 21:45:07 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 97D56120059
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1700678707;
        bh=ouwssWigHzD9ZWYCMHXO2ZFvdiQcVgz6nUBBI0g8ycU=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=GbuXmbSao/6h56W/EQ+mMC6rblliv5TV0Tr/Pi0M8VEDZx//QJsnQummWUKXRR94W
         R5oyDN92V2s6ZVZv9k/CJ86lKC++MKqen0+7YuT16DZGsY3rkdgm+6dH4lpVHoW2bi
         8uiG3jXzssmhFDFKfCbqZqx1dr4Ph0DHzdCmq+bL7dtPIm+OUcumHUwEwdnWroT1jC
         HHvvjImhtCjcvl9+5N9B6if/143dsA24gMKT1GbKas7lrCjbhYViAial87dvR44rrp
         QisOWdjMRrTEMCle12jV4GFhBcOrQ06b1eCaV/J9i8VTA0DOKq9El9M79Q6wiM1Q6G
         9FaazNaIFqA2g==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed, 22 Nov 2023 21:45:07 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 22 Nov
 2023 21:45:07 +0300
Date:   Wed, 22 Nov 2023 21:45:02 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     Viacheslav Bocharov <adeep@lexina.in>
CC:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [DMARC error][DKIM error] [PATCH 5/5] arm64: dts: meson: add dts
 links to secure-monitor for soc driver in a1, axg, gx, g12
Message-ID: <20231122184502.x4rxzvgmoaxbmhlr@CAB-WSD-L081021>
References: <20231122125643.1717160-1-adeep@lexina.in>
 <20231122125643.1717160-6-adeep@lexina.in>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231122125643.1717160-6-adeep@lexina.in>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181545 [Nov 22 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 3 0.3.3 e5c6a18a9a9bff0226d530c5b790210c0bd117c8, {Tracking_uf_ne_domains}, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;lists.infradead.org:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/11/22 18:12:00
X-KSMG-LinksScanning: Clean, bases: 2023/11/22 18:12:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/22 11:24:00 #22501433
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Viacheslav,

On Wed, Nov 22, 2023 at 03:56:43PM +0300, Viacheslav Bocharov wrote:
> Add links to secure-monitor in soc driver section for A1, AXG, GX, G12
> Amlogic family.
> 
> Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
> ---
>  arch/arm64/boot/dts/amlogic/meson-a1.dtsi         | 1 +
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi        | 1 +
>  arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 1 +
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi         | 1 +
>  4 files changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> index 648e7f49424f..449b328d62b1 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> @@ -407,6 +407,7 @@ hwrng: rng@5118 {
>  			sec_AO: ao-secure@5a20 {
>  				compatible = "amlogic,meson-gx-ao-secure", "syscon";
>  				reg = <0x0 0x5a20 0x0 0x140>;
> +				secure-monitor = <&sm>;

I suppose it's better and more consistent to use the same hierarchy
pattern as Secure PWRC uses: to be a child of Secure Monitor.

Please see the example below from meson-a1.dtsi:


	sm: secure-monitor {
		compatible = "amlogic,meson-gxbb-sm";

		pwrc: power-controller {
			compatible = "amlogic,meson-a1-pwrc";
			#power-domain-cells = <1>;
		};
	};

>  				amlogic,has-chip-id;
>  			};
>  
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index a49aa62e3f9f..6e80bdc525e5 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -1660,6 +1660,7 @@ mux {
>  			sec_AO: ao-secure@140 {
>  				compatible = "amlogic,meson-gx-ao-secure", "syscon";
>  				reg = <0x0 0x140 0x0 0x140>;
> +				secure-monitor = <&sm>;
>  				amlogic,has-chip-id;
>  			};
>  
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> index ff68b911b729..0a6b703b0dc0 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> @@ -2026,6 +2026,7 @@ cec_AO: cec@100 {
>  			sec_AO: ao-secure@140 {
>  				compatible = "amlogic,meson-gx-ao-secure", "syscon";
>  				reg = <0x0 0x140 0x0 0x140>;
> +				secure-monitor = <&sm>;
>  				amlogic,has-chip-id;
>  			};
>  
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> index 2673f0dbafe7..656e08b3d872 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> @@ -471,6 +471,7 @@ cec_AO: cec@100 {
>  			sec_AO: ao-secure@140 {
>  				compatible = "amlogic,meson-gx-ao-secure", "syscon";
>  				reg = <0x0 0x140 0x0 0x140>;
> +				secure-monitor = <&sm>;
>  				amlogic,has-chip-id;
>  			};
>  
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

-- 
Thank you,
Dmitry
