Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1277DDBAE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 04:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbjKADuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 23:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbjKADuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 23:50:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC4CED
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 20:50:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7900CC433CD;
        Wed,  1 Nov 2023 03:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698810611;
        bh=CIhQHLyOjT/Yn0ZMiNwV/Zi7muZWsUwhgOzw5VhnVBI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=vQedUSwhI5i+R0x/7gccksiWJ++Whj6BjstXrf8mBs9NEIQTJHuvfpRUxmBckWAYC
         6nzUlS4lm7VVj6hd5nc/CYSZ50WYkVEzalTok3PFz2cFRlTGi9xBxVAt2mqEhTQi6Z
         zZ3cho3Y8ZhFkhwIcnJHkqEZ2ku+JlfIlq7ndmCIMM5rqqT6xP7nWvStYbZHYsNo/y
         dQzGQmrTFn2nFoTMJ8lIZg5gT0C775oM3of/HQzDTLWLDYbL/hOSg+WEhBo+7dC7QX
         8HFqTg8dgzZV3m2/1yRJw2gYf/441JvXXhgs/zrtcsyOU7KTXfn73fiIrLPvWYgkcs
         OzrXneoFvKQbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 613A2C395E3;
        Wed,  1 Nov 2023 03:50:11 +0000 (UTC)
Subject: Re: [GIT PULL] regulator updates for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231030133419.EADAEC433C9@smtp.kernel.org>
References: <20231030133419.EADAEC433C9@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231030133419.EADAEC433C9@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.7
X-PR-Tracked-Commit-Id: 3e0569ff812675e896cbdcbbaec10c99b544b947
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d6c80f8054f75326939b947185ec47ba3755d42
Message-Id: <169881061139.15630.16185259718178779182.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Nov 2023 03:50:11 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Oct 2023 13:34:10 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d6c80f8054f75326939b947185ec47ba3755d42

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
