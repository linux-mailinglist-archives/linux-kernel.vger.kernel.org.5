Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6AF75CBB3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjGUP2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjGUP2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:28:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231E42D47;
        Fri, 21 Jul 2023 08:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689953294; x=1721489294;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4f6+Vzh66/SZb4sK5BzeuecVvdpYV9VeScnvgZ2AiH4=;
  b=Nrz7dXM0a1/FOOAHxbWw3lh7X/Bl4sKF5t1s2I9tBL4wGPfVfBvSjeRN
   r5RxYa7C+KOeQfTt/CNfDh6LaJW0J1XmE8FzJk/hnKPoyLaRp6dkfneTB
   rrz/yCp0QWz1soMT+0LK8rtr7K/D9LNJvOXE0UC+OM0slBovhgleMx4W2
   1bYuRlM6Zi4nz7HMLdsQCjIDml63KHhEhlw4xOBiQa2SkInIMeEAJRrIt
   uo3Nooh0tN4BWuPlh6ekDAyFnAX3rI9fRzGLrHyGKtYoQZBNRkWXAOsBG
   m9GIn+JdBQl68m1ndviN0YazcA9hiFx0ibXVI9i09CmgZWrzqmF0EMxZ0
   A==;
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="221536705"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jul 2023 08:28:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 21 Jul 2023 08:27:48 -0700
Received: from [10.159.245.205] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Fri, 21 Jul 2023 08:27:46 -0700
Message-ID: <b00da337-e183-5af0-b240-ec2d62e433f0@microchip.com>
Date:   Fri, 21 Jul 2023 17:27:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ARM: dts: at91: remove duplicated entries
Content-Language: en-US, fr-FR
To:     Claudiu Beznea <claudiu.beznea@tuxon.dev>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <alexandre.belloni@bootlin.com>, <cristian.birsan@microchip.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230721053918.33944-1-claudiu.beznea@tuxon.dev>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20230721053918.33944-1-claudiu.beznea@tuxon.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2023 at 07:39, Claudiu Beznea wrote:
> [You don't often get email from claudiu.beznea@tuxon.dev. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> Remove duplicated DTC_FLAGS_<board> := -@ entries which intends to enable
> the building of device tree overlays.
> Commit 724ba6751532 ("ARM: dts: Move .dts files to vendor sub-directories")
> added those entries at the beginning of file w/o removing the already
> available entries spread though file.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks Claudiu for this finding, best regards,
    Nicolas

> ---
>   arch/arm/boot/dts/microchip/Makefile | 15 +--------------
>   1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/microchip/Makefile b/arch/arm/boot/dts/microchip/Makefile
> index 0f5193d05a31..31e03747cdf4 100644
> --- a/arch/arm/boot/dts/microchip/Makefile
> +++ b/arch/arm/boot/dts/microchip/Makefile
> @@ -1,4 +1,5 @@
>   # SPDX-License-Identifier: GPL-2.0
> +# Enables support for device-tree overlays
>   DTC_FLAGS_at91-sam9x60_curiosity := -@
>   DTC_FLAGS_at91-sam9x60ek := -@
>   DTC_FLAGS_at91-sama5d27_som1_ek := -@
> @@ -54,21 +55,9 @@ dtb-$(CONFIG_SOC_AT91SAM9) += \
>          at91sam9g35ek.dtb \
>          at91sam9x25ek.dtb \
>          at91sam9x35ek.dtb
> -# Enables support for device-tree overlays
> -DTC_FLAGS_at91-sam9x60_curiosity := -@
> -DTC_FLAGS_at91-sam9x60ek := -@
>   dtb-$(CONFIG_SOC_SAM9X60) += \
>          at91-sam9x60_curiosity.dtb \
>          at91-sam9x60ek.dtb
> -# Enables support for device-tree overlays
> -DTC_FLAGS_at91-sama5d27_som1_ek := -@
> -DTC_FLAGS_at91-sama5d27_wlsom1_ek := -@
> -DTC_FLAGS_at91-sama5d2_icp := -@
> -DTC_FLAGS_at91-sama5d2_ptc_ek := -@
> -DTC_FLAGS_at91-sama5d2_xplained := -@
> -DTC_FLAGS_at91-sama5d3_eds := -@
> -DTC_FLAGS_at91-sama5d3_xplained := -@
> -DTC_FLAGS_at91-sama5d4_xplained := -@
>   dtb-$(CONFIG_SOC_SAM_V7) += \
>          at91-kizbox2-2.dtb \
>          at91-kizbox3-hs.dtb \
> @@ -95,8 +84,6 @@ dtb-$(CONFIG_SOC_SAM_V7) += \
>          at91-sama5d4_xplained.dtb \
>          at91-sama5d4ek.dtb \
>          at91-vinco.dtb
> -# Enables support for device-tree overlays
> -DTC_FLAGS_at91-sama7g5ek := -@
>   dtb-$(CONFIG_SOC_SAMA7G5) += \
>          at91-sama7g5ek.dtb
> 
> --
> 2.39.2
> 

