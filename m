Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C0B7D1FDB
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 23:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjJUVji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 17:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJUVjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 17:39:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEAF9C
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 14:39:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F80EC433C7;
        Sat, 21 Oct 2023 21:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697924372;
        bh=OesIK1vv18YxMVOSsbR7a6z1lzp5vKkXkAr5iUOU4gQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XN/Cr27wTTA0dfxotwyX0jawH2jDB3Yf2mW29gITgTplMuylccMy0+DCUbc63rbv+
         IKtOWpA7DuZCPm21gBcczxwLCHkEMrfik6dzTikXnCtsNx8H5yRgl7FlWdFZsxxsGZ
         3UvysTqlBhiHNlZFSxr5+4+GAEgH24nshvI6SlUo=
Date:   Sat, 21 Oct 2023 23:39:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gary Rookard <garyrookard@fastmail.org>
Cc:     philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8192e: renamed variable TxCountToDataRate
Message-ID: <2023102107-tipping-dosage-5062@gregkh>
References: <20231021213202.6244-1-garyrookard@fastmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231021213202.6244-1-garyrookard@fastmail.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 05:32:02PM -0400, Gary Rookard wrote:
> Renamed from Pascal/CamelCase to Snake case the variable
> TxCountDataRate, TxCountDataRate -> tx_count_data_rate.
> 
> Linux kernel coding style (cleanup), checkpatch Avoid CamelCase.
> Driver rtl8192e compiles.
> 
> Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
> ---
>  drivers/staging/rtl8192e/rtl819x_HTProc.c    | 2 +-
>  drivers/staging/rtl8192e/rtllib.h            | 2 +-
>  drivers/staging/rtl8192e/rtllib_softmac_wx.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
