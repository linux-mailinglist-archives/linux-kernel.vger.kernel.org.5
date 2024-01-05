Return-Path: <linux-kernel+bounces-18379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC96825C3D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 22:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75BAA1C239C3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A9335F12;
	Fri,  5 Jan 2024 21:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLLQHEZY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E2725116
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 21:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4E79C433CA;
	Fri,  5 Jan 2024 21:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704491427;
	bh=TbP2ZiKWNQumHFHTZE3CH6DZOuJ/7CINRHp6fTS6928=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sLLQHEZYyfz+Z9ZaAbStkoUPxk7s0nTs8Jz6auG/Dj5S/m96kPcB13Wm3UJIcjFuI
	 9PuK4e2ysWlYh73h3ryG0mq//DpqvHRc/GVTggwRF4xd07rFSeHQnt64IxstT49Zw7
	 Xd0LWRFFBuEaEsLUaulQ+Lor/7XiCo+f/VeQcR+/k9JSBOBHVhNJ6hAKB7wENmLoLi
	 gDp5G+EgLYwAzb95EYL1J56kMl0c0BtdbhjNdgj32xsA78NLrtDkI6Df1ApkdE227P
	 U53T2ZNhvrb8tE4kLDbJ96Xk8XcR7ws0m/nSwV9AJBNUXjuwBFxZkl/7wkGL3gEVlH
	 H2wI3d3h5sT+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B007DC41606;
	Fri,  5 Jan 2024 21:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Select ARCH_WANTS_NO_INSTR
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170449142771.26226.4393775934262321528.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jan 2024 21:50:27 +0000
References: <20231123142223.1787-1-jszhang@kernel.org>
In-Reply-To: <20231123142223.1787-1-jszhang@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, nathan@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 23 Nov 2023 22:22:23 +0800 you wrote:
> As said in the help of ARCH_WANTS_NO_INSTR entry in arch/Kconfig:
> "An architecture should select this if the noinstr macro is being used on
> functions to denote that the toolchain should avoid instrumenting such
> functions and is required for correctness."
> 
> Select ARCH_WANTS_NO_INSTR for correctness.
> 
> [...]

Here is the summary with links:
  - riscv: Select ARCH_WANTS_NO_INSTR
    https://git.kernel.org/riscv/c/5a2cf779e677

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



