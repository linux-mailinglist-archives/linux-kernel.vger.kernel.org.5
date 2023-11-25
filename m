Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8184A7F8CA7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 18:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjKYRNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 12:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjKYRNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 12:13:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A20106
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 09:13:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1A90C433C8;
        Sat, 25 Nov 2023 17:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700932393;
        bh=W0F/lRbpZj2Yy5ZtrfTRl4NAOBt7IGaRShsMv19f7A4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eown95AF5iXiVU5DzcxsHte5XXmyGDs2qI4t3kXE/SF7xlCfia5STArF/YIwaLQ+3
         ztDewWDLjZMMybm0L+RGXURn+eEg2QdrIFiX33uzo9nT+ALZ+Vf/+nlRWmcltotGGm
         UDnWY26QTSvRRLWC1ubLjsTCTNa92eHy+QGdhYSPqObM0fdgh+ak5YqW/lDtHG9W94
         imXkc/NxEAd29gpXA20g8jAWalOD9OSe6kj5FwmH2BI/TWkfPrNTIuJ7BpYHv5jQVx
         iipinUh04FcctLcptCcYYRPK24cyqayehl+5AXT+E2WDzMCM+ZdBe1X5NPTskhag/h
         0LvaFelKR4UAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1926EAA958;
        Sat, 25 Nov 2023 17:13:13 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.7-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231125092205.8378-1-jgross@suse.com>
References: <20231125092205.8378-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231125092205.8378-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.7a-rc3-tag
X-PR-Tracked-Commit-Id: 7bf9a6b46549852a37e6d07e52c601c3c706b562
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 00cff7b29b1dbc4ff48ae9278eb1aa4dc0bfad6a
Message-Id: <170093239378.710.7580413467376806013.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Nov 2023 17:13:13 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, sstabellini@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 25 Nov 2023 10:22:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.7a-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/00cff7b29b1dbc4ff48ae9278eb1aa4dc0bfad6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
