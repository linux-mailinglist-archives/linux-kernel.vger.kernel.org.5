Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051737BBB89
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjJFPPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbjJFPPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:15:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4534C9F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 08:15:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5D1DC433C7;
        Fri,  6 Oct 2023 15:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696605323;
        bh=C5dzSPoBMsxodWDqnwZjkYxt0GXQKMhg7DA5R71xij0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Exyh/wjRTVc8QpRiRe6bp1jJEU/W9x8Khbp3iVgAahXj7xPJBylFptf2g3I+sJUI5
         4c9aLzSUF6985x0FolScF+PUnOozsOsk/PvaMKFYQKCIfj7ow1L6cYmNwwqc+E92Xj
         jF7qY4GF0s9Zg0yLj0djGw0MzIzFVXhc2oNrQ5h9LKk2TDGsJ8o1pNeLyjRxLSH0aO
         FdEba3K0BpevGojio30IreoQdOjJBGZtuyklvWNx/n/7Nord8wALy3X3bR7QVP1wr/
         8zMJgRfLnKpCMQ9sLBaiQoJniQx/j1usqbv2QiZ+3d+JGNXCc6nqCC8Y4XAIqzLCdk
         pPMGjZoW7K7SQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2368E632D2;
        Fri,  6 Oct 2023 15:15:23 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231006075644.GA5946@willie-the-truck>
References: <20231006075644.GA5946@willie-the-truck>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20231006075644.GA5946@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: 4785aa8028536c2be656d22c74ec1995b97056f3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d47ae2784726e9645fa5508e1f1055159a9af64
Message-Id: <169660532378.6239.1549605022702605521.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Oct 2023 15:15:23 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 6 Oct 2023 08:56:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d47ae2784726e9645fa5508e1f1055159a9af64

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
