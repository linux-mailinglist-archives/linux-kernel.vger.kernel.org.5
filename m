Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC247C4E39
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjJKJK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjJKJK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:10:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CB998
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 02:10:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC888C433C9;
        Wed, 11 Oct 2023 09:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697015425;
        bh=pIQp+LwTNvdQ0PzfE/8yCOe2705OueXQH2dq7DVVotQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=q6aamtxbGtUlYMSm9SCZw2QSPP9BDsbf1vS/1Ru5Oa+1zn7Nq+1dr62GR0zyBifEb
         BcVS+bCfO8AZIGtJIRZ8xx4hatOyovPM2WWMJPuv2ktcwbyfnx5gsiwIXl7khQYNWn
         AaMNTHdwewbqtGi8LX38AsIYVTAG/qZ+xGNXXKh573RxhMGN0kfEUHYuK+3YmIA4PN
         fOTDrANmdLemo7ombdlud1ycIDlsPCCtYofuotopih+SZfqey+o7ZW+JYSgifnVIhr
         DdZ8+ZzcBht7YbjH7IXZDOoxGzH6hGjlcqMj3o+De9U2k9iLdiVcm71Y2tey1CbTR4
         PcMWE1ZqxooIQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1AC8E000BB;
        Wed, 11 Oct 2023 09:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8] net/core: Introduce netdev_core_stats_inc()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169701542485.14579.951274482359879368.git-patchwork-notify@kernel.org>
Date:   Wed, 11 Oct 2023 09:10:24 +0000
References: <20231009111633.2319304-1-yajun.deng@linux.dev>
In-Reply-To: <20231009111633.2319304-1-yajun.deng@linux.dev>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, aleksander.lobakin@intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  9 Oct 2023 19:16:33 +0800 you wrote:
> Although there is a kfree_skb_reason() helper function that can be used to
> find the reason why this skb is dropped, but most callers didn't increase
> one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropped.
> 
> For the users, people are more concerned about why the dropped in ip
> is increasing.
> 
> [...]

Here is the summary with links:
  - [net-next,v8] net/core: Introduce netdev_core_stats_inc()
    https://git.kernel.org/netdev/net-next/c/5247dbf16cee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


