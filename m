Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37FC7F9243
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 11:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjKZKey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 05:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKZKew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 05:34:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20872FD
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 02:34:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78559C433C7;
        Sun, 26 Nov 2023 10:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700994898;
        bh=FUAkUf1HPGsRCvh9R8252q79NBvhybHGAFsP7UBdKqA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fjKkxhFGSbc6djr7bcrQCXUtcUjTKfoCB4c2QD7MUAi5RagWH9/F9gaQ1pct2HqYU
         BUnbYAAC5SUV2GZJx/4GXadbRMJ+DT0AQWu0EVA5OKxi8Ea7ioFWNoI9hPVDv3NKJr
         g18Ts2f22M/vI1WcA8uOEW2ZNkWpSVHcUwaapbms=
Date:   Sun, 26 Nov 2023 10:34:55 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ren Xiao <u202112004@hust.edu.cn>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: storage: transport: Fix switch-case indentation
 typo in 'transport.c'
Message-ID: <2023112639-perjurer-suffocate-965d@gregkh>
References: <20231123063417.2625808-1-u202112004@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123063417.2625808-1-u202112004@hust.edu.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 01:34:16AM -0500, Ren Xiao wrote:
> Adjusted the indentation of the switch-case code blocks which
> start from line 1051 and line 1304.
> 
> Signed-off-by: Ren Xiao <u202112004@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>  drivers/usb/storage/transport.c | 46 ++++++++++++++++-----------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
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
