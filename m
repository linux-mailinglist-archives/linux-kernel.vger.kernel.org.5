Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7B47B0ADC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 19:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjI0RKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 13:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjI0RKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:10:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F495F5;
        Wed, 27 Sep 2023 10:10:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89CA5C433CA;
        Wed, 27 Sep 2023 17:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695834643;
        bh=DrV4cbHfS4bkdLAFnjPWF3LXhNWRjDb00qevr476PgY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=U9Zi+kViS4hxWHGJaswEjnWSFfVAQSYQPUB1EuwseWEXeZnGy6wxYz3ggEfpveitn
         kgPvLhJXXqXTi641yW14QZXXWF4ts8sHRPte5qY7GeHU1IJEGF/3WtEGEzKD6kLvuf
         +mG0AW/5ky21KVKiZUF25+xiEqrKu8rl3SdMo1WJkhX06cD8zGhr+s9D5vFo/OBeV8
         ca7JFJ2Tv/YIdB+dH5ODy47wXKaSjn9lEjwo+fd9u1DoXEhwWfO2ftPwvom/OA+Ib7
         XKhQFtiv4gQt0INCZPhwecLBtYjJl8x7lpZ9/Mc6mTiiCYWEy0GYPPwXBhLKDq4o6z
         Ubk4x3YhN7+aw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7241AC395C5;
        Wed, 27 Sep 2023 17:10:43 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.6-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <003149d84048d4fbf26eac75237bc67e188c5f84.camel@HansenPartnership.com>
References: <003149d84048d4fbf26eac75237bc67e188c5f84.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <003149d84048d4fbf26eac75237bc67e188c5f84.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 2132df16f53b4f01ab25f5d404f36a22244ae342
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 633b47cb009d09dc8f4ba9cdb3a0ca138809c7c7
Message-Id: <169583464346.26255.3508586959480348034.pr-tracker-bot@kernel.org>
Date:   Wed, 27 Sep 2023 17:10:43 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 27 Sep 2023 08:42:35 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/633b47cb009d09dc8f4ba9cdb3a0ca138809c7c7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
