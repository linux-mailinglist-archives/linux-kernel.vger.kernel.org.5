Return-Path: <linux-kernel+bounces-2746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0D4816149
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B10891C21954
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B54F46550;
	Sun, 17 Dec 2023 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLFHw23C"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3C246537
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 17:38:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A8CAC433C7;
	Sun, 17 Dec 2023 17:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702834681;
	bh=u3754chIscoj5hXYRWTd00CFQmDIGAosRSu3ITw7K00=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SLFHw23CZxA+xVyaWOrngTHqKpqQ4C72gaKlX+4CNIJAV2V+QqmTOo9zPM5uK6vI5
	 o5b/ebVM13+pECeTE/PZdI1A4pt7DqFraUuh6XgrcODUJBE/TyGBzp1bart2/1r9ak
	 2frQ+z7g1nqjPwRlvi/bbISlhLJ/CTEiccQdKLvg87YUnc922ort5bYRO5lRO+ziMs
	 AXWlqt24iEV/2jfOG5sMNkHef6B3YOetfraoozYEpbloZCzB8ddA7ptaTNrx+LsfSc
	 Sg0f5/WLCsQWN3ldpq9WtzKMUvKFS20CDKk4U37Rs2z6H9tbJ+YHodJ735k7YE+LHX
	 PIrEiVJsixHeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 12C6AC4314C;
	Sun, 17 Dec 2023 17:38:01 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.7-5 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <875y0xmlda.fsf@mail.lhotse>
References: <875y0xmlda.fsf@mail.lhotse>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <875y0xmlda.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.7-5
X-PR-Tracked-Commit-Id: d2441d3e8c0c076d0a2e705fa235c76869a85140
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ef3720d91285f7ebc49d17366b366818516b768
Message-Id: <170283468102.25242.8126551832309210733.pr-tracker-bot@kernel.org>
Date: Sun, 17 Dec 2023 17:38:01 +0000
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, aneesh.kumar@kernel.org, linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com, linux-kernel@vger.kernel.org, naveen.n.rao@linux.ibm.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 17 Dec 2023 16:46:57 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.7-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ef3720d91285f7ebc49d17366b366818516b768

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

