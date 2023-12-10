Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EBC80BCAD
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 20:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjLJTMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 14:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJTML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 14:12:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E558E8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 11:12:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04EB7C433C8;
        Sun, 10 Dec 2023 19:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702235538;
        bh=OBgho9S8DE+BbMJEFCO6gAmVLt74G8J0r8T1zE2Ai9w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=If1aQRS2zGoMU/gA+8Sf7nELMNAq/K4oJJCtMJ0v/U3+a2S4uMLl9pgoqtDZ0etbL
         uvIx1JbwJ1JSyHJsPBixaleFr+Q+zhl2F5D/9cWQv0CUQWX/tGwGVg8Ol677pXQhaV
         OwQqKu2pX7PP5EnEH0v8mFrI0kaXyGvJ5N9PckQuQrqqqCyBPfHnnNHHehrcW0/wqF
         o+g7VYD67kmoF7Uh0oj7F0MkJi+RWxGuzhhE92bTwbQSaFApWPQF3BRmB9OpM9Zfyx
         +N3YCFHwIV4ZZ6SnjMNK9agmRdcNxmJZXqhP/M9ISNUagb9bpQQyi/ZtVtLNm6o3JM
         HaKTVB8HBLoog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E6B4BC04E32;
        Sun, 10 Dec 2023 19:12:17 +0000 (UTC)
Subject: Re: [GIT PULL] KVM fixes for Linux 6.7-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231210110101.2435586-1-pbonzini@redhat.com>
References: <20231210110101.2435586-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231210110101.2435586-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: 4cdf351d3630a640ab6a05721ef055b9df62277f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0aea22c7ab05f9dfebbccf265a399331435b8938
Message-Id: <170223553793.2016.2840443282804935759.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Dec 2023 19:12:17 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Dec 2023 06:01:01 -0500:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0aea22c7ab05f9dfebbccf265a399331435b8938

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
