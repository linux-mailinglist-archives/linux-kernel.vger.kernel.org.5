Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349CF7756A3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 11:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbjHIJqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 05:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjHIJqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:46:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3DEED
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 02:46:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35903630CB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 09:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E67C433C8;
        Wed,  9 Aug 2023 09:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691574394;
        bh=oOlt+ovyRnUTnUysEvSZ+7yMPDKU2CWKrUtdAYUVWCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CP6bwH9+vyQZhRgXlABiu/1G+FsVmds9HjlEcQmKQ6PgCAjEbRJVCfO7OyTY5KxC+
         oy2+nFCLaHMtL2Kw26pLwjWzuJ0BhGbz6YqyxoNsYvV7UHuNiiWcvY92U1MUInVeOZ
         WS1jtbhfOYIatYZ139mMwzgEV0HwZefGCvtRQDKc=
Date:   Wed, 9 Aug 2023 11:46:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Diogo Silva <diogompaissilva@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: cfg80211.c: removed unnecessary
 parenthesis to match coding style
Message-ID: <2023080951-escalate-unnamed-e6d4@gregkh>
References: <20230808221339.2667-1-diogompaissilva@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808221339.2667-1-diogompaissilva@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 11:12:36PM +0100, Diogo Silva wrote:
> Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
> ---
>  drivers/staging/wlan-ng/cfg80211.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

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

- You sent a patch that has been sent multiple times in the past, and is
  identical to ones that have been rejected.  Please always look at the
  mailing list traffic to determine if you are duplicating other
  people's work.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
