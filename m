Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EE77F9240
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 11:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjKZKe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 05:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKZKe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 05:34:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8E0F0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 02:34:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22798C433C8;
        Sun, 26 Nov 2023 10:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700994872;
        bh=P/34EZh4uB3kuC67GjgvQ3qNX76o8UEsRZC9ofNhGlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AfUjISw24DmjMgW0H+u8Td1m9qJjiNvAKvcnX0174x5rfkPcFxC9wH6tLkMaygFZr
         qMpKtdisxMI5D4PmgNJW+jNPKj05CDqoNUDn5x/kDRmvr4aNENBRuFGicW2JAGf/u/
         07qO/o9lP8wBq7tPnyzCBipyw7zFN7MbNZaQWFho=
Date:   Sun, 26 Nov 2023 10:34:30 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     shitao <shitao@kylinos.cn>
Cc:     justin.chen@broadcom.com, alcooperx@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] usb: Correct misspelling comment word dynamic
Message-ID: <2023112610-curling-swinging-89cb@gregkh>
References: <20231123032245.2986309-1-shitao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123032245.2986309-1-shitao@kylinos.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 11:22:45AM +0800, shitao wrote:
> The word 'dyanmic memory'is misspelled, fixed the word 'dyanmic'
> to 'dynamic',avoiding confusing other developers.
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: shitao <shitao@kylinos.cn>
> ---
>  drivers/usb/gadget/udc/bdc/bdc_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

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
