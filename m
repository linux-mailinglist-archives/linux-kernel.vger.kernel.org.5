Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAD97BB141
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 07:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjJFFk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 01:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjJFFkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 01:40:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A244BF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 22:40:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A65DFC433C9;
        Fri,  6 Oct 2023 05:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696570823;
        bh=i0vWmFm1rNMbqmdH6aUvaNH/rlt5gbDd1KUTPusN3G4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MAEX3Bp/uW1+WDUINavoQnIQUOAWvhzEU0s3t3yTdVc5FYPFav4vNwFGBkQrHM2PA
         ogGDA78M/otmKi1W0BwL4HXjBjS3YPbEkXP+Lrjb4PhljD3VTkiGOg4SYMQdPYvUjc
         BeuLqFg/P6ITAMLavMP2SV63Zh72ZmKL6EjQ9BqOhQ8XM9wKzi8kNc5mTqt7enaEH8
         gtOhydo4txddSplNvrNslndglLZ5y0RDdVT/l2PxYksc9ruaOzH9D9tOUdzhjg2V2p
         gwKKn04bwj4waGOSpGXtj+4pU0F7FpMQMSXAkhrjhAHD0XVK9zsovu9xQsR/o5cbBF
         X8hWke5jxG7lA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8B60EC595CB;
        Fri,  6 Oct 2023 05:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Fix the comment for bpf_restore_data_end()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169657082356.32138.7846294704221528255.git-patchwork-notify@kernel.org>
Date:   Fri, 06 Oct 2023 05:40:23 +0000
References: <20231005072137.29870-1-akihiko.odaki@daynix.com>
In-Reply-To: <20231005072137.29870-1-akihiko.odaki@daynix.com>
To:     Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
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

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu,  5 Oct 2023 16:21:36 +0900 you wrote:
> The comment used to say:
> > Restore data saved by bpf_compute_data_pointers().
> 
> But bpf_compute_data_pointers() does not save the data;
> bpf_compute_and_save_data_end() does.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> [...]

Here is the summary with links:
  - bpf: Fix the comment for bpf_restore_data_end()
    https://git.kernel.org/bpf/bpf-next/c/9c8c3fa3a52b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


