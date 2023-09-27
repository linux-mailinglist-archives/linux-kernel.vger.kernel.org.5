Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FF77B037C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjI0MHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjI0MHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:07:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C794EBE
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 05:07:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B13C433C8;
        Wed, 27 Sep 2023 12:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695816435;
        bh=BcXd/ubgZpklAR5e9jYsrmlgwa+5/i+hTIvv1bYjz04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YY1ZqAPL55jB/D09VontsxjWV9x+ayVfpHHzzZkAVK8+6d3/Pipe72ZEdyiSwL9KO
         xqXu4e1RDTdTbR5+UxvBitrCJ/aQndUFkhHMb3N8IVBJDlF8z+SjxFrwHR/lfG0deq
         DLTWT1qvfyQoa6vTAIVtOT9TUZDB68fYiG9QSx20=
Date:   Wed, 27 Sep 2023 14:07:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gary Rookard <garyrookard@fastmail.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3 v2] staging: rtl8192e: renamed a variable
Message-ID: <2023092700-unmapped-sacrament-09df@gregkh>
References: <20230927112635.27637-1-garyrookard@fastmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927112635.27637-1-garyrookard@fastmail.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 07:26:32AM -0400, Gary Rookard wrote:
> Hi!,
> 
> This patch series renames the same mixed case variable in (3) different
> files of staging/rtl8192e.
> 1) rtllib.h
> 2) rtl819x_HTProc.c
> 3) rtllib_module.c
> 
> Regards,
> -Gary Rookard <garyrookard@fastmail.org>
> 
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
