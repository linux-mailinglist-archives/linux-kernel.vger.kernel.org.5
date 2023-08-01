Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C294C76BF92
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbjHAVyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjHAVyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:54:31 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365D32122;
        Tue,  1 Aug 2023 14:54:29 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 339228D;
        Tue,  1 Aug 2023 23:53:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1690926804;
        bh=zM/2eMhf5eioUukG/7WSadNDzeMn4OBtQlc27LCD7Po=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PtJjv5/0gD0e715LuTArMdDv0SOJOsNzf1Y9t8LN4ElEjR65V0vQZCpTU2uC1ZS0h
         FXKgokYU/PiYGzSBR9UbvKwrLxNq7a9ulZnP03WjE/WagW5VdLX5bRQ/JiMJhKZltR
         TAWggA5dU78pvhzoMC046sP0r/1o0oidmQ56q24U=
Date:   Wed, 2 Aug 2023 00:54:33 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Martin Kepplinger <martin.kepplinger@puri.sm>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Purism Kernel Team <kernel@puri.sm>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: correct file entry in MEDIA DRIVERS FOR
 FREESCALE IMX7/8
Message-ID: <20230801215433.GH8578@pendragon.ideasonboard.com>
References: <20230731131427.601-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230731131427.601-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

Thank you for the patch.

On Mon, Jul 31, 2023 at 03:14:27PM +0200, Lukas Bulwahn wrote:
> Commit cd063027c304 ("media: imx: Unstage the imx8mq-mipi-csi2 driver")
> adds a file entry for the driver code to MEDIA DRIVERS FOR FREESCALE
> IMX7/8, but misses the number '2' suffix in that entry. Hence,
> ./scripts/get_maintainer.pl --self-test=patterns complains about a broken
> reference.
> 
> Correct the file entry in MEDIA DRIVERS FOR FREESCALE IMX7/8.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 97db167eeaa7..5ba24f88a214 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13094,7 +13094,7 @@ F:	Documentation/devicetree/bindings/media/nxp,imx7-csi.yaml
>  F:	Documentation/devicetree/bindings/media/nxp,imx8mq-mipi-csi2.yaml
>  F:	drivers/media/platform/nxp/imx-mipi-csis.c
>  F:	drivers/media/platform/nxp/imx7-media-csi.c
> -F:	drivers/media/platform/nxp/imx8mq-mipi-csi.c
> +F:	drivers/media/platform/nxp/imx8mq-mipi-csi2.c
>  
>  MEDIA DRIVERS FOR HELENE
>  M:	Abylay Ospan <aospan@netup.ru>

-- 
Regards,

Laurent Pinchart
