Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3BA78A11C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 21:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjH0TAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 15:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjH0S77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 14:59:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB47F5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 11:59:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B617262409
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 18:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07D6C433C7;
        Sun, 27 Aug 2023 18:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693162796;
        bh=JZkw1g6LL/Pl/Mcae3aUBoUUkDqbWUD4FUhrL/4kkF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vn/XPuALsoYO4TokQCPK8SfHSXvfPfZl2aVxmc3zECXh9vHuzcO3Zw/j3Q03F64s7
         SYI/a0LK7wtDrsmxKdHRyQWmvXqO8ZMP73yZ/O6DrUuiZqm/KSdLeT9+ojUViu2c1+
         HaObhM5DS/cxvWdarIpykwaEEXvrFue0jLjpdco8=
Date:   Sun, 27 Aug 2023 20:59:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexon Oliveira <alexondunkan@gmail.com>
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 0/4] staging: vme_user: fix checks reported in vme_fake.c
Message-ID: <2023082741-presume-aluminum-588c@gregkh>
References: <cover.1693082101.git.alexondunkan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1693082101.git.alexondunkan@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 06:05:14PM -0300, Alexon Oliveira wrote:
> The goal of this series is to fix all warnings related to
> aligment of open parenthesis, lines not ending with '(',
> unnecessary blank lines and unnecessary space after a cast
> in the vme_fake.c file, as reported by checkpatch to adhere
> to the Linux kernel coding-style guidelines.
> 
> Alexon Oliveira (4):
>   staging: vme_user: fix check alignment of open parenthesis in
>     vme_fake.c
>   staging: vme_user: fix check lines not ending with '(' in vme_fake.c
>   staging: vme_user: fix check unnecessary blank lines in vme_fake.c
>   staging: vme_user: fix check unnecessary space after a cast in
>     vme_fake.c
> 
>  drivers/staging/vme_user/vme_fake.c | 72 ++++++++++++++---------------
>  1 file changed, 35 insertions(+), 37 deletions(-)
> 
> -- 
> 2.41.0
> 
> 

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
