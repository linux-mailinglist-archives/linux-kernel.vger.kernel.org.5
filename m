Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B30B7F5F72
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 13:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345366AbjKWMwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 07:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345271AbjKWMwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 07:52:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31724189
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 04:52:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03413C433C7;
        Thu, 23 Nov 2023 12:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700743971;
        bh=EOAR9aStMcqAj4DF61/GK2dpwSnF0ONfVuJDcw9Utyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fXkVuCCkg464swbbqS6oYlj++sI478XJM0yJropc+VN9LlD2mEYYAoSXkB9cB46GM
         b9uNdZl+wQB8g+LQ+tgsSCd5eiaL1Uz1JEyP2R+NwqAETh4wuBXf2LZRAL8QhFg0Xo
         sU9eFAbQx1IQMnUw/aFcjxOOFQGuasZ9BsOlLfnQ=
Date:   Thu, 23 Nov 2023 12:44:13 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gary Rookard <garyrookard@fastmail.org>
Cc:     philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] staging: rtl8192e: renaming of 5 different variables
 patch series
Message-ID: <2023112353-appraisal-snort-6d8a@gregkh>
References: <20231121181435.9337-1-garyrookard@fastmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121181435.9337-1-garyrookard@fastmail.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 01:14:30PM -0500, Gary Rookard wrote:
> Hi,
> 
> This patch series renames 5 different variables from
> Pascal/CamelCase to snake case.
> 
> Linux kernel coding style (cleanup), checkpatch Avoid CamelCase.
> Driver/module rtl8291e compiles.
> 
> Patch 1/5) renamed variable from HTMcsToDataRate -> ht_mcs_to_data_rate
> Patch 2/5) renamed variable from TXCountToDAtaRate -> tx-count_to_data_rate
> Patch 3/5) renamed variable from IsHTHalfNmodeAPs -> is_ht_half_nmode_aps
> Patch 4/5) renamed variable from HTIOTPeerDetermine -> ht_iot_peer_determine
> Patch 5/5) renamed variable from HTIOTActIsMgntUseCCK6M -> ht_iot_act_is_mgnt_use_cck_6m
> 
> Regards,
> Gary

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
