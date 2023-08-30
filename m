Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E5D78DDA8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245403AbjH3SwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343697AbjH3Qeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:34:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F721A2;
        Wed, 30 Aug 2023 09:34:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF58062298;
        Wed, 30 Aug 2023 16:34:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D204C433CA;
        Wed, 30 Aug 2023 16:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693413268;
        bh=u1OkkddUiLFqxmH8M4LGiObTDU1pKq9bw7U6WVhPr1E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=p41uPO0BxPw9kDoZn4L7VoEJBenJr6RNDh0X6yX/UXN9skolVP5g3w2WqtW27Dh9X
         xOiMaC4qdV5vxdac0QrUJrDXQih8lbRggfYAuutoUH4AjxKjLzqlu0eJPs+RNO6pNy
         qJ/yiImXno5iKufaqgSjf21HmbLquN+jrkPqEPwcMEadXtot2E97KdTXB8qMPuN+TQ
         6sByGp/voY2UudXb7h7M38G7hFRTLNK72ZgYRdaPIB0ZjgBhr4O8Z6T9FqDc2zmBpY
         fGRqfXnf38O7zYwO8CWYec4l8meuIRpBaCeLJ3ds285GBCzviGRaekX2IPuZGl3zSP
         5qGx462hQgfjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B469C64457;
        Wed, 30 Aug 2023 16:34:28 +0000 (UTC)
Subject: Re: [GIT PULL] Smack patches for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d8c21494-583f-8da2-a2cb-cd5410a13900@schaufler-ca.com>
References: <d8c21494-583f-8da2-a2cb-cd5410a13900.ref@schaufler-ca.com> <d8c21494-583f-8da2-a2cb-cd5410a13900@schaufler-ca.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <d8c21494-583f-8da2-a2cb-cd5410a13900@schaufler-ca.com>
X-PR-Tracked-Remote: https://github.com/cschaufler/smack-next tags/Smack-for-6.6
X-PR-Tracked-Commit-Id: 3ad49d37cf5759c3b8b68d02e3563f633d9c1aee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 872459663c52f5e8a28c0cb6df08b77d6c24ab46
Message-Id: <169341326830.28213.7024935199452285432.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Aug 2023 16:34:28 +0000
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 29 Aug 2023 16:44:24 -0700:

> https://github.com/cschaufler/smack-next tags/Smack-for-6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/872459663c52f5e8a28c0cb6df08b77d6c24ab46

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
