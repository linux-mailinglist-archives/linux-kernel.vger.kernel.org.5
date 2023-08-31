Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57D678E50C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 05:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345786AbjHaDUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 23:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345787AbjHaDUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 23:20:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2794E5A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 20:20:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F9426222B
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 03:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7E38C433C8;
        Thu, 31 Aug 2023 03:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693452034;
        bh=qnVY7TcL7F9DVVbLe5ol+jk4UrRGXfLLDDgbfU3Q5NE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dXFJlnr2qDLgaQHts4KyLn/DlOhKx1JGaLhyxGXbx7SOfZTbSMAmaz45dOkOSZpxg
         0Tzsc/BQ8Ot40EfCuYP+8BKvr5K6qP3Z+qWWCNjYkOLGMJW3/LoidbHeLwu1wB+7Ka
         jmgeqdKEer5o09PNLPrK0YIoNhCb2M+wvhWTq5ngZ+wI45SlStFv+PidN2sfYwgZht
         wB6TIrDlYCdu900I+YlcF+UpMqV8ENNj7pcBgqXW5h9SAOqxS8Yt12+YL8jINbDiDX
         g5xgfnv5q6MLhOD7j9/TLDCcAyrGnZjur9aqZ4jMe5ic/qVyTXuIQ6RKTI7zOfZrXf
         cOi3mVhDoegUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A4C38C3274C;
        Thu, 31 Aug 2023 03:20:34 +0000 (UTC)
Subject: Re: [GIT PULL] IPMI bug fixes for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZO5hymZPCRLHMMz7@mail.minyard.net>
References: <ZO5hymZPCRLHMMz7@mail.minyard.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZO5hymZPCRLHMMz7@mail.minyard.net>
X-PR-Tracked-Remote: https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.6-1
X-PR-Tracked-Commit-Id: d40f09c1a23024f0e550d9423f4d389672e1dfaf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a55b0a028877e9d7e7dacdbe363d39390554ba14
Message-Id: <169345203467.31998.4894933772556469203.pr-tracker-bot@kernel.org>
Date:   Thu, 31 Aug 2023 03:20:34 +0000
To:     Corey Minyard <minyard@acm.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 29 Aug 2023 16:23:22 -0500:

> https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.6-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a55b0a028877e9d7e7dacdbe363d39390554ba14

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
