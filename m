Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61607A8989
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 18:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbjITQdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 12:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbjITQdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:33:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A256C6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 09:33:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9E9FC433C7;
        Wed, 20 Sep 2023 16:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695227625;
        bh=MY/6CpAwIh/yQeRl07vdaOFlKuHuSFtsVNhD11kzB4s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=r7d54mVXXOUjcM9jwGp79hoROUM81hQDTMHzHPOgAO0dVhC/4mx7G6vKAC30R+PQk
         VHLydgScuBDI2JhO8/3lo0yjO5islQxkoaGZeJ9lt2e0TJIPy6rG9VL6zHM29+eGNV
         HJRI7aCVCIkmobuV+fXHX/2VQK9kSj1JjdAeR3jnQXb2wDwg4eg3pu6t5KmGCykIoI
         OXfk6FBI4jdsNPLKs8Z+LDbZpfsHVwyQPbm/JKPrbmDId1MMuEmheShxtjlWIZ1t+b
         IRqij6LSEyvd23ZTEpfuhlcGqnUnsUZbbaztgS2MBBmKza3w6l+DndBdV/aFc0ar7n
         mX3dBtwxqBsNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A4620C4166E;
        Wed, 20 Sep 2023 16:33:45 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.6-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230920125733.92A0AC433C8@smtp.kernel.org>
References: <20230920125733.92A0AC433C8@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230920125733.92A0AC433C8@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.6-rc2
X-PR-Tracked-Commit-Id: 6223e073db78458f8846c380ccd224a7a73a3867
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c0a21da7a1c648c327cf7cdf16feceb087892e6
Message-Id: <169522762566.14251.10549442954755768823.pr-tracker-bot@kernel.org>
Date:   Wed, 20 Sep 2023 16:33:45 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 20 Sep 2023 13:57:26 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.6-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c0a21da7a1c648c327cf7cdf16feceb087892e6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
