Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAFD7D05AE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 02:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346721AbjJTAK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 20:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjJTAK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 20:10:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADC2CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 17:10:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBB7CC433C8;
        Fri, 20 Oct 2023 00:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697760625;
        bh=UxsE/uWtbys8JcAUQ7gPTjZn3MW++33Gud8ZJFs3A8s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=B/jN+iqNKfTy4JNL3E1ttftNoMFriRRmTUfq+GWaka4Is8gxzok1yc/LvUun9Csej
         T/Rpp+hisgGZa+7SUBcpiVbxoj5T7kVSgKaqy3n5H8bJs6TZMyhw/MGDl15QZGwQQJ
         8arL1X4aMwfFvAyF82TonVtQQoePdAzzd/mcvV7gw/Yce4cOsIeewqUF2ZLhNBzAQ6
         WxCICBcgOdQpRd0jYg2JFNYdgZxPcOYNIaa2UlOQk/9kLEmWfx6z+cfMM8Rtz0rPpE
         +j+2madHpTc/rQLidawxbmnjZLb0ebA7HbNukWct4G9LEMdQrkkptqrl+p/LG690aT
         3ugx3zAi42ITg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D273BC595CE;
        Fri, 20 Oct 2023 00:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH bpf-next v6 0/8] Add Open-coded task,
 css_task and css iters
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169776062485.5217.16191150488708968895.git-patchwork-notify@kernel.org>
Date:   Fri, 20 Oct 2023 00:10:24 +0000
References: <20231018061746.111364-1-zhouchuyi@bytedance.com>
In-Reply-To: <20231018061746.111364-1-zhouchuyi@bytedance.com>
To:     Chuyi Zhou <zhouchuyi@bytedance.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@kernel.org, tj@kernel.org,
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

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 18 Oct 2023 14:17:38 +0800 you wrote:
> This is version 6 of task, css_task and css iters support.
> 
> --- Changelog ---
> 
> v5 -> v6:
> 
> Patch #3:
>  * In bpf_iter_task_next, return pos rather than goto out. (Andrii)
> Patch #2, #3, #4:
>  * Add the missing __diag_ignore_all to avoid kernel build warning
> Patch #5, #6, #7:
>  * Add Andrii's ack
> 
> [...]

Here is the summary with links:
  - [RESEND,bpf-next,v6,1/8] cgroup: Prepare for using css_task_iter_*() in BPF
    https://git.kernel.org/bpf/bpf-next/c/6da88306811b
  - [RESEND,bpf-next,v6,2/8] bpf: Introduce css_task open-coded iterator kfuncs
    https://git.kernel.org/bpf/bpf-next/c/9c66dc94b62a
  - [RESEND,bpf-next,v6,3/8] bpf: Introduce task open coded iterator kfuncs
    https://git.kernel.org/bpf/bpf-next/c/c68a78ffe2cb
  - [RESEND,bpf-next,v6,4/8] bpf: Introduce css open-coded iterator kfuncs
    https://git.kernel.org/bpf/bpf-next/c/7251d0905e75
  - [RESEND,bpf-next,v6,5/8] bpf: teach the verifier to enforce css_iter and task_iter in RCU CS
    https://git.kernel.org/bpf/bpf-next/c/dfab99df147b
  - [RESEND,bpf-next,v6,6/8] bpf: Let bpf_iter_task_new accept null task ptr
    https://git.kernel.org/bpf/bpf-next/c/cb3ecf7915a1
  - [RESEND,bpf-next,v6,7/8] selftests/bpf: rename bpf_iter_task.c to bpf_iter_tasks.c
    https://git.kernel.org/bpf/bpf-next/c/ddab78cbb52f
  - [RESEND,bpf-next,v6,8/8] selftests/bpf: Add tests for open-coded task and css iter
    https://git.kernel.org/bpf/bpf-next/c/130e0f7af9fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


