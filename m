Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B39799B85
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 23:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344940AbjIIVyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 17:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344639AbjIIVyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 17:54:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17ED19C;
        Sat,  9 Sep 2023 14:54:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9BF2EC433C9;
        Sat,  9 Sep 2023 21:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694296481;
        bh=nyP7uqO6R+iSVichNhVA18dnJf3+qzMxpKlzslmoDG0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AMdgyYwslpNTe+TPoHmlJLyzjEcwb9Rvr/6gnO1fodX6E7zuX0NTHjzIjZli3f15e
         qpNuQC1vw05T1k4TorYrgr0KZVT6KQKXLArPJ3TJ9JUbnqGLEeFGeCVdpi/JFG1OVA
         Lp35xvl/yK8aVqythgdXh3XRRtdPKk0phGs7BjtDsmb1FsFvh6vkyOiqDJvJ2va5rF
         TW0rSPbWelnhkLjZNdaf9J8zOkd64ZcEO9FbdNaSiPQu3LqctvW2V0oaHJilTrpfE+
         UBbwJREWIMEmLM05kKS+KZ9ijwfGZfiXijF5zlMuqcWVhIcazgqKXzPThd7U1DlSZx
         pVPz46m1BF2Yg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 895BCE22AFC;
        Sat,  9 Sep 2023 21:54:41 +0000 (UTC)
Subject: Re: [GIT PULL] sh updates for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <86e6baa7dc92b42440c1e07332c876530306eaa3.camel@physik.fu-berlin.de>
References: <86e6baa7dc92b42440c1e07332c876530306eaa3.camel@physik.fu-berlin.de>
X-PR-Tracked-List-Id: <linux-sh.vger.kernel.org>
X-PR-Tracked-Message-Id: <86e6baa7dc92b42440c1e07332c876530306eaa3.camel@physik.fu-berlin.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v6.6-tag1
X-PR-Tracked-Commit-Id: 246f80a0b17f8f582b2c0996db02998239057c65
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6b8bb5b8d9b35fb43f0dbf9fd91b7d35e6232e08
Message-Id: <169429648155.7760.11555251210149278120.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Sep 2023 21:54:41 +0000
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Duoming Zhou <duoming@zju.edu.cn>,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 09 Sep 2023 22:29:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v6.6-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6b8bb5b8d9b35fb43f0dbf9fd91b7d35e6232e08

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
