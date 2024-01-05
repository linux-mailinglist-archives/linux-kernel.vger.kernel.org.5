Return-Path: <linux-kernel+bounces-18383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 105B7825C42
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 22:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C189285BB8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178FC3609E;
	Fri,  5 Jan 2024 21:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDb6/Lrk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6280F2DF98;
	Fri,  5 Jan 2024 21:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EABEAC43395;
	Fri,  5 Jan 2024 21:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704491428;
	bh=pxH3U9z6khx6tVHIWqaGql+jUBJveUc94c4ZoAPEGGw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PDb6/LrkfooIlMm82I88mGQhEXQJW8ViFM/Tz44pviB3OSSSGgxcOYwOk5/iS3l5E
	 6896QZax1frH6o66NaAcQIq/c6xxZmaw8yEJDPthHuhGD9R3zw4ARSP3PDpfbdcjhw
	 kgRuvPXlHJAmcKwBC7imZYworvWieB3g8trxxrJctwfXCQp0BmNsyI2Ny6h/c2nUBA
	 TuyCmg/PfR8DnxE3A+dRFKHwq6u6wpcLAr3R2kmvxQ2uFuqRCl7kiSbdgIth1f+plT
	 fwOgYxZqzEVGSuwt4pjyeThQpEtLySJKb/7zOKpzVoKci3PbhoWIcqan347hQSVqQg
	 e9LZovdjaKx8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D623EC4167E;
	Fri,  5 Jan 2024 21:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] dt-bindings: riscv: cpus: Add AMD MicroBlaze V compatible
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170449142786.26226.3590037133806155543.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jan 2024 21:50:27 +0000
References: <d442d916204d26f82c1c3a924a4cdfb117960e1b.1699270661.git.michal.simek@amd.com>
In-Reply-To: <d442d916204d26f82c1c3a924a4cdfb117960e1b.1699270661.git.michal.simek@amd.com>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com,
 aou@eecs.berkeley.edu, conor@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
 devicetree@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 6 Nov 2023 12:37:47 +0100 you wrote:
> MicroBlaze V is new AMD/Xilinx soft-core 32bit RISC-V processor IP.
> It is hardware compatible with classic MicroBlaze processor.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - dt-bindings: riscv: cpus: Add AMD MicroBlaze V compatible
    https://git.kernel.org/riscv/c/4a6b93f56296

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



