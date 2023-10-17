Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FBB7CC524
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343969AbjJQNu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbjJQNu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:50:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535B9FA;
        Tue, 17 Oct 2023 06:50:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECEACC433C9;
        Tue, 17 Oct 2023 13:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697550625;
        bh=pWL/sBiYFA5AQzidelkikmDkcUPvDgNo6SXaQJhSsMA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Tw1PA02evYT6BgHFasJa+HizwZNIsnhdOYr7aWjPnIHxyA9pyAjv7qIA21mQ3K/Ms
         iRmu9EPiwQSgexfXz4SVH9c1ozXav9epcW1Fz4aPiFHxB77JdYrXxc66KvCnwL4/M7
         m98Cw/xu+A/rvMjsMhbIYpkQ+UbngkjpEfklCw2AlEvjCmXlzmsoIpdL6PUZqmJ7+j
         9anpHTWn03bUIHhCnJMo+IPbW6iIiKChVCht3O87C/+U92gQAui9y6Q3i9yUicLJVf
         VQKoUu6xgnpJlrnlJ/f82zEVWWyTMh3JXmfDMijtKlPm5IN1DZV4k1MrdcJOb7Mtit
         pNufWoqzlzu8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CFD8EC04E27;
        Tue, 17 Oct 2023 13:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] net: openvswitch: Use struct_size()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169755062484.25061.3738739418791842854.git-patchwork-notify@kernel.org>
Date:   Tue, 17 Oct 2023 13:50:24 +0000
References: <e5122b4ff878cbf3ed72653a395ad5c4da04dc1e.1697264974.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <e5122b4ff878cbf3ed72653a395ad5c4da04dc1e.1697264974.git.christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     pshelar@ovn.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, netdev@vger.kernel.org,
        dev@openvswitch.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 14 Oct 2023 08:34:52 +0200 you wrote:
> Use struct_size() instead of hand writing it.
> This is less verbose and more robust.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v2: No change
> 
> [...]

Here is the summary with links:
  - [v2,1/2] net: openvswitch: Use struct_size()
    https://git.kernel.org/netdev/net-next/c/df3bf90fef28
  - [v2,2/2] net: openvswitch: Annotate struct mask_array with __counted_by
    https://git.kernel.org/netdev/net-next/c/7713ec844756

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


