Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD250788F46
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 21:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjHYTex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 15:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjHYTec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 15:34:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF692685;
        Fri, 25 Aug 2023 12:34:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 343956315B;
        Fri, 25 Aug 2023 19:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D08DC433C7;
        Fri, 25 Aug 2023 19:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692992069;
        bh=ofVU3PXDgGDaUg429GaDJh1BkO66D0bI9BSbASRkJK4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SXjdGVbLy25HVQfDsBE/ocrQtwh0y9zNMn0Cn1hzloqfFxksDA84j168k1mfPonj/
         bBKW+o3ipVDICQHOI47jk+klQprfjGlaW6S4rIkeWa4qTwestCGtk/v04eWIv2QBLD
         RlGTM7z/Y+N4jI8ZSueUbGq5LvEGKPNcnGJXASiGkYepAmNpEdksrdcK2ueVm38Kcw
         3dBoJL7i/1BOA87KlDblk8ciEXI5GnNVAdmtZNCua6QmOHF/G5ahiRq7xgsvcqNEMb
         BhpbfWN91Rl7lcIsypfCFVUvPe9JfhxbQedIIZJybkLtg34bdaHAp1rmA1YXqDR0Cz
         YgPHdHR0V2HcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 880ACC595D7;
        Fri, 25 Aug 2023 19:34:29 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230825111108.898f1600c365d22f74e52c70@linux-foundation.org>
References: <20230825111108.898f1600c365d22f74e52c70@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20230825111108.898f1600c365d22f74e52c70@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-08-25-11-07
X-PR-Tracked-Commit-Id: e5548f85b4527c4c803b7eae7887c10bf8f90c97
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f0edbb833ec16ab2042073af4846152b455104d
Message-Id: <169299206954.5937.14500170963196774973.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Aug 2023 19:34:29 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Aug 2023 11:11:08 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-08-25-11-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f0edbb833ec16ab2042073af4846152b455104d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
