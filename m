Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FB67B8142
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbjJDNr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 09:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbjJDNrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:47:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFCF9B
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 06:47:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC83C433C8;
        Wed,  4 Oct 2023 13:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696427241;
        bh=SD4ukA8U4BcItsoLHDjfVCGr3JpZsGskyxW3V603QGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y2Gofct/SAIjPHDNuppI2xU7F5IYlHIrNT/SQzuV6gc2r6bzBlWgSQcxuc650FRBc
         3thaldH2op29lJivht+Ljg6u0V6XyL3fAiQnw9g/LQZnXpKH387wAEe5oR90drXs91
         xv6FT39M/X7CbfPC2btPMdnIHsxx2efptlX3pL3o=
Date:   Wed, 4 Oct 2023 15:47:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michal Simek <michal.simek@amd.com>
Cc:     Jay Buddhabhatti <jay.buddhabhatti@amd.com>, tanmay.shah@amd.com,
        nava.kishore.manne@amd.com, ben.levinsky@amd.com, robh@kernel.org,
        dhaval.r.shah@amd.com, marex@denx.de, izhar.ameer.shaikh@amd.com,
        arnd@arndb.de, ruanjinjie@huawei.com, mathieu.poirier@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 6/6] drivers: soc: xilinx: update maintainer of event
 manager driver
Message-ID: <2023100444-dose-laziness-d488@gregkh>
References: <20231004094116.27128-1-jay.buddhabhatti@amd.com>
 <20231004094116.27128-7-jay.buddhabhatti@amd.com>
 <2023100446-jokester-uncrushed-c9b2@gregkh>
 <48bc9520-fd5f-43fc-9adf-2a9e0493109a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48bc9520-fd5f-43fc-9adf-2a9e0493109a@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 03:16:15PM +0200, Michal Simek wrote:
> 
> 
> On 10/4/23 14:17, Greg KH wrote:
> > On Wed, Oct 04, 2023 at 02:41:16AM -0700, Jay Buddhabhatti wrote:
> > > Added Michal as a maintainer of event manager driver as Abhyuday is no
> > > longer in AMD-Xilinx.
> > > 
> > > Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
> > > Acked-by: Michal Simek <michal.simek@amd.com>
> > > ---
> > >   MAINTAINERS | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 35977b269d5e..f36fefd7032b 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -23672,7 +23672,7 @@ F:	Documentation/devicetree/bindings/net/can/xilinx,can.yaml
> > >   F:	drivers/net/can/xilinx_can.c
> > >   XILINX EVENT MANAGEMENT DRIVER
> > > -M:	Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
> > > +M:	Michal Simek <michal.simek@amd.com>
> > 
> > For obvious reasons, we need an ack from Abhyuday.
> 
> He no longer works for Xilinx/AMD but I have asked him on side channel to
> reply and let's see if this is going to happen or not.

Mantainerships follow people, not companies, so if he wants to keep
being the maintainer, he can be, there's no requirement for him to step
down.

thanks,

greg k-h
