Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AD07E8B17
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 14:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjKKNyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 08:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjKKNyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 08:54:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B15D2D6B;
        Sat, 11 Nov 2023 05:54:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C49C433C7;
        Sat, 11 Nov 2023 13:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699710847;
        bh=gSh//aFTvq0UCrM9NSAGPqHRgxT4F+KhSbTqoCS7sKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=klmXML/Jptz6z4cfcNzZvrZfgz0xDEW+S73Cxk961+HSjwc6DcvxvZ4MhKxCsIf2b
         FB0JyxLRkyIV+tsvhrtYufi39n/OrsiXihLiAHoCsCsOChp/KYjZMR5CUFcM6kKIG5
         FLi2a5KSwpmqghT7cHbB1Vz4an6CY/FbTogv8k9oQbikF5Fy+VNLIg8Y1nip3D3F2H
         fIV93WHTXvwKRRSw2FjGrsMZqJkP0v7WNvzq8B95K4UOP+WDZhCD8jdeK/BVK4pg3G
         feUB8Y05wFDKdlmRlwwTxOSct4zsH7NLpLLkmLH1Vev0qe9UYYq+/TMGuAWegE5CN9
         3nMeyNqqRkdLw==
Date:   Sat, 11 Nov 2023 08:54:03 -0500
From:   Mike Rapoport <rppt@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the memblock tree
Message-ID: <20231111135403.GA6696@kernel.org>
References: <20231109085024.3de5b700@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109085024.3de5b700@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Thu, Nov 09, 2023 at 08:50:24AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in Linus Torvalds' tree as a different commit
> (but the same patch):
> 
>   0f5e4adb608c ("memblock: report failures when memblock_can_resize is not set")
> 
> This is commit
> 
>   e96c6b8f212a ("memblock: report failures when memblock_can_resize is not set")
> 
> in Linus' tree.

It looks like I forgot to push for-next with e96c6b8f212a after rebasing it :(
 
> -- 
> Cheers,
> Stephen Rothwell

-- 
Sincerely yours,
Mike.
