Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8915280B8FC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 06:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjLJFaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 00:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjLJFaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 00:30:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D866BF3
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 21:30:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54083C433C9;
        Sun, 10 Dec 2023 05:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702186223;
        bh=1UoYqhVsIOO+xKsV2z9mjZ0OK6SVw+LuzpHTU5ab7mE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ocvynBAdIestMiZv+RQ2esNxDPqf1zXZxNDJBN5MaOJMgYr/6NcntNfmuBnha9PqR
         zbgxF+3KLQz/Ms/FB+loNgkLP7ohx+rGwigX3vH0DbkP7ZEw6RsNsaXnxNkFFVMAXt
         bhkQXqt4GOlzn7oaUOyjpifgxcAUZCf8S+bn2isFNuBP4z/UcDilCvNnCsGEl1yO99
         tKSw9EvBfe4+0qzb+kICm0cYqv67r9hAv/s+f2urJ/qcgebHAWQVa33yGj9KxZlsiS
         xVXBSTDqBHtBZBA9oxuscly+bryhJojpf2X/TFrhVBr2ZFGJ8K9DQIDgbw3l+oa5pB
         6zYMOeGPBXhTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 39B0FDD4F1D;
        Sun, 10 Dec 2023 05:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND bpf-next v1] test_bpf: Rename second ALU64_SMOD_X to
 ALU64_SMOD_K
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170218622323.12725.6922514276385110557.git-patchwork-notify@kernel.org>
Date:   Sun, 10 Dec 2023 05:30:23 +0000
References: <20231207040851.19730-1-yangtiezhu@loongson.cn>
In-Reply-To: <20231207040851.19730-1-yangtiezhu@loongson.cn>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        puranjay12@gmail.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
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
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  7 Dec 2023 12:08:51 +0800 you wrote:
> Currently, there are two test cases with same name
> "ALU64_SMOD_X: -7 % 2 = -1", the first one is right,
> the second one should be ALU64_SMOD_K because its
> code is BPF_ALU64 | BPF_MOD | BPF_K.
> 
> Before:
> test_bpf: #170 ALU64_SMOD_X: -7 % 2 = -1 jited:1 4 PASS
> test_bpf: #171 ALU64_SMOD_X: -7 % 2 = -1 jited:1 4 PASS
> 
> [...]

Here is the summary with links:
  - [RESEND,bpf-next,v1] test_bpf: Rename second ALU64_SMOD_X to ALU64_SMOD_K
    https://git.kernel.org/bpf/bpf-next/c/5181dc08f795

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


