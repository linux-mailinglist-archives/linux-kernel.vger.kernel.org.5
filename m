Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE608770C9B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 02:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjHEAQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 20:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjHEAQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 20:16:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D0A4ED3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 17:16:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 741C66217E
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 00:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5BB6C433C8;
        Sat,  5 Aug 2023 00:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691194609;
        bh=aEPyFtSwblvMrG3VREd43uS1cyWQ9xPMSGoReRh1T6g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Y4R8b0Gk9+8IXVGcEJFlZBYfUn/722cSNp8B9LBYbwgAYCO7W6KlmCO05ph+lf64s
         J3KUvstVrlRF9l3APq5GlSjcBB/TL0+GQhB+MZpkj/LibTOYnJTCeZLwFww5ne+VNR
         OW03F+IzuKUSNO61/0xjG6an7u+e9G4V3PKStDgwpXbMsu+0rVu7S4Hpai9URgCjaB
         NP7UXsHQKpmofUOS068S3iVsBjYDGjA5YGHJ8Ij2NcCFTR9Uj3Yi6sHTRwSdj/7vcW
         0Zanalspu90n1jmIxCkQZgrVsCgCudZ3oFoMdPuX3GDwyeXe1frsbewJ/nsCDl0L2f
         YY5fYwi7ISj+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C221EC395F3;
        Sat,  5 Aug 2023 00:16:49 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.5-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-69f4a2f3-c179-411e-a85e-683bb3e088f3@palmer-ri-x1c9>
References: <mhng-69f4a2f3-c179-411e-a85e-683bb3e088f3@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-69f4a2f3-c179-411e-a85e-683bb3e088f3@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.5-rc5
X-PR-Tracked-Commit-Id: 640c503d7dbd7d34a62099c933f4db0ed77ccbec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e661f98c82832ddb76423f57dffb4ba6256e0fc6
Message-Id: <169119460978.16730.3438114313213071180.pr-tracker-bot@kernel.org>
Date:   Sat, 05 Aug 2023 00:16:49 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 04 Aug 2023 14:38:52 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.5-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e661f98c82832ddb76423f57dffb4ba6256e0fc6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
