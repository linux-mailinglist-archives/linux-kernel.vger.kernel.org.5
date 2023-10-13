Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5E37C8DEC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 21:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjJMTu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 15:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJMTuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 15:50:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D619FAD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 12:50:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 769A4C433C9;
        Fri, 13 Oct 2023 19:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697226623;
        bh=nU3lfWuOBJCCDbTdLJSxPtsWLHy5KsIcr+GcaO3kyFA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=al6hiEekNz3FwJh7qBx/C21CQop2AauBSfo0RIxca8ASDX9XnCxSBR0P6NOBk4Jwy
         ++ViioRDyeOh9ZEtu20m3JwHdQLVeksJF+R1Hekf20Ce+fpEC+321324JjKIbRR0CX
         UfiC26O8Ung901hdhCfbHVNtASMwy6DlsJ/fdjbe2itGfO8brbvCPqsP3oHhVdFnnu
         h7kDz44LOtHw47UStZDP+ZhBKbp+MGEcL+ggZ2DLLF9yvBaiZZrW9ldWRGKDSKp7hY
         GJpVXq+BEO6Em97Tm18Gd5+7FbLNjLOQoBNnOTyqyz8AJQT0Gdc1Nfwve9sNHW2sRv
         +1mSOKLVRE3Jg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5EA11E1F669;
        Fri, 13 Oct 2023 19:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: change syscall_nr type to int in struct
 syscall_tp_t
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169722662338.10738.1648512697831961767.git-patchwork-notify@kernel.org>
Date:   Fri, 13 Oct 2023 19:50:23 +0000
References: <20231013054219.172920-1-asavkov@redhat.com>
In-Reply-To: <20231013054219.172920-1-asavkov@redhat.com>
To:     Artem Savkov <asavkov@redhat.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, netdev@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, tglx@linutronix.de,
        linux-rt-users@vger.kernel.org, jolsa@kernel.org
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
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 13 Oct 2023 07:42:19 +0200 you wrote:
> linux-rt-devel tree contains a patch (b1773eac3f29c ("sched: Add support
> for lazy preemption")) that adds an extra member to struct trace_entry.
> This causes the offset of args field in struct trace_event_raw_sys_enter
> be different from the one in struct syscall_trace_enter:
> 
> struct trace_event_raw_sys_enter {
>         struct trace_entry         ent;                  /*     0    12 */
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: change syscall_nr type to int in struct syscall_tp_t
    https://git.kernel.org/bpf/bpf-next/c/ba8ea72388a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


