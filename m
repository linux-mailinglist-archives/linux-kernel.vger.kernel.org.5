Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19877F01C4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 19:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjKRSCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 13:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjKRSCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 13:02:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE550AA
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 10:02:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89075C433C7;
        Sat, 18 Nov 2023 18:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700330529;
        bh=Cp3ymVXehnO5rOZTJj+Tl5Oo5KAkDDxENrgVcI2/IV4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HvdLYxxjSwV1uX/OdXfpZa+2R3ccxDQn4d2p20YnoXjcdrizbVCepdsNQP6pYBXZU
         nqIaV5h9vHTI/UJ09Aw1wo3NmEasZc1N/+dGMyBdkH+Dl5PLSjv/VdPsDQj9uQSsit
         FNXl+eAZKCG45t4i+m7aNYokMNQqSOFhkSt1qfgQuAs+h69TgcbIcnwSiFAr3SeB90
         KsK7vuiihIyY7/gt6jUrwp5c8ZzSZ5XdtkJQJnJc/rx/VcppgLxEr9RttcGrjPBoIM
         EnvMsE26/PyOnbeQXviq7JE1GczylXpzZKCnk59yiF0WSvMkSwmq/ufvlYtPfaIAQO
         LI2RJ0OrVVNBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 77C70EA6303;
        Sat, 18 Nov 2023 18:02:09 +0000 (UTC)
Subject: Re: [PULL REQUEST] i2c-for-6.7-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZVf/pqw5YcF7sldg@shikoro>
References: <ZVf/pqw5YcF7sldg@shikoro>
X-PR-Tracked-List-Id: <linux-i2c.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZVf/pqw5YcF7sldg@shikoro>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-6.7-rc2
X-PR-Tracked-Commit-Id: 382561d16854a747e6df71034da08d20d6013dfe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23dfa043f6d5ac9339607f077f2c30cd50798e12
Message-Id: <170033052948.28320.17704430633203725309.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Nov 2023 18:02:09 +0000
To:     Wolfram Sang <wsa@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andi Shyti <andi.shyti@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Nov 2023 19:04:54 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git tags/i2c-for-6.7-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23dfa043f6d5ac9339607f077f2c30cd50798e12

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
