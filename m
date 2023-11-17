Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23E57EED03
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 08:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjKQH6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 02:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjKQH6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 02:58:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1C3D50
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 23:58:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30ECDC433C8;
        Fri, 17 Nov 2023 07:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700207895;
        bh=0B36TljQhHtg1dBTuFEPa+Be8tJ2CYT0Ridvxuqjnuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oSG40eVfVNnxf2w6tvLsPOx9cMgntkfr9kiTiRJBk38Jko8P+ss8EBbcHJ8pDtQRx
         gn6s/7mXoXllIs4NtpGIaoptlJdOV5yT3o/5A9J96UX9Ebhd2W2dneO4AA7U9WSHu8
         UPxJGLDs2sNegRXvzTCnzEiN9HQodc51Re3m+CJGffobrkO3q9D+1AC8JxoaWW3IcQ
         OFor8yWrR5ddjtwYxcLuu1bTUurRQ/HupRZEESe0AW5/G7zc1k8JNZzZRlVTaKsb03
         wgVGn1QG81Mfs61ZUeeWvzXskTBhQpv+6j5gEL6v76A/X5bmOhOQ2cIpqvGMeRhy2n
         gHaWxmrzX0Vxw==
Date:   Fri, 17 Nov 2023 13:28:09 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Kory Maincent <kory.maincent@bootlin.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v5 3/6] dmaengine: dw-edma: Typo fix
Message-ID: <20231117075809.GC10361@thinkpad>
References: <20231114-b4-feature_hdma_mainline-v5-0-7bc86d83c6f7@bootlin.com>
 <20231114-b4-feature_hdma_mainline-v5-3-7bc86d83c6f7@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231114-b4-feature_hdma_mainline-v5-3-7bc86d83c6f7@bootlin.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 03:51:56PM +0100, Kory Maincent wrote:

Please mention what typo it is in the subject.

> Fix "HDMA_V0_REMOTEL_STOP_INT_EN" typo error
> 
> Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

With that,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> ---
> 
> Changes in v3:
> - Split the patch in two to differ bug fix and simple harmless typo.
> ---
>  drivers/dma/dw-edma/dw-hdma-v0-regs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> index a974abdf8aaf..eab5fd7177e5 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> @@ -15,7 +15,7 @@
>  #define HDMA_V0_LOCAL_ABORT_INT_EN		BIT(6)
>  #define HDMA_V0_REMOTE_ABORT_INT_EN		BIT(5)
>  #define HDMA_V0_LOCAL_STOP_INT_EN		BIT(4)
> -#define HDMA_V0_REMOTEL_STOP_INT_EN		BIT(3)
> +#define HDMA_V0_REMOTE_STOP_INT_EN		BIT(3)
>  #define HDMA_V0_ABORT_INT_MASK			BIT(2)
>  #define HDMA_V0_STOP_INT_MASK			BIT(0)
>  #define HDMA_V0_LINKLIST_EN			BIT(0)
> 
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
