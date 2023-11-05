Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248977E1223
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 04:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbjKEDCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 23:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbjKEDCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 23:02:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19957D57
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 20:02:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C93AC433C8;
        Sun,  5 Nov 2023 03:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699153332;
        bh=tjX4P64KWFgiRv2UgEyo64KDpWbiMHrsNy1svVfnBiQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Y7A2TTfHKpYCHnT4+1vA96yHSsuPBBPNaENsVOIn8Qp2uStPUCE6rLCzXyKaVrfqJ
         9KYNBtVHlf2c+iOnVZ3SrXRQZR3rMESyMNmL+/i+DKgjMK8AEVPWLXM9PUfbjb25+C
         N7ZDeBHxDfUUv1SpXlPO2uIMOvCRp23cV72mXLcM2G2yEVUOQm13dIBvrUt7Q2vewC
         iURnR9hGjmRgtYg92hyXZfyPTAkH1cn1OmOSWKJfg1kOGYrNACIPtZ+opK+FxumhqU
         a9wV0mJkWPyWoTEV9+dXjUGSLczLqhVX2+rfePayGf8C15C+n2Smj6pG8t+xdQEFLR
         BuQovzR0m60kA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78B0AC4316B;
        Sun,  5 Nov 2023 03:02:12 +0000 (UTC)
Subject: Re: [GIT PULL] configs-tsm: Unified attestation report ABI for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <654438f4ca604_3f6029413@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <654438f4ca604_3f6029413@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-List-Id: <linux-coco.lists.linux.dev>
X-PR-Tracked-Message-Id: <654438f4ca604_3f6029413@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/djbw/linux tags/tsm-for-6.7
X-PR-Tracked-Commit-Id: f4738f56d1dc62aaba69b33702a5ab098f1b8c63
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e2cb28dd7e182dfa641550dfa225913509ad45d
Message-Id: <169915333248.2133.17766763137811196506.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Nov 2023 03:02:12 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     torvalds@linux-foundation.org, linux-coco@lists.linux.dev,
        Erdem Aktas <erdemaktas@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Peter Gonda <pgonda@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Alexey Kardashevskiy <aik@amd.com>,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 2 Nov 2023 17:04:04 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/djbw/linux tags/tsm-for-6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e2cb28dd7e182dfa641550dfa225913509ad45d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
