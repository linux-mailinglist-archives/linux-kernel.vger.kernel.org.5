Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79930792B1A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239325AbjIEQsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353971AbjIEI7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:59:49 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D8D18D;
        Tue,  5 Sep 2023 01:59:45 -0700 (PDT)
Received: from pendragon.ideasonboard.com (ftip006315900.acc1.colindale.21cn-nte.bt.net [81.134.214.249])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EEA8A10FE;
        Tue,  5 Sep 2023 10:58:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693904298;
        bh=9zflABAqPmbg2ONt1yRMuQjAcZe9cEzAC/XOnQAauSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k5ztUP4cRawFTeRRyx/raq1/2zA3AKLiQ/KSeeVrNKtIuvBTVnV6/dvg5lCl1iPH/
         Vi8nYpm9xLX6wajtAKmROs6xJZ0G//aGtkjnbaYy9J3LZS5UAw+wl1FeOgLXtI0+KB
         +/9PlEbqUWnWKRS0fmcKzUQ9G6ydlav/RfsQe5K0=
Date:   Tue, 5 Sep 2023 11:59:56 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Alain Volmat <alain.volmat@foss.st.com>
Cc:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Dan Scally <dan.scally@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] media: MAINTAINERS: add entry for STM32 DCMIPP
 driver
Message-ID: <20230905085956.GB31594@pendragon.ideasonboard.com>
References: <20230901155732.252436-1-alain.volmat@foss.st.com>
 <20230901155732.252436-3-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230901155732.252436-3-alain.volmat@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain,

Thank you for the patch.

On Fri, Sep 01, 2023 at 05:57:21PM +0200, Alain Volmat wrote:
> Add the entry related to the STM32 MEDIA DCMIPP driver within the
> MAINTAINERS file.
> 
> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 228bed60e006..d2c6fd410dcf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13171,6 +13171,15 @@ T:	git git://linuxtv.org/media_tree.git
>  F:	Documentation/devicetree/bindings/media/st,stm32-dcmi.yaml
>  F:	drivers/media/platform/st/stm32/stm32-dcmi.c
>  
> +MEDIA DRIVERS FOR STM32 - DCMIPP
> +M:	Hugues Fruchet <hugues.fruchet@foss.st.com>
> +M:	Alain Volmat <alain.volmat@foss.st.com>

If you volunteered to also maintain the DCMI driver, this could be
folded in the "MEDIA DRIVERS FOR STM32 - DCMI" entry :-)

Either way,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +L:	linux-media@vger.kernel.org
> +S:	Supported
> +T:	git git://linuxtv.org/media_tree.git
> +F:	Documentation/devicetree/bindings/media/st,stm32-dcmipp.yaml
> +F:	drivers/media/platform/st/stm32/stm32-dcmipp/*
> +
>  MEDIA INPUT INFRASTRUCTURE (V4L/DVB)
>  M:	Mauro Carvalho Chehab <mchehab@kernel.org>
>  L:	linux-media@vger.kernel.org

-- 
Regards,

Laurent Pinchart
