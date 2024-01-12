Return-Path: <linux-kernel+bounces-25098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AD982C7F4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 823F4B233EF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD691A707;
	Fri, 12 Jan 2024 23:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIRyPArP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E171A701;
	Fri, 12 Jan 2024 23:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 551A1C433F1;
	Fri, 12 Jan 2024 23:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705101933;
	bh=RzE4poQrJ2Dd7IEpmmlFm/TAoW7IjsSYM8S1tGq2MDs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YIRyPArPcyXLvn1k8+vMCYwSqyooD8j36Bmpv7ZToUg9MKS/uBCp4fYE03YkpvnIn
	 IW/3T6TcjzYVxsqdI3wAFn6KV6swhRR7AER8g3S5rbO9LWSgJrmqKixQKOVgeJGQ7/
	 oi5w+5jmF2LYcytqhgu61MBUUXVQqoAH0UgVBYOV6pJniZ18m+o3tgmaGQKrJDRjef
	 nrbnyHNP4D4jLLTl1vXNGPYv9jc5dhqWcSzKCzs/E7tqoiFc7zcZEHBEe5XylAWkHo
	 Vk6SuI0aCekrkO1T+a26zFXSOQFqJtJ5aOGISyE92BQB3TU2DPcp04AE+/MBSr8Mjs
	 kutgM+p0K3x2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 44761D8C96D;
	Fri, 12 Jan 2024 23:25:33 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree updates for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240112153227.GA3368286-robh@kernel.org>
References: <20240112153227.GA3368286-robh@kernel.org>
X-PR-Tracked-List-Id: <devicetree.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240112153227.GA3368286-robh@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.8
X-PR-Tracked-Commit-Id: 716089b417cf98d01f0dc1b39f9c47e1d7b4c965
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 38814330fedd778edffcabe0c8cb462ee365782e
Message-Id: <170510193327.16457.8447808714830856917.pr-tracker-bot@kernel.org>
Date: Fri, 12 Jan 2024 23:25:33 +0000
To: Rob Herring <robh@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Frank Rowand <frowand.list@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jan 2024 09:32:27 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/38814330fedd778edffcabe0c8cb462ee365782e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

