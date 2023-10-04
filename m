Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DB27B8D45
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244619AbjJDTUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243944AbjJDTU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:20:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FF4C1;
        Wed,  4 Oct 2023 12:20:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88C79C433BA;
        Wed,  4 Oct 2023 19:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696447225;
        bh=ZMqZ+G5ZaetSrujKc1irQl51D6U6eypwDvFON5Y4FdY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Iaw06bIXLjm87sPpq6Uazp4EjaJ7nBtz3lp5XGbpbzw6c7pPK+Dik5ZpLLHDilMW+
         tpg24y2BbbrJgwwHjD/pVWJwJQwwWxfHwiLs3tw+a2FMU+M9MU+nrArqfN+BB5CY4y
         nv9sUrIvCbMPGEOQR3Ufdv9LkvnvCth1S5CDdctgEfIWM/PfQjKh3CZueNr74MTiGg
         2M1WvzycCglyCK6uALVWyFQXm8VtEMaaHoCYMTkszslLOI2gLkt7jetobvzJFAw+kS
         VCCKWtrY8gQhswWPwRwL1Exjo3yM6RL40nvPN02VSfzenZ5tINmvhpTd8pRY8fet1q
         caZPp7QZDYm4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6F62EE632D6;
        Wed,  4 Oct 2023 19:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: appletalk: remove cops support
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169644722545.5036.15571525046137185436.git-patchwork-notify@kernel.org>
Date:   Wed, 04 Oct 2023 19:20:25 +0000
References: <20230927090029.44704-2-gregkh@linuxfoundation.org>
In-Reply-To: <20230927090029.44704-2-gregkh@linuxfoundation.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spdx@vger.kernel.org, prarit@redhat.com, hch@infradead.org,
        vkuznets@redhat.com, jschlst@samba.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 Sep 2023 11:00:30 +0200 you wrote:
> The COPS Appletalk support is very old, never said to actually work
> properly, and the firmware code for the devices are under a very suspect
> license.  Remove it all to clear up the license issue, if it is still
> needed and actually used by anyone, we can add it back later once the
> license is cleared up.
> 
> Reported-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: jschlst@samba.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> [...]

Here is the summary with links:
  - net: appletalk: remove cops support
    https://git.kernel.org/netdev/net-next/c/00f3696f7555

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


