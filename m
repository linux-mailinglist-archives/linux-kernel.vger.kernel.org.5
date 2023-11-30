Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF947FEDAB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345109AbjK3LUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345038AbjK3LUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:20:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F316ED7F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:20:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A053C433C9;
        Thu, 30 Nov 2023 11:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701343225;
        bh=/k59YdZdJ2hdOuoQu4L/tQFt5BKzGrYlSi+Wg+rmzCk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ELtgMrespBXfJU9ocDIohT95Wq02wdfbHTFE+XaC5B0hUSXbHDf399p/NWFoC4yUA
         lI4lFZs+1CZhf122vh8fvO4tr+xFjVjB4s2K6ZU04Cxv9OHEXPkuF3Am96hgArlhhO
         R225iNKVIEKpvYgmuYkgOXRHsxR7NJmU07sd3ldGWCUSrpx7y7SWLJopOG03PPMurv
         ZcuBCIhW5NqZF93OKr87VsQ34O3KwmgXSkbqGWD3z1nmszL5Y91+FzuSRSdS38Tqag
         7ZpqzcGlG/Ib7DTUW4N6NN0irvgcue3NQxHcM2kXvh3t8OuAf3a2WPrySJ2eAOj9k1
         gSLK5gYVMutUg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6DBD0C64459;
        Thu, 30 Nov 2023 11:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf/tests: Remove duplicate JSGT tests
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170134322544.30094.8628031237009156633.git-patchwork-notify@kernel.org>
Date:   Thu, 30 Nov 2023 11:20:25 +0000
References: <20231130034018.2144963-1-yujie.liu@intel.com>
In-Reply-To: <20231130034018.2144963-1-yujie.liu@intel.com>
To:     Yujie Liu <yujie.liu@intel.com>
Cc:     ast@kernel.org, daniel@iogearbox.net,
        johan.almbladh@anyfinetworks.com, bpf@vger.kernel.org,
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
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 30 Nov 2023 11:40:18 +0800 you wrote:
> It seems unnecessary that JSGT is tested twice (one before JSGE and one
> after JSGE) since others are tested only once. Remove the duplicate JSGT
> tests.
> 
> Fixes: 0bbaa02b4816 ("bpf/tests: Add tests to check source register zero-extension")
> Signed-off-by: Yujie Liu <yujie.liu@intel.com>
> 
> [...]

Here is the summary with links:
  - bpf/tests: Remove duplicate JSGT tests
    https://git.kernel.org/bpf/bpf-next/c/f690ff9122d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


