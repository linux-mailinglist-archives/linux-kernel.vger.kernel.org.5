Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0058A7BEB49
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378548AbjJIUJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378523AbjJIUJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:09:35 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4E2A6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 13:09:31 -0700 (PDT)
Received: from [194.95.143.137] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qpwZB-0004tb-3W; Mon, 09 Oct 2023 22:09:25 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc:     linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: rockchip-inno-usb2: Drop unnecessary DT includes
Date:   Mon, 09 Oct 2023 22:09:24 +0200
Message-ID: <2241455.iZASKD2KPV@phil>
In-Reply-To: <20231009172923.2457844-17-robh@kernel.org>
References: <20231009172923.2457844-17-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 9. Oktober 2023, 19:29:12 CEST schrieb Rob Herring:
> Neither of_address.h or of_platform.h are used in the driver, so drop them.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> index b982c3f0d4b5..a24d2af154df 100644
> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> @@ -17,9 +17,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/of.h>
> -#include <linux/of_address.h>
>  #include <linux/of_irq.h>
> -#include <linux/of_platform.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/power_supply.h>
> 




