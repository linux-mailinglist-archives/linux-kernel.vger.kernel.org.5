Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D752D76A768
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 05:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjHADU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 23:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjHADUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 23:20:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A7A1BE6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 20:20:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69D7F61405
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B971DC433CB;
        Tue,  1 Aug 2023 03:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690860023;
        bh=ahxgk78QsKZbjacZt3OFHUk3/T0+1TNsBU0moZ+CxpQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=t+KVYo1h4B5cFYn0SETqeHd+sF02rvQ50g3TZo3mg9T6axSsgtWs/f2jg6I/+2sh3
         Uom2B75t85Xb1pg2CfuQT9G0FDSHzsfy35xa5mQ3m7Z0/HVwYMNECuxIVASHeKVnO8
         kVj9E/Ek+fG4ugafi+3f2onfysKZvo3AEAmnSjfr+nOE+QhdNPtuxmBnhIeRDk+tt6
         1w2ib8h5IPTkJBJyFpq88vWOQh0HZCDonEyPW4Hc4mgPTPSb9zIKvbji1BONefbU+G
         GAANWOq0C9PDjJtWxes9Il7UYFV26AdpJ721K/akAoFhv4kPOID1CJfOCm9awvegjk
         1urgHYi/9htOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F751C595C0;
        Tue,  1 Aug 2023 03:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/hsr: Remove unused function declarations
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169086002364.11962.15301594077499918218.git-patchwork-notify@kernel.org>
Date:   Tue, 01 Aug 2023 03:20:23 +0000
References: <20230729123456.36340-1-yuehaibing@huawei.com>
In-Reply-To: <20230729123456.36340-1-yuehaibing@huawei.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 29 Jul 2023 20:34:56 +0800 you wrote:
> commit f421436a591d ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")
> introducted these but never implemented.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  net/hsr/hsr_netlink.h | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [net-next] net/hsr: Remove unused function declarations
    https://git.kernel.org/netdev/net-next/c/2f48401dd0f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


