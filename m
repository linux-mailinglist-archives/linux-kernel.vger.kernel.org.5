Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A03A7B7EE1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242255AbjJDMRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbjJDMRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:17:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF7193
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 05:17:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62945C433C9;
        Wed,  4 Oct 2023 12:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696421825;
        bh=9Dpod59BT8p13ZQMPca5WQwAYpcJyXY6jxGxRDshVqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f6AhofbpV/2HkfuPRMun/O04QevwBhKK6LNom2uuIQ5GgoEcJyV0ZLcxoHoCFjJUA
         +uy9txGlqvfq8NXICin6Py9arsYS5hXs1NJBN3fDV6paQmNTbYnwvOvybNgQEfQINx
         vZVnYeE+9YdyLcULTyJOEig3gToTxj52mN5AeEaE=
Date:   Wed, 4 Oct 2023 14:17:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Cc:     michal.simek@amd.com, tanmay.shah@amd.com,
        nava.kishore.manne@amd.com, ben.levinsky@amd.com, robh@kernel.org,
        dhaval.r.shah@amd.com, marex@denx.de, izhar.ameer.shaikh@amd.com,
        arnd@arndb.de, ruanjinjie@huawei.com, mathieu.poirier@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 6/6] drivers: soc: xilinx: update maintainer of event
 manager driver
Message-ID: <2023100446-jokester-uncrushed-c9b2@gregkh>
References: <20231004094116.27128-1-jay.buddhabhatti@amd.com>
 <20231004094116.27128-7-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004094116.27128-7-jay.buddhabhatti@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 02:41:16AM -0700, Jay Buddhabhatti wrote:
> Added Michal as a maintainer of event manager driver as Abhyuday is no
> longer in AMD-Xilinx.
> 
> Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
> Acked-by: Michal Simek <michal.simek@amd.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 35977b269d5e..f36fefd7032b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23672,7 +23672,7 @@ F:	Documentation/devicetree/bindings/net/can/xilinx,can.yaml
>  F:	drivers/net/can/xilinx_can.c
>  
>  XILINX EVENT MANAGEMENT DRIVER
> -M:	Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
> +M:	Michal Simek <michal.simek@amd.com>

For obvious reasons, we need an ack from Abhyuday.

thanks,

greg k-h
