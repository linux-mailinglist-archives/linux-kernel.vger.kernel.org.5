Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94408092B9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443927AbjLGUrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235539AbjLGUqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:46:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D57172C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 12:47:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE708C433C8;
        Thu,  7 Dec 2023 20:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701982020;
        bh=g6KuYthqoA1TjSUiC2kRlAo7mI2DOu+3XZWcfOPZeE8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=r56ZhcHIA8uJEIhNhUJvAuPeEZcSEvZr4OjNpkscbpSlNN7DSYNsTiIa16CXAZlzc
         ob2cl309+qv6I6M0dmEi7vO4vZ0PUj47VM3835TKWqQ/Z4WU9txHRFSqhgVWUehMhx
         F1rjuJMK8+SP5yHsMuZJpz1fKaoUm9XNJmvP6WBNwCLZcWNaH4kUCYWjdJ89S0mvJr
         TAFSiMIdQhOldW+epmTs3j8jNrFQg8H1icm1hESvXwGPyhcdow2ZJvciGxPOwOFs7K
         sAVEcjE3gi2cAhq+bqee4wooh6J2r5sB4OY2ikpp/zc2i6OYG6zUhjTRtP/VPkDAC2
         67aFLmC0Lxftw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8FB9C4314C;
        Thu,  7 Dec 2023 20:47:00 +0000 (UTC)
Subject: Re: [GIT PULL] regmap fixes for v6.7-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231206134339.2BFB6C433C9@smtp.kernel.org>
References: <20231206134339.2BFB6C433C9@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231206134339.2BFB6C433C9@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.7-rc4
X-PR-Tracked-Commit-Id: fea88064445a59584460f7f67d102b6e5fc1ca1d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4388ae22aeaa1cd2f74edaa5cf5a518cc5f04c56
Message-Id: <170198202075.1554.15106312003807878102.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Dec 2023 20:47:00 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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

The pull request you sent on Wed, 06 Dec 2023 13:43:29 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.7-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4388ae22aeaa1cd2f74edaa5cf5a518cc5f04c56

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
