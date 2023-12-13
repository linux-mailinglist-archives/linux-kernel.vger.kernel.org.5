Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C081081078F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 02:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378190AbjLMBVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 20:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378186AbjLMBVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 20:21:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2F8FD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 17:21:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42FF0C433C8;
        Wed, 13 Dec 2023 01:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702430501;
        bh=UagFG6yzzSkpog20vGGfPgMR1c5VVd6SeOW1ODUaYdc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jZvWiK9ziuPovFgaRNH6WWXsUDh+X5WDMIZ0n6jGcHjL/mi7AE7HduJUrNT4EFId+
         cOC6lHK5P88j4IMmV7V0p3f4Y0D0po6fNCn7qg1zy69jVV/cbeRRt/31b5NE8adR9v
         ZwFO8+A0qmeasJrQ8yFbDqnS+sK8sA4FaiOew4iXzNuFbO4tVfREt3YOBEFtz/sCof
         aS2WzHSu+ZlQLSlpr206reTtc4olmPo3PDhMTdvoPdi4Z4JVbiYBMyKxAcqjFA9DWG
         9DhOocpZDrgG0957QQ6NlenwWeSiYQ97+PIkXMV9KZ3ik33UKObfeiIjHv7lTXJJLY
         cQt+z4pRU0BPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32944DFC906;
        Wed, 13 Dec 2023 01:21:41 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2312122348040.24250@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2312122348040.24250@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2312122348040.24250@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2023121201
X-PR-Tracked-Commit-Id: df83a0df820b9b705e51b9499691b0dafb2f4dcb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 88035e5694a86a7167d490bb95e9df97a9bb162b
Message-Id: <170243050119.5563.15151724772441305290.pr-tracker-bot@kernel.org>
Date:   Wed, 13 Dec 2023 01:21:41 +0000
To:     Jiri Kosina <jkosina@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 12 Dec 2023 23:51:55 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2023121201

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/88035e5694a86a7167d490bb95e9df97a9bb162b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
