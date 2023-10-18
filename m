Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5D87CD8E7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjJRKK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjJRKKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:10:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75720BA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:10:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16995C433C9;
        Wed, 18 Oct 2023 10:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697623822;
        bh=W/5u6OVDfqhE3ZX1uUx7ETUjO9nJMhtB+mgRgMbWv6U=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oszNCLfkzVCHLT6ShibsHQOhLOOxQupDqP7/3WQCj+wIJjFm1f/BCZa6CTzEkwn0m
         7cAhnjVKLT3h2x2t+xTDnqYZOLph49oy663J6JJTfOlo+jC2ZMokLqM8j3UkisCxAK
         oPnQIGQFVvvH8gtZDDH4RUzq5LTnqkDvNNjwzjwMOmlvha5Pmp1MVLWyzJV7ZjZNXe
         ot3ynVcdkXX5GxJq72hZMDpNn4uwTJAPuk/26l4q+QPbl2ruAjcDkBYm1uwjBrhvnK
         cuK9+53H0aUDN7XRz19O9GeMrmqAmuIknTvhIwA1MjVnJwvTk143M5THSB6tLHg7aI
         T77mjDKQhq/yg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F26A3C04E27;
        Wed, 18 Oct 2023 10:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] Revert "net: wwan: iosm: enable runtime pm support for
 7560"
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169762382198.3133.9349110613879495903.git-patchwork-notify@kernel.org>
Date:   Wed, 18 Oct 2023 10:10:21 +0000
References: <20231017080812.117892-1-bagasdotme@gmail.com>
In-Reply-To: <20231017080812.117892-1-bagasdotme@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, loic.poulain@linaro.org,
        ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mwolf@adiumentum.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 17 Oct 2023 15:08:12 +0700 you wrote:
> Runtime power management support breaks Intel LTE modem where dmesg dump
> showes timeout errors:
> 
> ```
> [   72.027442] iosm 0000:01:00.0: msg timeout
> [   72.531638] iosm 0000:01:00.0: msg timeout
> [   73.035414] iosm 0000:01:00.0: msg timeout
> [   73.540359] iosm 0000:01:00.0: msg timeout
> ```
> 
> [...]

Here is the summary with links:
  - [net] Revert "net: wwan: iosm: enable runtime pm support for 7560"
    https://git.kernel.org/netdev/net/c/1db34aa58d80

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


