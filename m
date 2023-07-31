Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C849576A2D2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 23:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjGaVbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 17:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjGaVbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:31:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48ED51FD3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 14:30:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86096612F0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 21:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7A9CC4339A;
        Mon, 31 Jul 2023 21:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690839022;
        bh=6ln8+1FepUmEq0n1wC3+z9xd4PEXVx5YzvZK+JmHd/Q=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CE8z3JqfEwiFZrU9AhZttfPlEoyX1m+bdAygorM+41Y6doM/yXzXSlauAvzEFVfa2
         gyWJtC5Pu4tNkCiUyAszW+LWLJEBBVIvF/666RU06YOuD+CCuakHGDxbVCImIfuEJL
         rpEQy6Dgje5vgyBwK63vZpG01LWs2X4VgIByMeoxkBNQRziGnzr3dXn9NZAQRLGvRo
         VYyNOAHlp9I/e5Ne7l4Li4EqdooS5WY7zOUtMM5aIau+fowRzMBQiTnE7IVbua0Jm1
         Um0Yxm+eAczuRBnCTkgHIA8bx1tUFYCM+KM8MKrw1RLktkMV20MIrpPIaCdq2WvQ78
         +kC+43eb2kSWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D001FC595C0;
        Mon, 31 Jul 2023 21:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] devlink: Remove unused extern declaration
 devlink_port_region_destroy()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169083902284.31832.11392552376480505400.git-patchwork-notify@kernel.org>
Date:   Mon, 31 Jul 2023 21:30:22 +0000
References: <20230728132113.32888-1-yuehaibing@huawei.com>
In-Reply-To: <20230728132113.32888-1-yuehaibing@huawei.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Jul 2023 21:21:13 +0800 you wrote:
> devlink_port_region_destroy() is never implemented since
> commit 544e7c33ec2f ("net: devlink: Add support for port regions").
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/devlink.h | 2 --
>  1 file changed, 2 deletions(-)

Here is the summary with links:
  - [net-next] devlink: Remove unused extern declaration devlink_port_region_destroy()
    https://git.kernel.org/netdev/net-next/c/2628d40899d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


