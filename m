Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4FE7B71C3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240915AbjJCTcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 15:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjJCTco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:32:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C367A1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 12:32:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38986C433C9;
        Tue,  3 Oct 2023 19:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696361559;
        bh=fE5g4MWg+qMZpJxoclaJ+aFEyjhuKvcxzzWK8B+sBpw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gscD75XJ5tp5sWwGfwuNe7B5JeIiQDm2tpIr4FaPrQ31O6zMvg/YPxv+QVCQdZdb7
         9ArPsrcooUQiJAk85QCWksXymX2FulEye7+54RKBJAyCajN/cxQjzj9UyfVhtrIrDS
         QeMKwmrCPP4oiOiBynIQpIhljDlz4ibkXwFEMkt4J6cKCjURaw6H+hb0kvlYAc3NiB
         kmfrf5Uf2wwfSwDtpgL0aCcEt+dc2ViniMtGXaB4HlkolnvNuWgxcG6bhdQ1Hlt3q4
         jnWPhRSBMo6Tnf5aSj0IykolEDc5a+FfIjyBatUAVTT9RNaIzAmNqhmJE/qJe2Celt
         9j3Dmx7o/PV5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 26096E632D8;
        Tue,  3 Oct 2023 19:32:39 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v6.6-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231003180719.2B712C433CA@smtp.kernel.org>
References: <20231003180719.2B712C433CA@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231003180719.2B712C433CA@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.6-rc4
X-PR-Tracked-Commit-Id: 6e800968f6a715c0661716d2ec5e1f56ed9f9c08
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7cccbeca90151fcd5d1afa8b22c2e2832bc5f197
Message-Id: <169636155915.2158.15438111868489542020.pr-tracker-bot@kernel.org>
Date:   Tue, 03 Oct 2023 19:32:39 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 03 Oct 2023 19:07:11 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.6-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7cccbeca90151fcd5d1afa8b22c2e2832bc5f197

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
