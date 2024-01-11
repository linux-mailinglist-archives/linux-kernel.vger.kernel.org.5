Return-Path: <linux-kernel+bounces-23737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D12982B0FE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C000E2858AD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F3351035;
	Thu, 11 Jan 2024 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHSuOLPK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A12B4B5A7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 14:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB054C43141;
	Thu, 11 Jan 2024 14:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704984637;
	bh=mAiijGHiSfZsTFrUYq/Jmg4J9ygxl7AwTDFZGVX0vqc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tHSuOLPKewEXoCsknWKaTh4RYAHl4+uYdYWx5duufMLrcPbfDgXWGNjlNtXn48G0t
	 BDseeq5T3vhQG+6Zye+zLho51hZoSm1bQi/jH1FTZyR4Jx+heS+BFMaqod8dKEHTaj
	 IHYB2vFNZYLquw5uTFYzRf2wYQw7e9mWDCVOrYmILpQGzvpgzZ71RFxUGQeEWPTnw3
	 M3TrDLzroKZVHTpgJSGU/bpYJ0Rp9u872xNsaXCWK0Y00b8b2kfZdjmvfLFbVwurmS
	 Lk9VDXpucd4bkqD0VVuH7pARPR1vN2QN2ku0eI6urTMStZETyWfWpC0rBIHgmlDcmU
	 BvpH9hq4+FPhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C42FAD8C97B;
	Thu, 11 Jan 2024 14:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH --fixes] riscv: Remove SHADOW_OVERFLOW_STACK_SIZE macro
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170498463780.20080.3843533399150814207.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jan 2024 14:50:37 +0000
References: <20231211110331.359534-1-songshuaishuai@tinylab.org>
In-Reply-To: <20231211110331.359534-1-songshuaishuai@tinylab.org>
To: Song Shuai <songshuaishuai@tinylab.org>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, guoren@kernel.org,
 samitolvanen@google.com, conor.dooley@microchip.com, bjorn@rivosinc.com,
 debug@rivosinc.com, greentime.hu@sifive.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 11 Dec 2023 19:03:31 +0800 you wrote:
> The commit be97d0db5f44 ("riscv: VMAP_STACK overflow
> detection thread-safe") got rid of `shadow_stack`,
> so SHADOW_OVERFLOW_STACK_SIZE should be removed too.
> 
> Fixes: be97d0db5f44 ("riscv: VMAP_STACK overflow detection thread-safe")
> Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
> 
> [...]

Here is the summary with links:
  - [--fixes] riscv: Remove SHADOW_OVERFLOW_STACK_SIZE macro
    https://git.kernel.org/riscv/c/a7565f4d068b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



