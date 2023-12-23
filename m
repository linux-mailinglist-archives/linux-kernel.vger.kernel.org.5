Return-Path: <linux-kernel+bounces-10274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD9D81D1FB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25C91F24685
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430F5211A;
	Sat, 23 Dec 2023 03:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3NOm9av"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CE417C8;
	Sat, 23 Dec 2023 03:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6662EC433C7;
	Sat, 23 Dec 2023 03:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703303158;
	bh=peEVycI6ElFnVJRmCAdNiiO1vErpWhbRwQOHIvIy2YI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=L3NOm9avELFDIA6fpW+HCAwK5ivzRZt1uDIjw7P1ct44tU7ngXhdD4B6yIYM1Rzax
	 cfZgxPOB5omC+hyvD9SkYpTHYKQLw3QgMrxmNDsY9qBcuqGA48OAOC9Ctf0iJsMRz2
	 juGXC4BIbYlLlZjSUEYOJI7JI6DqHwmFPQJvZYJOKorDNTg39Ob4tP4Exva/fseWY3
	 LgJX0UJQS5roZ/7/NfNBphjy2SRyPXACTWi8Ra3NXDI5Mjh38C6o+1PXTlvxTIUO7s
	 KB+N1i5bHQr+LPOla8X/VWke5MI94UsCkMXuhEzHOS87jCKMW18JVaCxrtKIrxVtjK
	 OQ5cJOW7jpAvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54D1BDD4EE0;
	Sat, 23 Dec 2023 03:45:58 +0000 (UTC)
Subject: Re: [GIT PULL] KVM fixes for Linux 6.7-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231222231544.3333693-1-pbonzini@redhat.com>
References: <20231222231544.3333693-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231222231544.3333693-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: ef5b28372c565128bdce7a59bc78402a8ce68e1b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 867583b3991929aeea3844874fba598243c54240
Message-Id: <170330315833.32157.15161802928126643067.pr-tracker-bot@kernel.org>
Date: Sat, 23 Dec 2023 03:45:58 +0000
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Dec 2023 18:15:44 -0500:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/867583b3991929aeea3844874fba598243c54240

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

