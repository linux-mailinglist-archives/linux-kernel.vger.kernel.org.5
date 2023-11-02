Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BA67DFA11
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377339AbjKBSiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377327AbjKBSiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:38:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ADB18B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:38:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14F91C433C9;
        Thu,  2 Nov 2023 18:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698950285;
        bh=KGhMRzByxSAbEadCRRCxcmp5V9nQAD0adRDrZgPYNZI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kmUmRpBWjCvm1FrVEoNeErsIWKeDWMB8Yut7uVNpTz03Hta4zefmMO/6aciYgcWvz
         Qe3f+0sg6GiQ8CxU3GMmO5rh0aRr2Ht3AxYf/S2BZ+2wuvNybKZRWr/gVCWuv4OX4y
         AeJmI97cuu/c4OMLJwymiHEr3NniAaKRHGvXJGiCgqz84++YuV1bxK/uYy2pP/hZGw
         +BE7kzuTW/EQoJicJw1118k+E6i8vGBe2SWwECYoi60ffDn3VbMH8OBB3+mNru2f+J
         6Qt5ITQwdKGQH8G3qMTiQAoPKEwez4bRFBVpcW4Z7tR76Gb0RaHbe4BAELJfx0GRL7
         UQh766ZedczAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01AB4C43168;
        Thu,  2 Nov 2023 18:38:05 +0000 (UTC)
Subject: Re: [GIT PULL] dlm updates for 6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZUET3DN7wTih6rKm@redhat.com>
References: <ZUET3DN7wTih6rKm@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZUET3DN7wTih6rKm@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.7
X-PR-Tracked-Commit-Id: eb53c01873cab75d0bf42e6d685dc5ef3b68d884
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91a683cdf602a593ea1f7783346a605e0cd470df
Message-Id: <169895028500.19486.13843843292063424757.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Nov 2023 18:38:05 +0000
To:     David Teigland <teigland@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 Oct 2023 09:49:00 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91a683cdf602a593ea1f7783346a605e0cd470df

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
