Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1436C8092B3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjLGUrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbjLGUqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:46:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95321995
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 12:46:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DE1DC433C9;
        Thu,  7 Dec 2023 20:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701982015;
        bh=huiJO6F6nRuXA02F9eMS4nZvs8KvMmyXId3I5/P/bfo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OzF2Fid0TXx/hs9RkG87aDX76EySV+f9lUclly3kVFPeXrTCaDU3ygZMzk2kEAZP9
         IOfQQm5rFfhafrEvhnS8fDVzqMoj33su8u//RPGgK8/O8lGj7Uja1gNTTOgp21mSlk
         tB3aV7wkkIVMZSsayby+9f/tEgAMQS04Qqx0fMAiQ0gR4vCcRDIZ3HHNUKhy9uuIwU
         /SbxLTNhdb+brOPnNz4OXX9GAR7e6uxexpdkVjeDrY3Mq4Fl/mDzanYOeOP2LWdYzk
         kRR0mK0CeaBYsy8AKgibOdUrh4ztS7Gip6UONXeDRL2L/d3fIuukKlCQNlVx78Z/ku
         2MtxfBW+SjZvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72F5BC43170;
        Thu,  7 Dec 2023 20:46:55 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup fixes for v6.7-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZXDNMJbgFHMiKkO_@slm.duckdns.org>
References: <ZXDNMJbgFHMiKkO_@slm.duckdns.org>
X-PR-Tracked-List-Id: <cgroups.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZXDNMJbgFHMiKkO_@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.7-rc4-fixes
X-PR-Tracked-Commit-Id: cff5f49d433fcd0063c8be7dd08fa5bf190c6c37
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ace34a8e446c1a566f3b0a3e0c4c483987e39a6
Message-Id: <170198201546.1554.188470260825773393.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Dec 2023 20:46:55 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 6 Dec 2023 09:36:16 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.7-rc4-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ace34a8e446c1a566f3b0a3e0c4c483987e39a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
