Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C14799A7E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 20:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241546AbjIISx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 14:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241437AbjIISxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 14:53:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A55CDE
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 11:53:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A36B7C433C7;
        Sat,  9 Sep 2023 18:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694285629;
        bh=Ax8ku1+sKtnHxhf6TegzEZhjd+UwWrBGuijWgWoHV64=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YdiMHWkov8pXZIunGEO+MDgV5nJ8e9VfRMSU31yWlyVcYrK3yxtD7hL9hn21sVAMa
         iwpv6EmFHSRizHHG/wGxMA0HQ62OKuZhINr1h/R4YzQHwcoDIaZLQUjPnKZbUQ8jdX
         zAHNkQivP9uOsOBatSElgKtk5vOvoJz5qK3Uk9Ttu8fCQR3jdltmjZOZXUVxvqGWC1
         o3L8Pu2Vu+bBdDAn+zdxy/SURHbtvnNTczcFgP1wMrCZXPWw+Zg3ErTKI4Skd/jIK4
         Fx8akMe+G1W1CF+KZIrHriPU0TpVGZ5gyW3oRUcRhUKxvHqWMDEcMSKbL6sjlgZDRP
         c4/eXSwMoCTLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E311E22AFC;
        Sat,  9 Sep 2023 18:53:49 +0000 (UTC)
Subject: Re: [GIT PULL] Driver symbol lookup fix for 6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZPwndquCWHIicVzt@kroah.com>
References: <ZPwndquCWHIicVzt@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZPwndquCWHIicVzt@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.6-rc1-2
X-PR-Tracked-Commit-Id: 86495af1171e1feec79faa9b64c05c89f46e41d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6b41fb277ed41a73608328431f2e76e68c3bca37
Message-Id: <169428562957.13340.10418004092164122048.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Sep 2023 18:53:49 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 9 Sep 2023 09:06:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.6-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6b41fb277ed41a73608328431f2e76e68c3bca37

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
