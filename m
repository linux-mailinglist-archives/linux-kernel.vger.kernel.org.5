Return-Path: <linux-kernel+bounces-12890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB8281FC28
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 01:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 508251F21993
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 00:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0117E63A;
	Fri, 29 Dec 2023 00:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F51AE/Y+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4568A15A6;
	Fri, 29 Dec 2023 00:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F107C433C8;
	Fri, 29 Dec 2023 00:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703809047;
	bh=eSSN4KKzB2XOnkcmbwYQFa4UDz/rJO3Urd8y14awU0I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=F51AE/Y+2UjB47VEdlgkIbYQLBNPVlU6hpEtZKGdZyeHP3NajugTMtKYFINanKfv4
	 niPewYlUwgaAWgFqxBSEVyFooG0QNvyBuu3CnA0VR8fCPwASxZGovjsdU2gnKHAHh/
	 37XbLsbqFmJ1ZMiMBHXPBip4ImPZDqUe+B8l2Z+vhwToAHN1NN1YJE4SZJQnk8mf++
	 F1n3xw0XHtO+g20NGyFbOsC0yiu/z1Zjj27YTPQEb7sCOz9c6ffc6ihYxemCXJrkx3
	 yfbCxTDE+Eo3MtRjwavi/10Z93IRGArqpgG/wuD7SjSfWjK328NLE+BusDGj+O/YsV
	 Wggv+A2R/saLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE83BC4314C;
	Fri, 29 Dec 2023 00:17:26 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd server fix
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5msxiNuCoXCvEF0X=7gdxD4-_X=E0b8mE_k7e=8HHz-VpQ@mail.gmail.com>
References: <CAH2r5msxiNuCoXCvEF0X=7gdxD4-_X=E0b8mE_k7e=8HHz-VpQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5msxiNuCoXCvEF0X=7gdxD4-_X=E0b8mE_k7e=8HHz-VpQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/6.7rc7-smb3-srv-fix
X-PR-Tracked-Commit-Id: d10c77873ba1e9e6b91905018e29e196fd5f863d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8735c7c84d1bc5c3e481c02b6b6163bdefe4132f
Message-Id: <170380904696.28076.3961045483590418430.pr-tracker-bot@kernel.org>
Date: Fri, 29 Dec 2023 00:17:26 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Namjae Jeon <linkinjeon@kernel.org>, CIFS <linux-cifs@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 28 Dec 2023 16:09:28 -0600:

> git://git.samba.org/ksmbd.git tags/6.7rc7-smb3-srv-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8735c7c84d1bc5c3e481c02b6b6163bdefe4132f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

