Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8DB7A8988
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 18:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbjITQdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 12:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbjITQdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:33:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36909F;
        Wed, 20 Sep 2023 09:33:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AF13C433C8;
        Wed, 20 Sep 2023 16:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695227624;
        bh=FwvmuamO23G73LfRVMvJONIw2MZmlL7TBT9Wo7EP59g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GxCTmNWO2wU3HxwlQGSqBncWd0tHUAY/443LimzGmw0Gvpw7a/woSIHNU2B9WTUNP
         JGep5BTupxhSg2opn4RyqTXQlvF/J5e9r/42m1Xpb8DuEhgtkN4L6mG8AxWSCZlsbu
         87A8Akc6DE1fd1y4MASij//yI5gVoK9FEJ318n1owe5sJrR+4XZwdrjX2s+b+4M58w
         GudQ9MYWBc/gtHnOUo8FM/MhaiK1C2dWOVYEv++VmhBj9lqHTnAIHM/Q5XKY9BaVvB
         WwUHMg2/ydmK9kiINM6c5eAGXYt9U85ROwfoC8+EIjp2VcqgzPz+OHZv11IOHn370n
         y8gOykOCKIRuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 403F1C43170;
        Wed, 20 Sep 2023 16:33:44 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.6-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230920125749.F344DC433C8@smtp.kernel.org>
References: <20230920125749.F344DC433C8@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230920125749.F344DC433C8@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.6-rc2
X-PR-Tracked-Commit-Id: 4221a2bec2189275f3f49492a73221498ae6d131
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d2f53532ecc6ff063bc0dc1826fdadcbd8878a6
Message-Id: <169522762425.14251.4914641069369470255.pr-tracker-bot@kernel.org>
Date:   Wed, 20 Sep 2023 16:33:44 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 20 Sep 2023 13:57:40 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.6-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d2f53532ecc6ff063bc0dc1826fdadcbd8878a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
