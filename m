Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C4A7A2F4A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 12:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbjIPKke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 06:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjIPKk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 06:40:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56998C7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 03:40:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB828C433C9;
        Sat, 16 Sep 2023 10:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694860823;
        bh=gMjmVOJ/+tUIG7QXWPuL0HqhSpfLApgRTDaNzDhJKto=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ORRtssDw+IZq/dYNr3OoPgJ8nDNoEe7JYHUXYVmoXtLSCzEZj787CZ23urIS/T4Kv
         aCGCtycVv7CbCORSrW7fHJynT9YkaUpopCHPnGq18rA8DXeNQ0WisZQeOZY+Cgna1H
         bqS50j6XMz4zOBUWlocApSIHP3WEXTXzs0W3Ugof9xG5iubb7vWGRv/KfTLh10Q8ye
         4E5PBgDMRZ7DZX+4goXQYMVSDXQnLoFSM5STtJ4VLtYXJzYwoWJ6CBscZ/UBvpIrI4
         84Nr8Ani/+Zln7VXyhVOMLDmYW+mzNVjS2p4WUbSwTwBhN2BInMnIUKMXuIucQST/A
         KpW03L3XdMi7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE10CE26882;
        Sat, 16 Sep 2023 10:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] sfc: make coding style of PTP addresses consistent
 with core
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169486082370.31413.1577389710976551346.git-patchwork-notify@kernel.org>
Date:   Sat, 16 Sep 2023 10:40:23 +0000
References: <20230914151916.21044-1-alex.austin@amd.com>
In-Reply-To: <20230914151916.21044-1-alex.austin@amd.com>
To:     Alex Austin <alex.austin@amd.com>
Cc:     netdev@vger.kernel.org, linux-net-drivers@amd.com,
        ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com,
        linux-kernel@vger.kernel.org
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
by David S. Miller <davem@davemloft.net>:

On Thu, 14 Sep 2023 16:19:16 +0100 you wrote:
> Follow the style used in the core kernel (e.g.
> include/linux/etherdevice.h and include/linux/in6.h) for the PTP IPv6
> and Ethernet addresses. No functional changes.
> 
> Signed-off-by: Alex Austin <alex.austin@amd.com>
> Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] sfc: make coding style of PTP addresses consistent with core
    https://git.kernel.org/netdev/net-next/c/487e1937b9c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


