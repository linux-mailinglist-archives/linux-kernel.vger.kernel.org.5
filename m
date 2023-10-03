Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9637B71C2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240881AbjJCTcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240869AbjJCTco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:32:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7468B9E
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 12:32:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E9B6C433C7;
        Tue,  3 Oct 2023 19:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696361559;
        bh=XHLdbgXKtXlG7pXUwp8D5+lcxiFxMFs31MXIDcdZH9k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Agh0/LJKox65NEjV6DCJb691fFutTK2RvSElP0iyNIJ1hZhbI/7Tp7rTa38b8znA6
         npcE+dY7PSUfwoHo/PxoI3e29XCET5YXOUYSUZUVthrztOgb6zhpiv41qpuWKg4eyH
         QjKg2qBPD/XtAT07Cz1xfVZLWj8wES89qG5TomVkg5oQJNxGNmDu2plr4kcdG/Sb6q
         W3a3awuxGcOntDzsNB7clqhmg9iRgKfbbk4YcDbIXijukycfENzmGzMuqUBG7aBe+A
         Q7cW0oVhqKFwkj+0XLeGYe6PccxSqyjrfOLN5q/9/GElSRF7MnVutqIkgGOZgWiO+7
         bI/XccmJFw+Uw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01802E632D0;
        Tue,  3 Oct 2023 19:32:39 +0000 (UTC)
Subject: Re: [GIT PULL] regmap fixes for v6.6-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231003180355.3F592C433C7@smtp.kernel.org>
References: <20231003180355.3F592C433C7@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231003180355.3F592C433C7@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.6-rc4
X-PR-Tracked-Commit-Id: 7a795ac8d49e2433e1b97caf5e99129daf8e1b08
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cdcb5d194f192ed07f4e4bb85b866cdc8f420ee6
Message-Id: <169636155899.2158.9430570187678048741.pr-tracker-bot@kernel.org>
Date:   Tue, 03 Oct 2023 19:32:38 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 03 Oct 2023 19:03:47 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v6.6-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cdcb5d194f192ed07f4e4bb85b866cdc8f420ee6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
