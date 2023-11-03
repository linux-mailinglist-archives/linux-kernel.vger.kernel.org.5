Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F006E7E09B2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 20:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjKCTxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 15:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378007AbjKCTx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 15:53:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1B3D53
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 12:53:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9889C433C8;
        Fri,  3 Nov 2023 19:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699041206;
        bh=UBtYjEjxkKNO72SVLpcqrHR1PFbxMty7li5i6Z5KTu0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XhTAP0uLM1DElz2mmZLmTyRi3sjXuhhN4jbgR4CzL2D4yemzScieu3TO1BhemCHA/
         uNJsDmhAjdH/M87aDq84QBYU4wxD5bOJqmn0ZmD5hLWTyCxFPMnJYjsdPgTHQ6bg59
         y0nwYPj5GseQhMcduMUSSHC9cJD5zlL6PBR9Y7l/2QJAiSUJ8jgK3Svxn5qw7keAax
         lbg8bjPno2k6aY6cuMY+k3OW2LwQIUn0yVSsgjJzJSuhsZKA3wsFzp0yPC3Ya2kf+g
         YlhgvF1RGgp31lnkVU0WeRgakc2VEwkh5hOfkNLpVgC+WYxRp3dUADzLNbu51rQOb/
         RqW1JSAdS9ipQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7FDEC04DD9;
        Fri,  3 Nov 2023 19:53:26 +0000 (UTC)
Subject: Re: [GIT PULL] livepatching for 6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZUOLil38w_VHEdvD@alley>
References: <ZUOLil38w_VHEdvD@alley>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZUOLil38w_VHEdvD@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching tags/livepatching-for-6.7
X-PR-Tracked-Commit-Id: 67e18e132f0fd738f8c8cac3aa1420312073f795
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 00657bb3dbecee324336e1da1ad71b670b6aee60
Message-Id: <169904120681.17286.4453249699265290666.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Nov 2023 19:53:26 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 2 Nov 2023 12:44:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching tags/livepatching-for-6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/00657bb3dbecee324336e1da1ad71b670b6aee60

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
