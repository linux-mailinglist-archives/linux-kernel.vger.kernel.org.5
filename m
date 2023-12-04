Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843C38042DD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 00:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343587AbjLDXvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 18:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234906AbjLDXvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 18:51:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE5D1BD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 15:50:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C79C433C7;
        Mon,  4 Dec 2023 23:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701733832;
        bh=Mqpn8JWJrEHA3nf1/O0t1Wus8ha9IwThhk7diqcvIZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ed+e3vUgnGtB/R3YbKxwey3JkazEu6+dhewuLboQahlXm69vKI598KAUezRC2DAVK
         lT/6WKWspSyoP+NxPdpbd5lCH5KktL/ROOYwlVFXMe583zPZC/Lvf5GQV4jsPdtER/
         qFuv4MVnx6h4XPLGxf34tczNR3KzYeet9NIjW8C8=
Date:   Tue, 5 Dec 2023 08:50:28 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     laburnumT <laburnumtec@gmail.com>
Cc:     linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: fix coding style camelCase issue
Message-ID: <2023120550-radish-hypnotic-cc5a@gregkh>
References: <20231204233404.goxljpo2jpwlotig@flo-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204233404.goxljpo2jpwlotig@flo-XPS-13-7390>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 12:34:04AM +0100, laburnumT wrote:
> Fixed camelCase issues in ddk750_sii164.c and impacted files.
> 
> Signed-off-by: laburnumT <laburnumTec@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_dvi.c    |  16 +--
>  drivers/staging/sm750fb/ddk750_sii164.c | 130 ++++++++++++------------
>  drivers/staging/sm750fb/ddk750_sii164.h |  16 +--
>  3 files changed, 81 insertions(+), 81 deletions(-)


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

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.

- It looks like you did not use your name for the patch on either the
  Signed-off-by: line, or the From: line (both of which have to match).
  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
