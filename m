Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00B77A0C9E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240693AbjINSUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjINSUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:20:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83421FD5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 11:20:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 454ECC433CB;
        Thu, 14 Sep 2023 18:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694715627;
        bh=aHat3lPagD1lJh2u5n1uXfTagE3HjmSAph/K1MeerU0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GoLhDexlEqVljRk0RGkc/Abft+Fkrqer+PJq2pBEQg16CrfH5pkLUrqic2VR6LM8v
         wqc0mFrv0YawfLxyeE/HBktVEpkE43dM3fIDuPT26WW+yfgKemlrqDlX8uUJGE426Q
         TlEiv1SnqIBetmLnQ/QsGQYFBtgW4lf4IahU+DcR3zIF3K2NJfMeZuqyJPWEWL62vP
         aptAVYvrAySA210ZygC4Fz23tkDcumQPU9jOdc79nW8XtMkew57cfQCqLLqknObcS8
         3bKBjDpMMQuYzG/sXialD9bI9xyqsrzE1XgmiQn8UzVls4FX77tekjPrPlAfZcDuwG
         axcbimpVIa6zg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B1A4E1C28E;
        Thu, 14 Sep 2023 18:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: skip module_fentry_shadow test when
 bpf_testmod is not available
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169471562717.30611.2026366361358349772.git-patchwork-notify@kernel.org>
Date:   Thu, 14 Sep 2023 18:20:27 +0000
References: <20230914124928.340701-1-asavkov@redhat.com>
In-Reply-To: <20230914124928.340701-1-asavkov@redhat.com>
To:     Artem Savkov <asavkov@redhat.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, netdev@vger.kernel.org, vmalik@redhat.com,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 14 Sep 2023 14:49:28 +0200 you wrote:
> This test relies on bpf_testmod, so skip it if the module is not available.
> 
> Fixes: aa3d65de4b900 ("bpf/selftests: Test fentry attachment to shadowed functions")
> Signed-off-by: Artem Savkov <asavkov@redhat.com>
> ---
>  .../testing/selftests/bpf/prog_tests/module_fentry_shadow.c  | 5 +++++
>  1 file changed, 5 insertions(+)

Here is the summary with links:
  - [bpf-next] selftests/bpf: skip module_fentry_shadow test when bpf_testmod is not available
    https://git.kernel.org/bpf/bpf-next/c/971f7c32147f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


