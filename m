Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BDA7B3ECC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 09:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbjI3HRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 03:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbjI3HRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 03:17:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC43DFA
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 00:17:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0EC0C433C7;
        Sat, 30 Sep 2023 07:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696058237;
        bh=t5bQqmO6K4w0bhM07PvJnMskmXp8eTWsvC4C2mzKVt8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QQw3LdEmzoHcNJbdZF5Wm2NXLLNAlaNbjRBcvDVm/6O621BIib+QLC3zRUg7A3xYL
         qYyuDE/VvmvITCnqIBT8VrCUIVHmugPaxa56PJLE9kkEV5zn1GbV0W/H+UN9yyD1Mm
         jEUbg+rmKk9TAk99jqYlSi8eCwpay7Sq8QIDjPhs=
Date:   Sat, 30 Sep 2023 09:17:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Cc:     michal.simek@amd.com, tanmay.shah@amd.com,
        sai.krishna.potthuri@amd.com, nava.kishore.manne@amd.com,
        ben.levinsky@amd.com, dhaval.r.shah@amd.com, marex@denx.de,
        robh@kernel.org, arnd@arndb.de, izhar.ameer.shaikh@amd.com,
        ruanjinjie@huawei.com, mathieu.poirier@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 7/7] drivers: soc: xilinx: update maintainer of event
 manager driver
Message-ID: <2023093043-overbill-unsolved-6da8@gregkh>
References: <20230929105558.11893-1-jay.buddhabhatti@amd.com>
 <20230929105558.11893-8-jay.buddhabhatti@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929105558.11893-8-jay.buddhabhatti@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 03:55:58AM -0700, Jay Buddhabhatti wrote:
> Added Michal as a maintainer of event manager driver as Abhyuday is no
> longer in AMD-Xilinx.
> 
> Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b19995690904..8da1ef5f80f7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23671,7 +23671,7 @@ F:	Documentation/devicetree/bindings/net/can/xilinx,can.yaml
>  F:	drivers/net/can/xilinx_can.c
>  
>  XILINX EVENT MANAGEMENT DRIVER
> -M:	Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
> +M:	Simek, Michal <michal.simek@amd.com>

Need an ack from Michal for obvious reasons, and can you put the name in
"first last" format without a ',' to make it easier for tools?

thanks,

greg k-h
