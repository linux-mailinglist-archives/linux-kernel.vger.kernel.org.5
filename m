Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A237E7DC366
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 01:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjJ3Xua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 19:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236017AbjJ3XuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 19:50:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103B1100
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 16:50:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6A16C116B5;
        Mon, 30 Oct 2023 23:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698709807;
        bh=p8hCjLsr35hCJB6RiZHECCDFwiXeNaaIpuV8oQ5J7mE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ugngxXPUr4RNC9hj4Ou/W+SdgMtThvmOPQ+Kwm+sXSi/LaTJ4ObqLy8P7FpP/Itih
         QnakoGNjhR9bLuLBAWaFVtUMNSwc8gH3EV9cj6zo8omTduWAzTHrRGY08qX2TtujFm
         PKPqIMtBndceOy5sCxVvQGL5Xh52HAfcTO/kwf01j9X7t9Dvz1hYmunkzx1MRqUe9S
         FYTKgcRUvNfSTPlrTuNV5u9d6bNvF6s9U4udZDkot2Zxf0mjpQFrc39OIVz2mDwwfD
         O4g9kpbwh66xKT4SyrzBhoriDpCf9fUQ0DPQaZ6mRILSo3l1DH60LHPKm4MUh9ZGcc
         gqxrcwBvm4+oQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BF767EAB08C;
        Mon, 30 Oct 2023 23:50:07 +0000 (UTC)
Subject: Re: [GIT PULL] x86/platform for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231027171846.GPZTvw9k7KBkOXXONF@fat_crate.local>
References: <20231027171846.GPZTvw9k7KBkOXXONF@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231027171846.GPZTvw9k7KBkOXXONF@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_platform_for_6.7_rc1
X-PR-Tracked-Commit-Id: 2a565258b3f4bbdc7a3c09cd02082cb286a7bffc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f155f3b3ed1af23884ffaffe8a669722b87ac9d6
Message-Id: <169870980777.17163.4950533099454980594.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Oct 2023 23:50:07 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Oct 2023 19:18:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_platform_for_6.7_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f155f3b3ed1af23884ffaffe8a669722b87ac9d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
