Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC24280F517
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377046AbjLLSAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbjLLSAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:00:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8F083
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:00:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B6AAC433CA;
        Tue, 12 Dec 2023 18:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702404024;
        bh=SpCebh687Pyl6eMDOcw1Dmo4Z0AZLPicZLgLUQLeP5g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lNnjgGnRTdDboO8hZNZDRPa1LHQIuJBABmQT2au7l97o2wY/+Vc/sxFEtzYeKBCIC
         D7OwOcJE8VcIimt4FnKiVt5PYKveKKnPpTV/vBWcSZsbl9QKIHKoyQ9vXfNHl5pcDd
         Fnfycma/w2fpPiYm4kpavLFoo/9CxLuhfn/UggIHtF4pH4s1Q4yazB26k7COzAVw5m
         bSxeWesOLAIcVxVJtA4j9kUArPLDcv0tPMsYp6dv+51fDC4tS4bvZHPU+ietYhEc6m
         dINoxXKBW2GXkGvyTvxoSzkS+gH5dCfl776KNL7SjJ71I3aVGqu4dCMnuYZDkiAc7X
         T3Jg6Fm2IuaEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 108BBDD4F01;
        Tue, 12 Dec 2023 18:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] bpf: remove unused function
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170240402406.18804.9321914425985610627.git-patchwork-notify@kernel.org>
Date:   Tue, 12 Dec 2023 18:00:24 +0000
References: <20231212005436.103829-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20231212005436.103829-1-yang.lee@linux.alibaba.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, kpsingh@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        abaci@linux.alibaba.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 12 Dec 2023 08:54:36 +0800 you wrote:
> The function are defined in the verifier.c file, but not called
> elsewhere, so delete the unused function.
> 
> kernel/bpf/verifier.c:3448:20: warning: unused function 'bt_set_slot'
> kernel/bpf/verifier.c:3453:20: warning: unused function 'bt_clear_slot'
> kernel/bpf/verifier.c:3488:20: warning: unused function 'bt_is_slot_set'
> 
> [...]

Here is the summary with links:
  - [-next] bpf: remove unused function
    https://git.kernel.org/bpf/bpf-next/c/56c26d5ad86d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


