Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6747D8018AF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 01:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442120AbjLBAHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 19:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442030AbjLBAGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 19:06:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1221FD8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 16:05:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A28C2C433C8;
        Sat,  2 Dec 2023 00:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701475550;
        bh=bt0BN6stBYKeRTCmHTszNnfuLjPp/UVFO/XjnT3OMZE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=La5RrBfnIkmido+iMK5A0eKpSQiUw146pMX5WJJjuAe+v9zbESYLN8KZNcjg8Qobk
         Cpe0y+Nxf+WdL0O3hI+qTmRbrRRiJno5hrMfGm7P4ma782UzF+iaUL4n4UgqcwopcD
         pHra76Zh02tT3X+D3rb2wlr0CxXBwXmztdwKelcC1iPiWIsHUt9gEOGzYWJgjlmfjH
         S6PC4wTetyUxaBWDEyJTcpAjQFb0NxI+kq8Bqpn1v/tkRdFnjDtGUrZ9zTgp6fqlyO
         N01mqsx1lbfEZ4/ml2c2yQwEXdQxPdtURu/G1nIQhyHV/vyYCWXgUKJTRlcmcwLYib
         Y5L8+s9/w/wjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8FF13DFAA94;
        Sat,  2 Dec 2023 00:05:50 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.7-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZWmr2O2Lb8Pn_Hhc@8bytes.org>
References: <ZWmr2O2Lb8Pn_Hhc@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZWmr2O2Lb8Pn_Hhc@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.7-rc3
X-PR-Tracked-Commit-Id: c2183b3dcc9dd41b768569ea88bededa58cceebb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1a2b4185669b6318cf75ec18d13fa5f8779ac073
Message-Id: <170147555058.9445.7883700317061628146.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Dec 2023 00:05:50 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Dec 2023 10:48:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.7-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1a2b4185669b6318cf75ec18d13fa5f8779ac073

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
