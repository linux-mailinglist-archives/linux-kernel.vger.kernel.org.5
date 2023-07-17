Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C8A7564FC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjGQN3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjGQN1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:27:49 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EA719AD
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689600429; x=1721136429;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7t6LlG9t4b5pXzU994Z3Da7YoidoG6CVQwl/5jcdR6U=;
  b=ienGRLMoO4qDv4ckBSTewNO4hjCmZ2E+lSxHouSX275IV7+3hMqOf/ON
   klc4iXXxSog2+7vGMd6/zn64U7r55v3CAsbXlAdYCT9YH/2xW3eL3yLH2
   yPTdPfEIXn3ZYAE029r0Dw1+Y0feFa1NPEqeE1yIbIDKlqzccz5344peJ
   TjVZc4I1yIlM1TAZTZVELPOaQcDr/jbHvbs6E23F3s0sx9EIYwXLsSS9A
   6Q2R5lSirvtu8CsR8skuP4tC8ewQQMJAxysqRzwVMpUEn1sYjShXvyiYz
   OUeekDY/cSHwsQPz8bqF8I0b8J4h8W/b0JvTWYfUVQpIwHYuPNLu2NH0c
   w==;
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="224225635"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jul 2023 06:26:47 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 17 Jul 2023 06:26:46 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Mon, 17 Jul 2023 06:26:45 -0700
Message-ID: <66876484-e287-4d48-41e6-f1bb318a879d@microchip.com>
Date:   Mon, 17 Jul 2023 15:26:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] MAINTAINERS: update Claudiu Beznea's email address
Content-Language: en-US
To:     Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        <linux-kernel@vger.kernel.org>
CC:     <arnd@arndb.de>, <alexandre.belloni@bootlin.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20230714183852.8370-1-claudiu.beznea@tuxon.dev>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20230714183852.8370-1-claudiu.beznea@tuxon.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2023 at 20:38, Claudiu Beznea wrote:
> Update MAINTAINERS entries with a valid email address as the Microchip
> one is no longer valid.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Thanks Claudiu, best regards,
   Nicolas

> ---
>   MAINTAINERS | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3be1bdfe8ecc..0be71ca1cbb2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2337,7 +2337,7 @@ F:        drivers/phy/mediatek/
>   ARM/MICROCHIP (ARM64) SoC support
>   M:     Conor Dooley <conor@kernel.org>
>   M:     Nicolas Ferre <nicolas.ferre@microchip.com>
> -M:     Claudiu Beznea <claudiu.beznea@microchip.com>
> +M:     Claudiu Beznea <claudiu.beznea@tuxon.dev>
>   L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:     Supported
>   T:     git https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git
> @@ -2346,7 +2346,7 @@ F:        arch/arm64/boot/dts/microchip/
>   ARM/Microchip (AT91) SoC support
>   M:     Nicolas Ferre <nicolas.ferre@microchip.com>
>   M:     Alexandre Belloni <alexandre.belloni@bootlin.com>
> -M:     Claudiu Beznea <claudiu.beznea@microchip.com>
> +M:     Claudiu Beznea <claudiu.beznea@tuxon.dev>
>   L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:     Supported
>   W:     http://www.linux4sam.org
> @@ -3248,7 +3248,7 @@ F:        include/uapi/linux/atm*
> 
>   ATMEL MACB ETHERNET DRIVER
>   M:     Nicolas Ferre <nicolas.ferre@microchip.com>
> -M:     Claudiu Beznea <claudiu.beznea@microchip.com>
> +M:     Claudiu Beznea <claudiu.beznea@tuxon.dev>
>   S:     Supported
>   F:     drivers/net/ethernet/cadence/
> 
> @@ -13778,7 +13778,7 @@ F:      Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
>   F:     drivers/spi/spi-at91-usart.c
> 
>   MICROCHIP AUDIO ASOC DRIVERS
> -M:     Claudiu Beznea <claudiu.beznea@microchip.com>
> +M:     Claudiu Beznea <claudiu.beznea@tuxon.dev>
>   L:     alsa-devel@alsa-project.org (moderated for non-subscribers)
>   S:     Supported
>   F:     Documentation/devicetree/bindings/sound/atmel*
> @@ -13801,7 +13801,7 @@ S:      Maintained
>   F:     drivers/crypto/atmel-ecc.*
> 
>   MICROCHIP EIC DRIVER
> -M:     Claudiu Beznea <claudiu.beznea@microchip.com>
> +M:     Claudiu Beznea <claudiu.beznea@tuxon.dev>
>   L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:     Supported
>   F:     Documentation/devicetree/bindings/interrupt-controller/microchip,sama7g5-eic.yaml
> @@ -13874,7 +13874,7 @@ F:      drivers/video/fbdev/atmel_lcdfb.c
>   F:     include/video/atmel_lcdc.h
> 
>   MICROCHIP MCP16502 PMIC DRIVER
> -M:     Claudiu Beznea <claudiu.beznea@microchip.com>
> +M:     Claudiu Beznea <claudiu.beznea@tuxon.dev>
>   L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:     Supported
>   F:     Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
> @@ -13901,7 +13901,7 @@ F:      Documentation/devicetree/bindings/mtd/atmel-nand.txt
>   F:     drivers/mtd/nand/raw/atmel/*
> 
>   MICROCHIP OTPC DRIVER
> -M:     Claudiu Beznea <claudiu.beznea@microchip.com>
> +M:     Claudiu Beznea <claudiu.beznea@tuxon.dev>
>   L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:     Supported
>   F:     Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
> @@ -13940,7 +13940,7 @@ F:      Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
>   F:     drivers/fpga/microchip-spi.c
> 
>   MICROCHIP PWM DRIVER
> -M:     Claudiu Beznea <claudiu.beznea@microchip.com>
> +M:     Claudiu Beznea <claudiu.beznea@tuxon.dev>
>   L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   L:     linux-pwm@vger.kernel.org
>   S:     Supported
> @@ -13956,7 +13956,7 @@ F:      drivers/iio/adc/at91-sama5d2_adc.c
>   F:     include/dt-bindings/iio/adc/at91-sama5d2_adc.h
> 
>   MICROCHIP SAMA5D2-COMPATIBLE SHUTDOWN CONTROLLER
> -M:     Claudiu Beznea <claudiu.beznea@microchip.com>
> +M:     Claudiu Beznea <claudiu.beznea@tuxon.dev>
>   S:     Supported
>   F:     Documentation/devicetree/bindings/power/reset/atmel,sama5d2-shdwc.yaml
>   F:     drivers/power/reset/at91-sama5d2_shdwc.c
> @@ -13973,7 +13973,7 @@ S:      Supported
>   F:     drivers/spi/spi-atmel.*
> 
>   MICROCHIP SSC DRIVER
> -M:     Claudiu Beznea <claudiu.beznea@microchip.com>
> +M:     Claudiu Beznea <claudiu.beznea@tuxon.dev>
>   L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:     Supported
>   F:     Documentation/devicetree/bindings/misc/atmel-ssc.txt
> @@ -14002,7 +14002,7 @@ F:      drivers/usb/gadget/udc/atmel_usba_udc.*
> 
>   MICROCHIP WILC1000 WIFI DRIVER
>   M:     Ajay Singh <ajay.kathat@microchip.com>
> -M:     Claudiu Beznea <claudiu.beznea@microchip.com>
> +M:     Claudiu Beznea <claudiu.beznea@tuxon.dev>
>   L:     linux-wireless@vger.kernel.org
>   S:     Supported
>   F:     drivers/net/wireless/microchip/wilc1000/
> --
> 2.39.2
> 

-- 
Nicolas Ferre

