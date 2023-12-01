Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AC7800523
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377781AbjLAIDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjLAIDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:03:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCE510FC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 00:03:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858A2C433C7;
        Fri,  1 Dec 2023 08:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701417822;
        bh=H5grwdaqymFeXOtE+NIUpZrwnX5FwfxMDL15NcmL2zg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nMXP1rKCl6y6vqBmLKhrmcW+9nzYGTzy7+wrD7MVAN58qz+yywLwy6NTlHlCFo7/V
         tg6QSoOZMEFPME1XScYA5xGzHGI6cbngF3/tsOBMf/Y4dmbW0iPgffw482u0yamW2m
         depMWz4vXUg7JYsfzIFMsLsqTHmEQj3kGw8lBgs4=
Date:   Fri, 1 Dec 2023 08:03:39 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hu Haowen <2023002089@link.tyut.edu.cn>
Cc:     akpm@linux-foundation.org, masahiroy@kernel.org,
        ndesaulniers@google.com, n.schier@avm.de, ojeda@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scripts/show_delta: reformat code
Message-ID: <2023120120-kissing-spill-d205@gregkh>
References: <20231201053540.9534-1-2023002089@link.tyut.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201053540.9534-1-2023002089@link.tyut.edu.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 01:35:40PM +0800, Hu Haowen wrote:
> Correct some lines in irregular coding style to make them look more
> harmonious and fit the common coding regulations in Python.
> 
> Signed-off-by: Hu Haowen <2023002089@link.tyut.edu.cn>
> ---
>  scripts/show_delta | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
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
