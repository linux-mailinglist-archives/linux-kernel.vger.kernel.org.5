Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2C37E0D3D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 03:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345545AbjKDCKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 22:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbjKDCK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 22:10:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD0ED62
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 19:10:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BF82C43391;
        Sat,  4 Nov 2023 02:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699063826;
        bh=Ds+SV2iGNavCSdCZwv1k3Ou8fZ2Dzxb9V25vnu0I6JU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rhj4lHOZYit/ofkgRRAWKkco8KFNb7MYAFbO2vQVhMDQKFw030HGJAQVESWvviqKo
         Zm4LFU+FAMAx8GkN9vQbA+Wp9KCWLpjqE1EOFCiMrWQ0W1sjBqkkowVSowE0P2g9b4
         LEDlTgPLanAUZzSa5Idh1CCTlebacMXdsNf8w6t0iiw2fBAzFyGIXns7yRhxFq7haq
         YkjD8DfV17baKSbMk4OBosFmiintxXZ84mL0ACumF8bXwp1B6w5sgeIHUSs5RiMRhA
         i45GpLAoZPhxOdGOf9BpJVHYzkvhA6EVF24YEJ+6MHTUJRtBl6S6c5uLgOxYoNZ0my
         gtJch5+5ek/Fw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 474C6C04DD9;
        Sat,  4 Nov 2023 02:10:26 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver updates for 6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZUTiKqLbWEPTVZCf@kroah.com>
References: <ZUTiKqLbWEPTVZCf@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZUTiKqLbWEPTVZCf@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.7-rc1
X-PR-Tracked-Commit-Id: a4000df5300fdbe10d84e3b70e2d6a98686310a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4c7a0c95adc3ed8cc5e4c2187521aea3e40ba1aa
Message-Id: <169906382628.26291.3454184896525324299.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Nov 2023 02:10:26 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Nov 2023 13:06:02 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4c7a0c95adc3ed8cc5e4c2187521aea3e40ba1aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
