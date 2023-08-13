Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAC677A6A9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 16:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjHMOAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 10:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjHMOAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 10:00:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC989D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 07:00:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C665E617AE
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 14:00:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23CAAC433C7;
        Sun, 13 Aug 2023 14:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691935232;
        bh=5wO4k3U4hIilcA3NWZmmA1AAwH4Rjr2FoPzPPYf3uwk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QobnANBaBMtX7U5GTn/acLqtGcbfamZ9RVoE17NRBVV+L5/LglCQqmKZl1v6unK5A
         Q+HW3zsOKMHI6r0FpWRvsNB+/hO1C+NZ2r9WLDvKzOrooAl+9cLfforO1WV/x4Bi87
         oAX5ZemzMbCWjU9kR+hEyzxwsKgXb73Y08SCNJT1My7FTMwT16wNkNNZ2Z+JCyi/8V
         wBxlb0MFYg8JP14M1qH7j8akVIchkHzUp4UfdfWeURwyCwHMVKyYBmAW41lVJuHtgJ
         m9wVIbAUsJuyvKbPuEEGoTzeybW0u6hkriaNJAfWpqbjXtEckfhojMYAiDr9PIAPxA
         OUQ4YiMHvNXWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B551C39562;
        Sun, 13 Aug 2023 14:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: Remove leftover include from nftables.h
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169193523203.30914.17606443372751582506.git-patchwork-notify@kernel.org>
Date:   Sun, 13 Aug 2023 14:00:32 +0000
References: <20230811173357.408448-1-jthinz@mailbox.tu-berlin.de>
In-Reply-To: <20230811173357.408448-1-jthinz@mailbox.tu-berlin.de>
To:     =?utf-8?q?J=C3=B6rn-Thorben_Hinz_=3Cjthinz=40mailbox=2Etu-berlin=2Ede=3E?=@ci.codeaurora.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
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

On Fri, 11 Aug 2023 19:33:57 +0200 you wrote:
> Commit db3685b4046f ("net: remove obsolete members from struct net")
> removed the uses of struct list_head from this header, without removing
> the corresponding included header.
> 
> Signed-off-by: Jörn-Thorben Hinz <jthinz@mailbox.tu-berlin.de>
> ---
>  include/net/netns/nftables.h | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [net-next] net: Remove leftover include from nftables.h
    https://git.kernel.org/netdev/net-next/c/f614a29d6ca6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


