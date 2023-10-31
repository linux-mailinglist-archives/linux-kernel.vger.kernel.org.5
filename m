Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307197DC697
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 07:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbjJaGbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 02:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbjJaGbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 02:31:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716CEC2;
        Mon, 30 Oct 2023 23:31:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1752EC433CD;
        Tue, 31 Oct 2023 06:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698733883;
        bh=ApQkDd85wUbY0PMZXjhXDFroN+Ix/PTCpCR2qDoyuPA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PsKQMLnMwQkeA/2I4WItj/7XUDziC362eyhzWHSZBrB2z2ic+T3sc5DBjCF8MiJZo
         ujeTpCkNh51NJRN7KngvObHgMdnFsZE/ytECaLLGTAJkitTlhGMWgnHSWq179tGZJy
         HpCUC9EKRqhiHZaNCi9yn7uX048eypJyUeEBeHdyN8KAFMgS2M75CCCI0NqQNY/NAN
         BLKIU+ryoJjWrEVOH957PXEvsyTx0O/PO45L2q0LfIk0LIAWb4+bO7SNfdauBroNfs
         rdZtlryOap7a2V6p25tpJ71JrSEmRbZGsVBnD3hY4mvp2Nm4WG2uosXAYkfelOk5NF
         C+G74yRQ7HAPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03A36C4316B;
        Tue, 31 Oct 2023 06:31:23 +0000 (UTC)
Subject: Re: [GIT PULL] lsm/lsm-pr-20231030
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1cf859668ed2841067c50ebcaf01908f.paul@paul-moore.com>
References: <1cf859668ed2841067c50ebcaf01908f.paul@paul-moore.com>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <1cf859668ed2841067c50ebcaf01908f.paul@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20231030
X-PR-Tracked-Commit-Id: e508560672890b2873c89258b88fade1356392ce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b93c2c3c02f4243d4c773b880fc86e2788f013d
Message-Id: <169873388301.12768.12036785752006706724.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Oct 2023 06:31:23 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Oct 2023 22:25:27 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20231030

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b93c2c3c02f4243d4c773b880fc86e2788f013d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
