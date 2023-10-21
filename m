Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B69F7D1CA5
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 13:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjJULA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 07:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjJULAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 07:00:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72D999;
        Sat, 21 Oct 2023 04:00:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4ACB9C433D9;
        Sat, 21 Oct 2023 11:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697886023;
        bh=pHxc3TjOidZhUMegDYrzOuNMGjtpbkDMbHgM9Ic2feI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KAJYwrxuu2zx5lp3dQ7gaSYy+ddr4QlTDyNa+kAgBWcoVDOu+HVi9lWCe42gc8/LM
         BOxb568HED6e8Nn5uGg155kqipT2ykkuRtCSbTF09p4X2KfeTusEvuEsUPVUi9/0AN
         ofRjftP3IYLR7nd6DgJDxQC2iLh0Xwk7q36Ot9lshwjHgylo4g5jvpDHR4L2VQl97z
         OVQJ5q6kG1LiRKl7KNGf+utCmurWLT5kwuE4sD3MVpVts6RkMGtPCPRzab41XbAFFW
         +vPd4faFAh8n8hQVjvr0qBa8AKCtDyO1jMkIna6jl+a8BkpP3iegAnF7HZdCTjveND
         P0mA0z+8xJHOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 351D6C691E1;
        Sat, 21 Oct 2023 11:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: mv88e6xxx: add an error code check in
 mv88e6352_tai_event_work
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169788602321.24143.8467295347887183711.git-patchwork-notify@kernel.org>
Date:   Sat, 21 Oct 2023 11:00:23 +0000
References: <20231020090003.200092-1-suhui@nfschina.com>
In-Reply-To: <20231020090003.200092-1-suhui@nfschina.com>
To:     Su Hui <suhui@nfschina.com>
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
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

On Fri, 20 Oct 2023 17:00:04 +0800 you wrote:
> mv88e6xxx_tai_write() can return error code (-EOPNOTSUPP ...) if failed.
> So check the value of 'ret' after calling mv88e6xxx_tai_write().
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/net/dsa/mv88e6xxx/ptp.c | 4 ++++
>  1 file changed, 4 insertions(+)

Here is the summary with links:
  - net: dsa: mv88e6xxx: add an error code check in mv88e6352_tai_event_work
    https://git.kernel.org/netdev/net-next/c/a792197f5070

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


