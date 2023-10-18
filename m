Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6F57CD641
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbjJRIUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjJRIUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:20:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92C9F7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:20:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 626E7C433D9;
        Wed, 18 Oct 2023 08:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697617222;
        bh=g92m7+sSdBA8KJbvUHeNmVunsbDNRD1vE8MRrBz6ljA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=r59T8zg47HcnAHnSOnRAUnW0uvwPdLEQKC4KCkYgr375lpc7ZUlcrJKybGMbzx1+F
         4C3J464Or47cKMqLHRKHVHfjX9UEN1ER7Ppz8GaD+jFKb4ANMaozLRpLayx80xbVZs
         Q9lvT87ebPHTmcJ55SsRkEndMxPx+F4AyLfBoWMDZ+sJQa7urPxiH18jHy8Gkt5oZ+
         wwxvURhcQq7ZdWxnd8koALV9vpof7DCGYlPti+bLISNlYVpGYZspX4mISmud7OqYU1
         H5dZgDpG20EKP1BpZQklijygeUlG69Y4zhgnmUJJx6SiFtoEQO7GiVZm5imdEar0b2
         ePJOpyc6MMlow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 45BD1C04E27;
        Wed, 18 Oct 2023 08:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: add options and frags to
 xdp_hw_metadata
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169761722228.19172.14123962875957627623.git-patchwork-notify@kernel.org>
Date:   Wed, 18 Oct 2023 08:20:22 +0000
References: <20231017162800.24080-1-larysa.zaremba@intel.com>
In-Reply-To: <20231017162800.24080-1-larysa.zaremba@intel.com>
To:     Larysa Zaremba <larysa.zaremba@intel.com>
Cc:     bpf@vger.kernel.org, martin.lau@linux.dev, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, maciej.fijalkowski@intel.com,
        hawk@kernel.org, sdf@google.com
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 17 Oct 2023 18:27:57 +0200 you wrote:
> This is a follow-up to the commit 9b2b86332a9b ("bpf: Allow to use kfunc
> XDP hints and frags together").
> 
> The are some possible implementations problems that may arise when
> providing metadata specifically for multi-buffer packets, therefore there
> must be a possibility to test such option separately.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: add options and frags to xdp_hw_metadata
    https://git.kernel.org/bpf/bpf-next/c/bb6a88885fde

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


