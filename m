Return-Path: <linux-kernel+bounces-1951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B596815648
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 03:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577A2286182
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F941C3F;
	Sat, 16 Dec 2023 02:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLsNSErK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BB115B9;
	Sat, 16 Dec 2023 02:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22AFDC433C9;
	Sat, 16 Dec 2023 02:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702692625;
	bh=DfJ+bv2uP/EXrVEPsZCt6Py3/DrsGztH6oFNdIAkrRA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LLsNSErKKN9rKC4Cdh8sf7YkJtLvdnFdqPt+b5vnYqZqyVq3NZ6Hg/VkEUmJYHTUH
	 sU6lHDYR4+CxZEcul1f73fPlFfMYPNdheu3PP8OhN8R5DDWYeUJT9EV8joyudRYcfw
	 RaZkk7w+NxrdQ5+0hoaHD8QBKkxnBfktW5zB7hIy5S280P9+rOwAy1jl3KluM9xxa8
	 ErD+GoGPOTnuTuQ6AcPJDpYCh5+B+7CL4u0w9Q6Qn0tiAoa4iBdxkwfQ4+XpPUdNeC
	 kr3Z5TEe0q+u3zSs2zHWF+9EB9ibEGtbZU7t5fijXy+C0yNa23PDGkEVk7Of/IRrgQ
	 lHg0mBd6frUaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F3773C4166E;
	Sat, 16 Dec 2023 02:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dt-bindings: net: marvell,orion-mdio: Drop "reg"
 sizes schema
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170269262499.31252.15989898401960537918.git-patchwork-notify@kernel.org>
Date: Sat, 16 Dec 2023 02:10:24 +0000
References: <20231213232455.2248056-1-robh@kernel.org>
In-Reply-To: <20231213232455.2248056-1-robh@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 andrew@lunn.ch, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Dec 2023 17:24:55 -0600 you wrote:
> Defining the size of register regions is not really in scope of what
> bindings need to cover. The schema for this is also not completely correct
> as a reg entry can be variable number of cells for the address and size,
> but the schema assumes 1 cell.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] dt-bindings: net: marvell,orion-mdio: Drop "reg" sizes schema
    https://git.kernel.org/netdev/net-next/c/758a8d5b6a64

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



