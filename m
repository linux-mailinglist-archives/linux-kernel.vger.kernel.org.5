Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D090C75B69C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 20:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjGTSXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 14:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjGTSXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:23:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D1E270F;
        Thu, 20 Jul 2023 11:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=pYfHUr42de2eGRrEotSjFET8vjiU9POgVX/xfio4nAM=; b=X7BnhZFl+vKNI9gLCLRmZGYpDd
        Ly+NyxAFk2ThTQoJWOOHCP2Hpxznim+I8nb99rj1aqrBBW6p/Ao2OkPqNP65pTJAhb8Xvc3xk3FX1
        2Bj/H8hGCiAnfAkJvxgJ2Vy1n0VUwZVs8EEXGJMMgpGW1iIbFtvi3HXpUJnyA6vLXFyEQ2JrldEqt
        z758y82504L+sSokYPSjVynzeQnPDCNyOndZDE66F1pjUFUkkvJOePJwhu4HV5NBYcAnoX+0wsK2o
        Pc/mvdDrVC9W4/6fAt/4EM65GHdQ3W/8DXhls6epO7Kw8S2iNE2gqqyBCI4/T+5022CXleU5XPhPa
        oSlSoSEg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qMYJ2-00BtLQ-2C;
        Thu, 20 Jul 2023 18:23:16 +0000
Message-ID: <c79f3925-883e-1ad5-4964-b92080cdc2a7@infradead.org>
Date:   Thu, 20 Jul 2023 11:23:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next] MAINTAINERS: net: fix sort order
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     kernel@pengutronix.de,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Justin Chen <justin.chen@broadcom.com>
References: <20230720151107.679668-1-mkl@pengutronix.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230720151107.679668-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/23 08:11, Marc Kleine-Budde wrote:
> Linus seems to like the MAINTAINERS file sorted, see
> c192ac735768 ("MAINTAINERS 2: Electric Boogaloo").

Also, the file contains this note:
.. note:: When reading this list, please look for the most precise areas
          first. When adding to this list, please keep the entries in
          alphabetical order.


> 
> Since this is currently not the case, restore the sort order.
> 
> Cc: Florian Fainelli <florian.fainelli@broadcom.com>
> Cc: Justin Chen <justin.chen@broadcom.com>
> Fixes: 3abf3d15ffff ("MAINTAINERS: ASP 2.0 Ethernet driver maintainers")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  MAINTAINERS | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3b123afcfc9e..66a06ac9729e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3838,6 +3838,15 @@ S:	Maintained
>  F:	kernel/bpf/stackmap.c
>  F:	kernel/trace/bpf_trace.c
>  
> +BROADCOM ASP 2.0 ETHERNET DRIVER
> +M:	Justin Chen <justin.chen@broadcom.com>
> +M:	Florian Fainelli <florian.fainelli@broadcom.com>
> +L:	bcm-kernel-feedback-list@broadcom.com
> +L:	netdev@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml
> +F:	drivers/net/ethernet/broadcom/asp2/
> +
>  BROADCOM B44 10/100 ETHERNET DRIVER
>  M:	Michael Chan <michael.chan@broadcom.com>
>  L:	netdev@vger.kernel.org
> @@ -4148,15 +4157,6 @@ F:	drivers/net/mdio/mdio-bcm-unimac.c
>  F:	include/linux/platform_data/bcmgenet.h
>  F:	include/linux/platform_data/mdio-bcm-unimac.h
>  
> -BROADCOM ASP 2.0 ETHERNET DRIVER
> -M:	Justin Chen <justin.chen@broadcom.com>
> -M:	Florian Fainelli <florian.fainelli@broadcom.com>
> -L:	bcm-kernel-feedback-list@broadcom.com
> -L:	netdev@vger.kernel.org
> -S:	Supported
> -F:	Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml
> -F:	drivers/net/ethernet/broadcom/asp2/
> -
>  BROADCOM IPROC ARM ARCHITECTURE
>  M:	Ray Jui <rjui@broadcom.com>
>  M:	Scott Branden <sbranden@broadcom.com>

-- 
~Randy
