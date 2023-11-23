Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF2E7F5F80
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 13:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345446AbjKWMxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 07:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345403AbjKWMxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 07:53:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80198D6C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 04:53:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7979BC433B9;
        Thu, 23 Nov 2023 12:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700743985;
        bh=js9TbuMmNU2OPFbBM6VklvWBIfOE1qJiNCZI/7EDIA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kv60d1herfconAD/4bXwQqu2+54L6nYbsMpah1vnXq2GXxm5sAQj+AW+uV0jklH7N
         qojiCWnh3o1NPmgUTsCusOdx0zwiGMRn2/TG52qVrbrVxT3/TP+Ey8xAGIPxZUVagj
         s5Y1UDz2UvtOVc1AQD/HggHOIMeK71lVK1zryJEY=
Date:   Thu, 23 Nov 2023 12:49:16 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Charalampos Mitrodimas <charmitro@posteo.net>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH 1/8] staging: sm750fb: Rename sii164GetDeviceID to
 sii164_get_device_id
Message-ID: <2023112355-upheld-prowess-9cf0@gregkh>
References: <20231113150512.1210869-1-charmitro@posteo.net>
 <20231113150512.1210869-2-charmitro@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113150512.1210869-2-charmitro@posteo.net>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 03:05:06PM +0000, Charalampos Mitrodimas wrote:
> Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
> ---
>  drivers/staging/sm750fb/ddk750_dvi.c    | 2 +-
>  drivers/staging/sm750fb/ddk750_sii164.c | 6 +++---
>  drivers/staging/sm750fb/ddk750_sii164.h | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
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

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.


If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
