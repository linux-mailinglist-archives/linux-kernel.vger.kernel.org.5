Return-Path: <linux-kernel+bounces-73455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CB985C2CE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A981F23678
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12FA779F0;
	Tue, 20 Feb 2024 17:38:00 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA3B78697
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 17:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708450678; cv=none; b=mdh6D2R0202rxT+j8woJmm9IpQytiZbo37R5dmrL2d1Z0ZBLUOThtcxnPp+LrH2HlsMRsgAIByOjjcQHqYvzScbz6Bbx0cm2Ke4zhoNV+Km1DjmsfE85LLHtiCtPSjMW3D3FfXO4efM5LU4lAMD6Pw3JThDWNH+rX/zgpG3QZ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708450678; c=relaxed/simple;
	bh=de9n0Cv+s4pee1ZqOlggG89EgBEekOgbO595UsG+NtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZbWcgoGdPUsBcHv8lVBJfCYCxxXNTMf3xqRf6m/cY5pwA5WFzmHMDGQmGZp+FREIlr0cPyYgtxn5pEr1P9/2wbcj5cvVteWDntLpi6EEWzHic3vJY7PdDOfapbQVovhwHIT9ASlhSejpFEEPajS17/Bqhfai+5JiS7u8BA4OCL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1rcU3l-0007x7-Ow; Tue, 20 Feb 2024 18:37:37 +0100
Message-ID: <05b7bf7f-9b5d-4ae3-a295-82f2b46abb4a@pengutronix.de>
Date: Tue, 20 Feb 2024 18:37:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Use a proper mailinglist for NXP i.MX
 development
Content-Language: en-US
To: "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>, shawnguo@kernel.org
Cc: aisheng.dong@nxp.com, peng.fan@nxp.com, f.fainelli@gmail.com,
 Daniel Baluta <daniel.baluta@nxp.com>, shengjiu.wang@nxp.com,
 Frank.Li@nxp.com, linux-kernel@vger.kernel.org, haibo.chen@nxp.com,
 mirela.rabulea@nxp.com, kernel@pengutronix.de, kuba@kernel.org,
 abel.vesa@linaro.org, laurentiu.palcu@nxp.com
References: <20240220164005.1345603-1-daniel.baluta@oss.nxp.com>
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20240220164005.1345603-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello Daniel,

On 20.02.24 17:40, Daniel Baluta (OSS) wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> So far we used an internal linux-imx@nxp.com email address to
> gather all patches related to NXP i.MX development.
> 
> Let's switch to an open mailing list that provides ability
> for people from the community to subscribe and also have
> a proper archive.
> 
> List interface at: https://lists.linux.dev.
> Archive is at: https://lore.kernel.org/imx/

I think the R: should be changed to L: then?

Thanks,
Ahmad

> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
> 
> Shawn, can you please pick this up via your tree?
> 
>  MAINTAINERS | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d1052fa6a69..3db382dc8f7b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2156,7 +2156,7 @@ M:	Shawn Guo <shawnguo@kernel.org>
>  M:	Sascha Hauer <s.hauer@pengutronix.de>
>  R:	Pengutronix Kernel Team <kernel@pengutronix.de>
>  R:	Fabio Estevam <festevam@gmail.com>
> -R:	NXP Linux Team <linux-imx@nxp.com>
> +R:	NXP Linux Team <imx@lists.linux.dev>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
> @@ -8489,7 +8489,7 @@ FREESCALE IMX / MXC FEC DRIVER
>  M:	Wei Fang <wei.fang@nxp.com>
>  R:	Shenwei Wang <shenwei.wang@nxp.com>
>  R:	Clark Wang <xiaoning.wang@nxp.com>
> -R:	NXP Linux Team <linux-imx@nxp.com>
> +R:	NXP Linux Team <imx@lists.linux.dev>
>  L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/net/fsl,fec.yaml
> @@ -8524,7 +8524,7 @@ F:	drivers/i2c/busses/i2c-imx.c
>  FREESCALE IMX LPI2C DRIVER
>  M:	Dong Aisheng <aisheng.dong@nxp.com>
>  L:	linux-i2c@vger.kernel.org
> -L:	linux-imx@nxp.com
> +L:	imx@lists.linux.dev
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.yaml
>  F:	drivers/i2c/busses/i2c-imx-lpi2c.c
> @@ -15704,7 +15704,7 @@ F:	drivers/iio/gyro/fxas21002c_spi.c
>  NXP i.MX 7D/6SX/6UL/93 AND VF610 ADC DRIVER
>  M:	Haibo Chen <haibo.chen@nxp.com>
>  L:	linux-iio@vger.kernel.org
> -L:	linux-imx@nxp.com
> +L:	imx@lists.linux.dev
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/adc/fsl,imx7d-adc.yaml
>  F:	Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml
> @@ -15741,7 +15741,7 @@ F:	drivers/gpu/drm/imx/dcss/
>  NXP i.MX 8QXP ADC DRIVER
>  M:	Cai Huoqing <cai.huoqing@linux.dev>
>  M:	Haibo Chen <haibo.chen@nxp.com>
> -L:	linux-imx@nxp.com
> +L:	imx@lists.linux.dev
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/adc/nxp,imx8qxp-adc.yaml
> @@ -15749,7 +15749,7 @@ F:	drivers/iio/adc/imx8qxp-adc.c
>  
>  NXP i.MX 8QXP/8QM JPEG V4L2 DRIVER
>  M:	Mirela Rabulea <mirela.rabulea@nxp.com>
> -R:	NXP Linux Team <linux-imx@nxp.com>
> +R:	NXP Linux Team <imx@lists.linux.dev>
>  L:	linux-media@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> @@ -15759,7 +15759,7 @@ NXP i.MX CLOCK DRIVERS
>  M:	Abel Vesa <abelvesa@kernel.org>
>  R:	Peng Fan <peng.fan@nxp.com>
>  L:	linux-clk@vger.kernel.org
> -L:	linux-imx@nxp.com
> +L:	imx@lists.linux.dev
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git clk/imx
>  F:	Documentation/devicetree/bindings/clock/imx*
> @@ -19630,7 +19630,7 @@ F:	drivers/mmc/host/sdhci-of-at91.c
>  
>  SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) NXP i.MX DRIVER
>  M:	Haibo Chen <haibo.chen@nxp.com>
> -L:	linux-imx@nxp.com
> +L:	imx@lists.linux.dev
>  L:	linux-mmc@vger.kernel.org
>  S:	Maintained
>  F:	drivers/mmc/host/sdhci-esdhc-imx.c

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


