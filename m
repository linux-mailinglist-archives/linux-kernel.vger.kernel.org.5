Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DC17EE10F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345194AbjKPNHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345022AbjKPNHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:07:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F9F11D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 05:06:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C153FC433C9;
        Thu, 16 Nov 2023 13:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700140018;
        bh=+22+/jE0pQQI30EI1P0oDbwnv2LjVE6mj8Acc/SkOAI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=leI6U/9QdOhRBNiweyhhw/zl8eOkUvoGajn5JusR0Qww/nFOXIJXWElUL0eEYgvpr
         arc+/6jyWUk3rKa2EeiidnZRS+UHBNjXJByF3WdxDSYfKcsuBR1k/2iLpP5EafzqQb
         Msn1U92RkF09w5Y20qnrVRGUp+cMmZzUkohMtqGHecLeGg3LFjnfU04U5nLAhT8U7g
         gJ0FZjlojbF6BmSAQHic0X0yPNMsyVBuXWjNWr/BAByXl43hvHTubvy2kYAolGONY1
         0ZS/+cIz7FWVyhW6ebD4zGa+ce+7mKkkde2v3XOUUn2rQa/6mquKl+1SuR0bwg5b47
         NvP+rUrI6S05g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A427DC4166E;
        Thu, 16 Nov 2023 13:06:58 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.7-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231116114241.26403-1-jgross@suse.com>
References: <20231116114241.26403-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231116114241.26403-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.7a-rc2-tag
X-PR-Tracked-Commit-Id: cee96422e863f0b0e9d3d0c2d617271ef2255858
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6eb1acd9766a0dc9d85927843d85787408395e15
Message-Id: <170014001866.19711.14089555975336471922.pr-tracker-bot@kernel.org>
Date:   Thu, 16 Nov 2023 13:06:58 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, sstabellini@kernel.org
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 Nov 2023 12:42:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.7a-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6eb1acd9766a0dc9d85927843d85787408395e15

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
