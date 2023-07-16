Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BB2755628
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 22:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjGPUsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 16:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbjGPUsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 16:48:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6020EE9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 13:48:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1F0F60DFD
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 20:48:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66E2CC433C7;
        Sun, 16 Jul 2023 20:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689540482;
        bh=UxuYHOEEHMag0rikQCVYoGZ85SULksxfyG8r+xhXNSE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QX+j9vC4Jym5zA0bvI6WSxaDZFPtnN+93C/y0YrPaqcg+7RWgcobWdeGrdB/C2k06
         TN2UAiBuySynoV8R14hAaSogIJqIrm0y0Mp5l7DAE7EmPaOaq8ovoOt7pKT1qAWKLE
         p9LqiU3swhyStRGCPqurQDPLoVFoK4XGzVlXGlbOrt82jyBi9+EbfgIGqUuQFHQOFg
         yLK1LgbK2dW9dytqaDexzNmpDEbFaAZAQdA48+d+mj/k8th+HZV3LE9G9ZNebpU8nV
         XZnQQEXqAM3nailE4YtfLyGLqA2i+GPQIJOcAAM0OApzYVVkiSAuPHLyQUzihGsrd+
         djhxFYDgGPGBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 52FA8C40C5E;
        Sun, 16 Jul 2023 20:48:02 +0000 (UTC)
Subject: Re: [GIT PULL] sched/urgent for v6.5-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230716183726.GEZLQ45tOt9L548BJ4@fat_crate.local>
References: <20230716183726.GEZLQ45tOt9L548BJ4@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230716183726.GEZLQ45tOt9L548BJ4@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v6.5_rc2
X-PR-Tracked-Commit-Id: aff037078ecaecf34a7c2afab1341815f90fba5e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f61a89ca1182c43aa7a141c40f4063be81bd2562
Message-Id: <168954048233.28685.3040924643533281272.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Jul 2023 20:48:02 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 16 Jul 2023 20:37:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v6.5_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f61a89ca1182c43aa7a141c40f4063be81bd2562

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
