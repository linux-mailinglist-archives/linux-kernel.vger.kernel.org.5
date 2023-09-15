Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6817A271B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236911AbjIOTVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237097AbjIOTUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:20:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDFC1FDE
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:20:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5CE35C433A9;
        Fri, 15 Sep 2023 19:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694805625;
        bh=RO6qf7qZVjxCXaMK7rcZQigqMsi3RySqErofmju+oFI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lOHoLUBheqJX8Q2vzPkK+4g+JNeAKoWnVV86pnAHUNLb0XeuV+TFXtZ9Y2DEdKOR1
         1hiaFOwKVQSMuj2KhpnyHiEes07J/92XPufYCIGDx/+fZSba82YfivY12TtYTwQH0J
         rp4KP8YOaOD3dvbw0gujO87kTFZoI4iYqBamZeYgNBHPRwQjuTJoGTruCwgezPw7ze
         FFbvUruis89jVnpH/Qnf2ykrM8eu1SLJf7AOipWoYRaHfLBQQA7EePhpn0ynWB/FRo
         clqNtTuvFlb5QMIh/Ld+3vh6+yXYWAvInZpPzT2+mr/6v2yZxcjA1KhfCiUZPreDGo
         S/723v6bd/XLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 477EDC04DD9;
        Fri, 15 Sep 2023 19:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: Allow to use kfunc XDP hints and frags
 together
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169480562528.6917.14116492715748764436.git-patchwork-notify@kernel.org>
Date:   Fri, 15 Sep 2023 19:20:25 +0000
References: <20230915083914.65538-1-larysa.zaremba@intel.com>
In-Reply-To: <20230915083914.65538-1-larysa.zaremba@intel.com>
To:     Larysa Zaremba <larysa.zaremba@intel.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        maciej.fijalkowski@intel.com
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

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri, 15 Sep 2023 10:39:10 +0200 you wrote:
> There is no fundamental reason, why multi-buffer XDP and XDP kfunc RX hints
> cannot coexist in a single program.
> 
> Allow those features to be used together by modifying the flags condition
> for dev-bound-only programs, segments are still prohibited for fully
> offloaded programs, hence additional check.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: Allow to use kfunc XDP hints and frags together
    https://git.kernel.org/bpf/bpf-next/c/9b2b86332a9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


