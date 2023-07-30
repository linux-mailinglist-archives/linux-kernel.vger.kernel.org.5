Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032B97687ED
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 22:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjG3U2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 16:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjG3U2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 16:28:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBF6E78
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 13:28:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F1AF60D30
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 20:28:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F17FC433CA;
        Sun, 30 Jul 2023 20:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690748885;
        bh=DeeAJuGk4eO0Nxe+moAuu4/R5osK+jfZT8FSkwwc11g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=F6S+m2gsHhEHSBHCEHrcL2AGvFMDGJIFK4WovAS8Xb46MTCYwceKDjpu2g4SZ4Aml
         0AhiWfV4OGpIe1xlWTSEiT7Okt101oh15h0uB/t0DIoxsy+WNnS/OUu6kHY78zhDrH
         n03B15kVNcIYFUWxspXpBg4IpPJrDB9eXPb7ThxPlg+QeQvM4ivpXQFDlJgnjPiS+/
         Gfbm/B442q1CKu/XDaB3dL/y9q8OkW8g0YemMiPr5Ejr9EW5HhAsjuDCZWwfzHbkSD
         zINPQZLlkZWVaFPEPW4uIRYBuKuk0EyfTbq0k/OtQZqh7rU1sxYbMfP2mSJrjUEN9O
         8T331vbuh6Row==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7A4D4C43169;
        Sun, 30 Jul 2023 20:28:05 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.5-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <56c33730faf0170df5a64351dcc4fb63.broonie@kernel.org>
References: <56c33730faf0170df5a64351dcc4fb63.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <56c33730faf0170df5a64351dcc4fb63.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.5-rc3
X-PR-Tracked-Commit-Id: 67cb608838e0aac8efb48828b1165156f99c1af9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3dfe6886f96969c46afc42f9ba2791103b7b47c0
Message-Id: <169074888549.12703.10059594032658366042.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Jul 2023 20:28:05 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 30 Jul 2023 16:58:12 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.5-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3dfe6886f96969c46afc42f9ba2791103b7b47c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
